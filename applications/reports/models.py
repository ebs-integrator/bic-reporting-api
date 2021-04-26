from django.db import models

from applications.commons.models import CommonModel


# Create your models here.


class Report(CommonModel):
    company = models.ForeignKey('companies.Company', on_delete=models.CASCADE)
    url = models.CharField(null=True, max_length=512)
    type = models.CharField(null=True, max_length=128)
    data = models.JSONField(null=True)
    name = models.CharField(null=True, max_length=512)
    size = models.IntegerField(default=0)
