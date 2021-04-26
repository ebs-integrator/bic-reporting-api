from abc import abstractmethod


# Create your services here.

class ReportingService:
    sign_service = None
    data_service = None

    def __init__(self, data_service=None, sign_service=None):
        self.sign_service = sign_service
        self.data_service = data_service

    @abstractmethod
    def execute(self, **kwargs):
        ...

    @abstractmethod
    def make_request(self, **kwargs):
        ...

    @abstractmethod
    def _prepare(self, response):
        ...
