from django.urls import path

from applications.parsers import views

# Create your patterns here.

urlpatterns = [
    # Parsers
    path('xml/', views.ParseXML.as_view(), name="parse_xml"),
    path('<int:pk>/', views.RetrieveParsing.as_view(), name="retrieve_parser"),
]
