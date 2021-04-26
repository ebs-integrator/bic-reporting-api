from abc import ABC
from contextlib import suppress
from copy import deepcopy

from django.db import DataError
from django.db.models import Max
from django.db.models.fields.related import ManyToManyField

from rest_framework.exceptions import ValidationError


# Create your services here.

class StorageService(ABC):

    def __init__(self):
        self.helper = None
        self.model = None
        self.create_serializer_class = None
        self.get_serializer_class = None
        self.unique_identifier: str = ''
        self.unique_identifiers: list = []

    def set_unique_identifier(self, value):
        if not isinstance(value, str):
            return self

        self.unique_identifier = value
        return self

    def set_unique_identifiers(self, values):
        if not isinstance(values, list):
            return self

        self.unique_identifiers = values
        return self

    def serialize(self, entities, many=False):
        if isinstance(entities, list):
            many = True

        return self.get_serializer_class(entities, many=many).data

    def get_next_id(self):
        maximum = self.model.objects.all().aggregate(Max('id'))['id__max']
        return maximum + 1 if maximum else 1

    def get_by(self, key: str = '', value=None, serialize=True):
        entity = self.model.objects.filter(**{key: value}).first()
        if not entity:
            return {}

        return self.serialize(entity) if serialize else entity

    def delete_by(self, key: str = '', value=None):
        entity = self.model.objects.filter(**{key: value}).first()
        return entity.delete()

    def set_identifiers(self, data):
        """
        Method to add identifiers as dict
        And to remove identifiers as default element
        """
        identity = {}
        if self.unique_identifier:
            self.unique_identifiers.append(self.unique_identifier)

        # Remove duplicates
        self.unique_identifiers = list(dict.fromkeys(self.unique_identifiers))

        try:
            for unique_identifier in self.unique_identifiers:
                identity[unique_identifier] = data[unique_identifier]
                data.pop(unique_identifier, None)

            return identity
        except Exception as e:
            return identity

    @staticmethod
    def indexed(elements=None, index: int = 0, retrieve: bool = False):
        """
        Get and / or retrieve element at index
        :param elements:
        :param index:
        :param retrieve:
        :return:
        """
        if elements is None:
            elements = []

        condition = index < len(elements)

        if condition and retrieve:
            return elements[index]

        return condition

    def get_many_to_many_fields(self):
        """
        Get many to many of current model
        e.g. ['attachments', 'users']
        :return:
        """
        fields = []

        for field in self.model._meta.get_fields():
            if isinstance(field, ManyToManyField):
                fields.append(field.name)

        return fields

    def get_model_fields(self):
        """
        Get fields of current model
        :return:
        """
        fields = []

        for field in self.model._meta.get_fields():
            fields.append(field.name)

        return fields

    def upsert(self, data, parameters=None, many_to_many_clear: bool = True):
        """
        Method to upsert a single object
        :param many_to_many_clear:
        :param data:
        :param parameters:
        :return:
        """
        many_to_many_fields = self.get_many_to_many_fields()
        many_to_many_fields_store = {}

        # Skip if no identifier is set
        if (not self.unique_identifier and not self.unique_identifiers) or not data:
            return None

        try:
            if isinstance(parameters, dict):
                data.update(parameters)

            identity = self.set_identifiers(data)

            # Escape many to many fields from object and store to add later on
            if many_to_many_fields:
                for field in many_to_many_fields:
                    evaluated = data.pop(field, None)
                    many_to_many_fields_store[field] = evaluated

            # Update or create object
            model, created = self.model.objects.update_or_create(**identity, defaults=data)

            # Attach many to many objects after save
            if model and many_to_many_fields_store:
                for field, objects in many_to_many_fields_store.items():
                    element = getattr(model, field, None)
                    if many_to_many_clear:
                        element.clear()
                    if objects:
                        element.add(*objects)

            # Finally return model
            return model, created

        except DataError as e:
            raise ValidationError(e)

    def bulk_upsert(self, data, parameters=None, many_to_many_clear: bool = True):
        """
        Method to bulk upsert multiple objects
        :param many_to_many_clear:
        :param data:
        :param parameters:
        :return:
        """
        elements = []

        # Skip if no identifier is set
        if not self.unique_identifier or not data:
            return

        for element in data:
            if isinstance(parameters, dict):
                element.update(parameters)

            element, created = self.upsert(data=element, many_to_many_clear=many_to_many_clear)
            elements.append(element)

        return elements

    def bulk_delete(self, data) -> bool:
        """
        Method to bulk delete multiple objects
        :param data:
        :return:
        """
        # Skip if no identifier is set
        if not self.unique_identifier or not data:
            return False

        for obj in data:
            if isinstance(obj, self.model):
                obj.delete()

        return True

    def bulk_get_or_create(self, data):
        """
        Method to bulk get or create multiple objects
        :param data:
        :return:
        """
        elements = []

        # Skip if no identifier is set
        if (not self.unique_identifier and not self.unique_identifiers) or not data:
            return None

        for element in data:
            identity = self.set_identifiers(element)
            element, created = self.model.objects.get_or_create(**identity, defaults=None)
            elements.append(element)

        return elements

    @staticmethod
    def escape_serialized_object_id(source: dict, fields: tuple, parameters=None, mutate: dict = None):
        temporary = {}

        if isinstance(parameters, dict):
            temporary.update(parameters)

        if not isinstance(source, dict):
            return temporary

        if not mutate:
            mutate = {}

        try:
            for field in fields:
                if field not in source:
                    continue

                identifier = field.replace('_id', '') if field.endswith('_id') else field
                evaluated = source[field]
                temporary[identifier] = dict(evaluated) if isinstance(evaluated, list) else evaluated

            for past, current in mutate.items():
                temporary.update({current: temporary[past]})

        except Exception as e:
            return temporary

        return temporary

    def escape_serialized_objects_id(self, source: list, fields: tuple, parameters=None, mutate: dict = None):
        temporary = []

        if not isinstance(source, list):
            return temporary

        if not mutate:
            mutate = {}

        try:
            for element in source:
                temporary.append(self.escape_serialized_object_id(element, fields, parameters, mutate))
        except Exception as e:
            pass

        return temporary

    @staticmethod
    def escape_serialized_objects_fields(source: list, fields: list):
        temporary = []

        if not isinstance(source, list) or not isinstance(fields, list):
            return temporary

        with suppress(Exception):
            for element in source:
                copy = deepcopy(element)

                for field in fields:
                    copy.pop(field, None)
                temporary.append(copy)

        return temporary
