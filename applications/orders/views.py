from rest_framework.views import APIView
from rest_framework.generics import ListAPIView, RetrieveUpdateDestroyAPIView

from django.http import HttpResponse

from applications.orders.serializers import CreateCompanyOrderSerializer, OrderSerializer
from applications.orders.services.order import OrderService

from applications.reports.services import ReportingService

from applications.companies.services.company import CompanyService

# Add your services here.

company_service = CompanyService()
order_service = OrderService()
report_service = ReportingService()


# Create your views here.

class ListOrders(ListAPIView):
    serializer_class = OrderSerializer
    queryset = OrderSerializer.Meta.model.objects.all()


class CreateOrder(APIView):
    serializer_class = CreateCompanyOrderSerializer

    @staticmethod
    def render_xml(xml):
        return HttpResponse(content=xml, content_type='application/xml')

    def post(self, request, *args, **kwargs):
        data = request.data
        delivery = request.data.get('delivery', 'ONLINE')
        company, created = company_service.upsert({
            'title': data.get('title', 'Unknown'),
            'idno': data.get('idno'),
        })

        # Create order attempt
        order, created = order_service.upsert({
            'company_id': company.id,
            'xml': '',
            'data': request.data
        })

        result = report_service.execute(company=request.data, delivery=delivery)

        # Update order with result
        order.xml = result
        order.save()

        return self.render_xml(result)


class RetrieveUpdateDestroyOrder(RetrieveUpdateDestroyAPIView):
    serializer_class = OrderSerializer
    queryset = OrderSerializer.Meta.model.objects.all()
