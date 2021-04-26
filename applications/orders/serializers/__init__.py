from rest_framework.serializers import (
    ModelSerializer, IntegerField, CharField, JSONField,
    PrimaryKeyRelatedField
)

from applications.orders.models import Order

from applications.companies.serializers import CompanySerializer


# Create your serializers here.

class OrderSerializer(ModelSerializer):
    class Meta:
        model = Order
        fields = '__all__'


class CreateCompanyOrderSerializer(ModelSerializer):
    id = IntegerField(required=True)
    title = CharField(required=True)
    idno = CharField(required=True)
    additional_data = JSONField(default={}, allow_null=True)
    user = JSONField(default={})
    delivery = CharField(default="ONLINE", required=False)

    # Company
    company = CompanySerializer(read_only=True)
    company_id = PrimaryKeyRelatedField(
        queryset=CompanySerializer.Meta.model.objects.all(),
        write_only=True,
        required=False,
        source='company'
    )

    class Meta:
        model = Order
        fields = '__all__'
