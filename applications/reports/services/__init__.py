from applications.reports.process.data_service import DataService
from applications.reports.process.signature_service import SignatureService
from applications.reports.process import ProcessService


# Create your services here.

class ReportingService:
    def __init__(self):
        super().__init__()

    @staticmethod
    def execute(company=None, delivery='ONLINE'):
        if company is None:
            company = {}

        signature = SignatureService()
        data = DataService(company, delivery)
        process = ProcessService(data, signature)

        return process.execute()
