import os
import pathlib

from lxml import etree

from abc import ABC
from datetime import datetime

from xml.etree import ElementTree

from applications.reports.process.flow_data_service import FlowDataService


class DataService(FlowDataService, ABC):
    # Credentials
    username = ''
    password = ''

    # Language - The field format is `languageCountry` (ex enUS)
    # according to ISO 639-1 and ISO 3166-1
    language = 'roRO'

    def __init__(self, company=None, delivery=None):
        super().__init__()

        self.company = company
        self.delivery = delivery

    def set_credentials(self, username: str, password: str):
        self.username = username
        self.password = password

    def generate(self, **kwargs):
        xml = ElementTree.Element('root')
        ElementTree.SubElement(xml, 'delivery', {'method': self.delivery})

        # Credentials
        security = ElementTree.SubElement(xml, 'security')

        username = ElementTree.SubElement(security, 'username')
        password = ElementTree.SubElement(security, 'password')

        username.text = self.username
        password.text = self.password

        # Language
        language = ElementTree.SubElement(xml, 'language')
        language.text = self.language

        request_timestamp = ElementTree.SubElement(xml, 'request_timestamp')
        request_timestamp.text = datetime.now().strftime('%d-%m-%Y %H:%M:%S')

        # Forming credit report requests
        cr_requests = ElementTree.SubElement(xml, 'cr_requests')

        for request_counter, company in enumerate([self.company]):
            request_counter = request_counter + 1
            parameters: dict = self.entity_parameters(company)

            # Forming single credit report requests
            cr_request = ElementTree.SubElement(cr_requests, 'cr_request')

            cr_id = ElementTree.SubElement(cr_request, 'id')
            cr_id.text = str(request_counter)

            customer_type = ElementTree.SubElement(cr_request, 'customer_type')
            customer_type.text = parameters.get('counterparty_type')

            include_sivabon = ElementTree.SubElement(cr_request, 'include_sivabon')
            include_sivabon.text = parameters.get('report_bic')

            include_fisc = ElementTree.SubElement(cr_request, 'include_fisc')
            include_fisc.text = parameters.get('report_sfs')

            include_bns = ElementTree.SubElement(cr_request, 'include_bns')
            include_bns.text = parameters.get('report_bns')

            if parameters.get('report_bns') == '1':
                include_bns_year = ElementTree.SubElement(cr_request, 'bnsYear')
                include_bns_year.text = parameters.get('report_bns_year')

            idno_idnp = ElementTree.SubElement(cr_request, 'idno_idnp')
            idno_idnp.text = parameters.get('fiscal_code')

            inquiry_purpose = ElementTree.SubElement(cr_request, 'inquiry_purpose')
            inquiry_purpose.text = parameters.get('request_goal')

            bic_agreement = ElementTree.SubElement(cr_request, 'credit_application_agreement')
            bic_agreement.text = parameters.get('bic_agreement')

            process_indicator = ElementTree.SubElement(cr_request, 'process_indicator')
            process_indicator.text = parameters.get('bic_agreement')

            if parameters.get('counterparty_type') == "C":
                company_name = ElementTree.SubElement(cr_request, 'company_name')
                company_name.text = parameters.get('company_name')

                company_short_name = ElementTree.SubElement(cr_request, 'company_short_name')
                company_short_name.text = parameters.get('company_short_name')

            last_name = ElementTree.SubElement(cr_request, 'last_name')
            last_name.text = parameters.get('last_name')

            first_name = ElementTree.SubElement(cr_request, 'first_name')
            first_name.text = parameters.get('first_name')

            father_name = ElementTree.SubElement(cr_request, 'father_name')
            father_name.text = parameters.get('patronymic')

            identity_card = ElementTree.SubElement(cr_request, 'identity_card')
            identity_card.text = parameters.get('passport_series_number')

            date_of_registration = ElementTree.SubElement(cr_request, 'date_of_registration')
            date_of_registration.text = parameters.get('date_of_birth')

            document_number = ElementTree.SubElement(cr_request, 'document_number')
            document_number.text = parameters.get('document_number')

            document_date = ElementTree.SubElement(cr_request, 'document_date')
            document_date.text = parameters.get('document_date')

            document_type = ElementTree.SubElement(cr_request, 'document_type')
            document_type.text = parameters.get('document_type')

            if parameters.get('bic_agreement') == '1':
                initial_value = ElementTree.SubElement(cr_request, 'initial_value')
                initial_value.text = parameters.get('credit_amount')

                document_currency = ElementTree.SubElement(cr_request, 'document_currency')
                document_currency.text = parameters.get('currency_code')

                terms_duration = ElementTree.SubElement(cr_request, 'terms_duration')
                terms_duration.text = parameters.get('credit_term')

                terms_frequency = ElementTree.SubElement(cr_request, 'terms_frequency')
                terms_frequency.text = parameters.get('frequency_of_payments')

                document_insurance = ElementTree.SubElement(cr_request, 'document_insurance')
                document_insurance.text = parameters.get('type_of_collateral')

                insurance_value = ElementTree.SubElement(cr_request, 'document_insurance_value')
                insurance_value.text = parameters.get('collateral_amount')

                extras_type = ElementTree.SubElement(cr_request, 'extras_type')
                extras_type.text = parameters.get('report_type')

        return ElementTree.tostring(**{
            'element': xml,
            'encoding': 'utf-8',
            'short_empty_elements': False
        }).decode()

    def entity_parameters(self, company=None):
        if company is None:
            company = {}

        date = datetime.now()
        formats = date.strftime("%d-%m-%Y %H:%M:%S")
        year = date.strftime("%Y")

        additional_data = company.get('additional_data', {}) or {}
        registered_at = additional_data.get('registered_at', None)

        user = company.get('user', {})

        parameters = {
            "request_date": formats,
            "counterparty_type": company.get('counterparty_type', 'C') or 'C',
            "fiscal_code": company.get('idno', ''),
            "request_goal": company.get('request_goal', 'MDP') or 'MDP',
            "bic_agreement": company.get('bic_agreement', '1') or '1',
            "report_bic": company.get('report_bic', '1') or '1',
            "report_sfs": company.get('report_sfs', '1') or '1',
            "report_bns": company.get('report_bns', '1') or '1',
            "report_bns_year": company.get('report_bns_year', year) or year,
            "company_name": company.get('title', ''),
            "company_short_name": company.get('title', ''),
            'first_name': self.replace_with_ascii(user.get('first_name', 'NA')) or 'NA',
            'last_name': self.replace_with_ascii(user.get('last_name', 'NA')) or 'NA',
            'patronymic': self.replace_with_ascii(user.get('patronymic', 'NA')) or 'NA',
            'passport_series_number': None,
            'date_of_birth': None,
            'document_number': str(int(date.timestamp())),
            'document_date': None,
            'date_of_registration': registered_at,
            'credit_amount': str(company.get('credit_amount', '0') or '0'),
            'currency_code': str(company.get('currency_code', 'MDL') or 'MDL'),
            'credit_term': str(company.get('credit_term', '0') or '0'),
            'request_type': str(company.get('request_type', 'M') or 'M'),
            'document_type': str(company.get('document_type', 'C') or 'C'),
            'frequency_of_payments': str(company.get('frequency_of_payments', 'N') or 'N'),
            'type_of_collateral': str(company.get('type_of_collateral', 'D') or 'D'),
            'collateral_amount': str(company.get('collateral_amount', '0') or '0'),
            'report_type': str(company.get('report_type', 'AllSection') or 'AllSection'),
        }

        return parameters

    @staticmethod
    def upsert_file(path):
        import os

        os.makedirs(os.path.dirname(path), exist_ok=True)

    def html(self, xml: str = '', xslt: str = 'templates/tr.xslt'):
        xslt_document = os.path.join(pathlib.Path().absolute(), xslt)
        xslt_document_element = etree.parse(xslt_document)
        xslt_document_transformer = etree.XSLT(xslt_document_element)

        name = str(int(datetime.now().timestamp()))

        xml_document_element = etree.fromstring(xml.encode())
        xml_document_transformer = xslt_document_transformer(xml_document_element)

        html_string = str(xml_document_transformer)
        name_tag = name
        html_name = f'storage/companies/reports/html/{name}.html'
        self.upsert_file(html_name)

        try:
            with open(html_name, 'w', encoding="utf-8") as file:
                file.write(html_string)
        finally:
            file.close()

        return file, html_string, html_name, name_tag
