from xmltodict import parse
from contextlib import suppress
from dicttoxml import dicttoxml
from drf_util.utils import gt

from abc import ABC


# Create your services here.

class ReportService(ABC):
    # CONSTS
    TEXT_GENERAL = 'General'

    def __init__(self):
        super().__init__()

    def parse(self, xml, path='root.credit_reports'):
        """
        Parse xml string to json
        :param xml: XML sources string
        :param path: Path to be accesses of xml string
        :return:
        """
        with suppress(Exception):
            parsing = parse(xml)
            accessing = dict(gt(parsing, path))
            return self.clear_signs(accessing)

        return {}

    def clear_signs(self, sources, sign='@', shift='#text', scape='item'):
        """
        Clear sources from sign keys
        Shift key with value
        Scape key with main elements
        :param sources:
        :param sign:
        :param shift:
        :param scape:
        :return:
        """
        for element, value in sources.copy().items():
            if element.startswith(sign):
                sources.pop(element)
                continue

            # If element is dict inspect each key value and clear useless keys
            if isinstance(sources[element], dict):
                self.clear_signs(sources[element], sign)

            # If element is list inspect each key value and clear useless keys
            if isinstance(sources[element], list):
                for elements in sources[element]:
                    self.clear_signs(elements, sign)

            # If element value is a object with shift key use it as value
            with suppress(AttributeError):
                if sources[element] and shift in sources[element]:
                    sources[element] = value.get(shift, '')

            # If element value is a empty object make it empty string or remove <<<
            if not sources[element]:
                sources.pop(element)
                continue

            # Skip if scape does not exists in element
            if scape not in sources[element] and element in sources:
                continue

            # If scape exists set as main element value , as array
            if scoped := sources[element][scape]:
                if isinstance(scoped, list):
                    sources[element] = scoped

                if isinstance(scoped, dict):
                    sources[element] = [scoped]

        return sources

    @staticmethod
    def json_to_xml(sources):
        """
        Parse json to xml
        :param sources: Json sources
        :return:
        """
        parsing = dicttoxml(sources)
        return parsing

    def normalize(self, sources):
        """
        Normalize keys values to strings
        :param sources:
        :return:
        """
        for element, value in sources.copy().items():

            # If element is int convert to string
            if isinstance(sources[element], int):
                sources[element] = str(sources[element])

            # If element is None convert to string
            if sources[element] is None:
                sources[element] = ""

            # If element is dict inspect each key value and clear useless keys
            if isinstance(sources[element], dict):
                self.normalize(sources[element])

            # If element is list inspect each key value and clear useless keys
            if isinstance(sources[element], list):
                for index, elements in enumerate(sources[element]):
                    if isinstance(elements, int):
                        sources[element][index] = str(elements)

                    # Ignored else for clear viewing
                    if not isinstance(elements, int):
                        self.normalize(elements)

        return sources
