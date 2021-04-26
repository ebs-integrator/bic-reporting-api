import time
import pdfkit

from contextlib import suppress
from abc import ABC
from tempfile import NamedTemporaryFile

from django.template.loader import render_to_string


# Create your services here.


class PDFService(ABC):

    def __init__(self, **kwargs):
        super().__init__()

        self.prefix = kwargs.get('prefix', str(time.time()))
        self.name = kwargs.get('name', 'default')
        self.orientation = kwargs.get('orientation', 'Portrait')
        self.name = f'{self.prefix}__{self.name}'
        self.escalate = kwargs.get('escalate', False)

        self.options = {
            "margin-right": "0",
            "margin-left": "0",
            "page-size": "A4",
            "orientation": self.orientation,
            'encoding': "UTF-8",
            '--javascript-delay': 6000,
            'enable-local-file-access': None,  # MAC OS ISSUE,
            '--header-spacing': '52',
            '--footer-spacing': '1',
            '--margin-bottom': '2'
        }

        if self.orientation == 'Landscape' and self.escalate:
            self.options.update({'--header-spacing': '71'})

    def render_temporary(self, template: str):
        """
        Render temporary file
        :param template:
        :return:
        """
        path = f'{template}'
        content: str = render_to_string(path, {})
        file = self.get_temporary(suffix=".html")
        file.write(content)
        file.seek(0)

        return file

    @staticmethod
    def get_temporary(**kwargs):
        """
        Get temporary file
        :param kwargs:
        :return:
        """
        suffix = kwargs.get('suffix', None)
        prefix = kwargs.get('prefix', None)
        mode = kwargs.get('mode', 'r+')
        encoding = kwargs.get('mode', 'utf-8')

        if 'b' in mode:
            encoding = None

        return NamedTemporaryFile(
            mode=mode,
            suffix=suffix,
            prefix=prefix,
            encoding=encoding
        )

    @staticmethod
    def upsert_file(path):
        import os

        os.makedirs(os.path.dirname(path), exist_ok=True)

    def html_string_to_pdf(self, source, path: str = '/'):
        """
        Generate html string to pdf
        :param source:
        :param path:
        :return:
        """
        output = f'{path}{self.name}.pdf'
        self.upsert_file(output)

        with suppress(ValueError):
            return pdfkit.from_string(input=source, output_path=output, options=self.options), output

        return False, output

    def html_file_to_pdf(self, source, path: str = '/'):
        """
        Generate html string to pdf
        :param source:
        :param path:
        :return:
        """
        output = f'{path}{self.name}.pdf'
        self.upsert_file(output)

        with suppress(ValueError):
            return pdfkit.from_file(input=source, output_path=output, options=self.options), output

        return False, output

    def html_url_to_pdf(self, source, path: str = '/'):
        """
        Generate html string to pdf
        :param source:
        :param path:
        :return:
        """
        output = f'{path}{self.name}.pdf'
        self.upsert_file(output)

        with suppress(ValueError):
            return pdfkit.from_url(source, output_path=output, options=self.options), output

        return False, output
