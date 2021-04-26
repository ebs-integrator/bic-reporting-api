from django.db import models
from django.utils import timezone


# Create your models here.


class CommonModel(models.Model):
    timestamp = models.DateTimeField(default=timezone.now)
    edited_timestamp = models.DateTimeField(default=timezone.now)

    def update_object(self, save=True, **kwargs):
        """
        Update object by dict data, ignore data if field not exist
        :param kwargs: dict of objects, like : {field: value}
        :param save: boolean flag, if need to save object(make transaction to database)
        :return:
        """
        # if object changed, need save data
        changed = False
        for key, value in kwargs.items():
            if hasattr(self, key) and getattr(self, key) != value:
                changed = True
                setattr(self, key, value)
        # check is exist flag save and object changed
        if save and changed:
            self.save()
        return self

    def save(self, force_insert=False, force_update=False, using=None,
             update_fields=None):
        self.edited_timestamp = timezone.now()
        super(CommonModel, self).save(force_insert=force_insert,
                                      force_update=force_update, using=using,
                                      update_fields=update_fields)

    class Meta:
        ordering = ['id']
        abstract = True
