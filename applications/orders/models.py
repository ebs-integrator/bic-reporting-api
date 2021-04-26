from django.db import models

from applications.commons.models import CommonModel


# Create your models here.

class Order(CommonModel):
    xml = models.TextField(default="")
    data = models.JSONField(null=True)
    company = models.ForeignKey('companies.Company', on_delete=models.CASCADE)
    timestamp_ordered = models.DateTimeField(auto_now_add=True, blank=True)
