from rest_framework.pagination import PageNumberPagination


# Create your pagination here.

class StandardResultsSetPagination(PageNumberPagination):
    page_size = 15
    page_size_query_param = 'limit'
    max_page_size = 1000
