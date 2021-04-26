from django.db import models

from applications.commons.models import CommonModel


# Create your models here.

class Company(CommonModel):
    title = models.CharField(max_length=255, default="")
    idno = models.CharField(max_length=128, unique=True, db_index=True)
