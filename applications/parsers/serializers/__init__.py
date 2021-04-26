from django.utils.translation import gettext_lazy as _
from rest_framework.serializers import (
    Serializer, CharField, ChoiceField, ValidationError, ModelSerializer
)

from applications.parsers.helpers import ResponseHelper
from applications.parsers.models import Parsing

from applications.companies.models import Company


# Create your serializers here.

class ParseXMLSerializer(Serializer):
    xml = CharField(required=True)
    response = ChoiceField(required=False, default=ResponseHelper.TYPE_XML, choices=ResponseHelper.TYPE_CHOICES)
    idno = CharField(required=True)

    def validate_idno(self, idno):
        if company := Company.objects.filter(idno=idno).first():
            return company.pk
        raise ValidationError(_('Not exists.'))

    def update(self, instance, validated_data):
        pass

    def create(self, validated_data):
        pass


class ParsingSerializer(ModelSerializer):
    class Meta:
        model = Parsing
        fields = '__all__'


class RetrieveParsingSerializer(ModelSerializer):
    class Meta:
        model = Parsing
        fields = ('id', 'pdf_url', 'html_url')
