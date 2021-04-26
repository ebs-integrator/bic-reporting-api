from django.db import models

from applications.commons.models import CommonModel


# Create your models here.

class Parsing(CommonModel):
    xml = models.TextField(default="")
    json = models.JSONField(null=True)
    data = models.JSONField(null=True)
    company = models.ForeignKey('companies.Company', on_delete=models.CASCADE)
    timestamp_parsed = models.DateTimeField(auto_now_add=True, blank=True)
    pdf_url = models.CharField(null=True, max_length=255)
    html_url = models.CharField(null=True, max_length=255)
