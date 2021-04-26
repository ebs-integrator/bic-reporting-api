import os

from rest_framework.permissions import AllowAny
from rest_framework.views import APIView
from rest_framework.generics import RetrieveAPIView
from rest_framework.response import Response

from django.http import HttpResponse

from applications.parsers.serializers import ParseXMLSerializer, ParsingSerializer, RetrieveParsingSerializer
from applications.parsers.services import DataParserService
from applications.parsers.services.parser import ParsingService
from applications.parsers.models import Parsing

from applications.reports.services.pdf import PDFService

# Add your services here.

data_parser_service = DataParserService()
parsing_service = ParsingService()


# Create your views here.

class RetrieveParsing(RetrieveAPIView):
    queryset = Parsing.objects.all()
    serializer_class = RetrieveParsingSerializer

    def get(self, request, *args, **kwargs):
        entity = self.get_object()

        file, document, name, named = parsing_service.html_from_xml(entity)

        if name:
            entity.html_url = name
            entity.save()

        # Generate PDF
        service = PDFService(name=named)

        # Output response
        success, output = service.html_file_to_pdf(
            os.path.abspath(name), path='storage/companies/reports/pdf/'
        )

        if success and output:
            entity.pdf_url = output
            entity.save()

        return Response(parsing_service.serialize(entity))


class ParseXML(APIView):
    permission_classes = [AllowAny]
    serializer_class = ParseXMLSerializer

    def post(self, request):
        serializer = self.serializer_class(data=request.data)
        serializer.is_valid(raise_exception=True)
        xml = serializer.data.get('xml', '')
        dictionary = data_parser_service.parse(xml)

        parser, created = parsing_service.upsert(data={
            'company_id': serializer.data.get('idno'),
            'xml': xml,
            'json': dictionary
        })

        return Response(data=ParsingSerializer(parser).data)
