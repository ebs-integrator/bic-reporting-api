from typing import Union

from applications.commons.services import StorageService
from applications.parsers.serializers import ParsingSerializer

from applications.reports.process.data_service import DataService

from rest_framework.exceptions import ValidationError

# Add your services here.

data_service = DataService()


# Create your services here.

class ParsingService(StorageService):

    def __init__(self):
        super().__init__()

        self.model = ParsingSerializer.Meta.model
        self.get_serializer_class = ParsingSerializer
        self.create_serializer_class = ParsingSerializer
        self.unique_identifier = 'company_id'
        self.unique_identifiers = ['company_id']

    def html_from_xml(self, parsing: Union[int, ParsingSerializer.Meta.model]):
        if isinstance(parsing, int):
            parsing: ParsingSerializer.Meta.model = self.get_by(key='id', value=parsing, serialize=False)

        xml = parsing.xml

        if not xml:
            return

        try:
            file, html, name, named = data_service.html(xml=xml)
            return file, html, name, named
        except Exception as error:
            raise ValidationError(detail={'detail': error})
