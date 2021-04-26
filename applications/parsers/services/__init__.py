from xml.etree import ElementTree

from applications.reports.services.report import ReportService


# Create your services here.

class DataParserService(ReportService):

    @staticmethod
    def parse_xml(source: str = ''):
        if not source:
            return ''

        return ElementTree.fromstring(source)
