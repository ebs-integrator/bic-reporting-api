from applications.commons.services import StorageService
from applications.orders.serializers import OrderSerializer


# Create your services here.

class OrderService(StorageService):

    def __init__(self):
        super().__init__()

        self.model = OrderSerializer.Meta.model
        self.get_serializer_class = OrderSerializer
        self.create_serializer_class = OrderSerializer
        self.unique_identifier = 'company_id'
        self.unique_identifiers = ['company_id']
