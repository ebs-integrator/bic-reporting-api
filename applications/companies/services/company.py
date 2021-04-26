from applications.commons.services import StorageService
from applications.companies.serializers import CompanySerializer


# Create your services here.

class CompanyService(StorageService):

    def __init__(self):
        super().__init__()

        self.model = CompanySerializer.Meta.model
        self.get_serializer_class = CompanySerializer
        self.create_serializer_class = CompanySerializer
        self.unique_identifier = 'idno'
        self.unique_identifiers = ['idno']
