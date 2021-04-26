from abc import ABC

import requests
import pathlib
import os
import sys

from urllib.parse import urlencode, quote_plus

from requests import HTTPError

from applications.reports.process.reporting_service import ReportingService

from config.settings import (SERVICE_BIC_PASSWORD, SERVICE_BIC_USERNAME,
                             SERVICE_BIC_HOST, SERVICE_SIGNATURE_TEMPLATES, SERVICE_SIGNATURE_CERTIFICATES)

from rest_framework.exceptions import ValidationError


# Create your services here.

class ProcessService(ReportingService, ABC):
    # Credentials
    username = SERVICE_BIC_USERNAME
    password = SERVICE_BIC_PASSWORD

    # Delivery types
    DELIVERY_ONLINE = 'ONLINE'
    DELIVERY_DISK = 'DISK'
    DELIVERY_ONLINE_DISK = 'ONLINE/DISK'

    # BIC host
    host = SERVICE_BIC_HOST

    # Template folder
    template_folder = os.path.join(sys.path[0], SERVICE_SIGNATURE_TEMPLATES)

    DELIVERY_TYPES = (DELIVERY_ONLINE, DELIVERY_DISK, DELIVERY_ONLINE_DISK)

    def __init__(self, data_service=None, sign_service=None):
        super().__init__(data_service, sign_service)

        # Passing credentials for BICDataService
        self.data_service.set_credentials(self.username, self.password)

        # Passing DataService to
        sign_service.set_data_service(self.data_service)

    def make_request(self, **kwargs):
        try:
            data = kwargs.get('data')
            headers = {
                'Content-type': 'application/x-www-form-urlencoded'
            }
            response = requests.post(self.host, headers=headers, data=data)
            response.raise_for_status()

        except HTTPError as error:
            raise ValidationError(detail={'detail': error})
        except Exception as error:
            raise ValidationError(detail={'detail': error})

        return response.content

    def execute(self):
        certificate_path = os.path.join(pathlib.Path().absolute(), SERVICE_SIGNATURE_CERTIFICATES)

        # Setting up certificate
        self.sign_service.set_certificate_path(certificate_path)

        # Obtaining data
        xml = self.data_service.generate()

        print(f'[Executing - XML]:\n{xml}')

        # Getting sign
        sign = self.sign_service.get_signature(xml)

        print(f'[Executing - Sign]:\n{sign}')

        # Forming request
        payload = {'xml': xml, 'sign': sign}
        request_data = urlencode(payload, quote_via=quote_plus)

        # Making request
        response = self.make_request(data=request_data)

        # Preparing data
        return response
