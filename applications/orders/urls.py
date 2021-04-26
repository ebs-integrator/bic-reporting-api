from django.urls import path

from applications.orders import views

# Create your patterns here.

urlpatterns = [
    # Parsers
    path('list/', views.ListOrders.as_view(), name="list_orders"),
    path('', views.CreateOrder.as_view(), name="create_order"),
    path('<int:pk>/', views.RetrieveUpdateDestroyOrder.as_view(), name="retrieve_update_destroy_attachment_by_pk"),
]
