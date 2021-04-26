import os
import requests
import pathlib

from bs4 import BeautifulSoup
from requests import HTTPError

from rest_framework.exceptions import ValidationError

from config.settings import (SERVICE_SIGNATURE_TEMPLATES, SERVICE_SIGNATURE_HOST, SERVICE_SIGNATURE_PRIVATES)


# Create your services here.

class SignatureService:
    CERTIFICATE_CA = '2.pem'
    CERTIFICATE_KEY = '3.pem'
    CERTIFICATE_CHAIN = '1.pem'

    # DataService - it will help to work with data
    data_service = None

    # Signature
    private = None
    private_key = ''
    sign_template = os.path.join(pathlib.Path().absolute(), f'{SERVICE_SIGNATURE_TEMPLATES}/sign_template.xml')
    host = SERVICE_SIGNATURE_HOST

    certificate_path = None

    def __init__(self, issuer: str = 'private'):
        self.private = os.path.join(pathlib.Path().absolute(), f'{SERVICE_SIGNATURE_PRIVATES}/{issuer}.pem')
        with open(self.private, 'r') as key:
            data = key.read()

        self.private_key = data

    def set_certificate_path(self, certificate_path):
        self.certificate_path = certificate_path

    def set_data_service(self, data_service):
        self.data_service = data_service

    def get_signature(self, xml: str):
        sign_data = self.prepare_sign_file_for_request(xml)
        return self.make_request(sign_data)

    def prepare_sign_file_for_request(self, xml):
        xml_hex = self.data_service.to_hex(xml)
        xml_hex_base64 = self.data_service.base64_encode_binary(xml_hex)

        template_data = self.get_sign_template_data()
        template_data = template_data.replace('$dat', xml_hex_base64)
        template_data = template_data.replace('$private_key', self.private_key)

        return template_data

    def get_sign_template_data(self):
        with open(self.sign_template) as f:
            data = f.read()

        return data

    def make_request(self, sign_data):
        try:
            ca = f'{self.certificate_path}/{self.CERTIFICATE_CA}'
            key = f'{self.certificate_path}/{self.CERTIFICATE_KEY}'
            chain = f'{self.certificate_path}/{self.CERTIFICATE_CHAIN}'

            headers = {
                'Content-Type': 'text/xml;charset=UTF-8',
                'SOAPAction': ''
            }

            response = requests.post(self.host,
                                     headers=headers,
                                     data=sign_data,
                                     cert=(ca, key),
                                     verify=chain)

            response.raise_for_status()
        except HTTPError as error:
            raise ValidationError(detail={'detail': error})
        except Exception as error:
            raise ValidationError(detail={'detail': error})

        return self.prepare(response.content)

    def prepare(self, response):
        soup_data = BeautifulSoup(response, 'xml')
        body = soup_data.find('Body')
        pki_sign = body.find('pkiSignXAdESResponse')
        data = pki_sign.find('data').text

        return self.data_service.base64_decode(data)
