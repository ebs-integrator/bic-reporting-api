from rest_framework.serializers import (ModelSerializer)

from applications.companies.models import Company


# Create your serializers here.

class CompanySerializer(ModelSerializer):
    class Meta:
        model = Company
        fields = '__all__'
