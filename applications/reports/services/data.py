import base64
import hashlib
from abc import abstractmethod


# Create your services here.

class DataService:
    data = None

    def get_data(self):
        if self.data:
            return self.data
        return self.generate_data()

    @abstractmethod
    def generate_data(self, **kwargs):
        ...

    @staticmethod
    def base64_encode(value):
        value_encoded = value.encode()
        base64_bytes = base64.b64encode(value_encoded)
        return base64_bytes.decode()

    @staticmethod
    def base64_encode_binary(value):
        base64_bytes = base64.b64encode(value)
        return base64_bytes.decode()

    @staticmethod
    def base64_encode_binary(value):
        base64_bytes = base64.b64encode(value)
        return base64_bytes.decode('ascii')

    @staticmethod
    def base64_decode(value):
        value_encoded = value.encode('ascii')
        message_bytes = base64.b64decode(value_encoded)
        return message_bytes.decode('ascii')

    @staticmethod
    def replace_with_ascii(value: str):
        dictionary = {"Ă": "A", "ă": "a", "Ĭ": "I", "ĭ": "I", "Ş": "S", "ş": "s",
                      "Ţ": "T", "ţ": "t", "Ǎ": "A", "ǎ": "a", "Ǐ": "I", "ǐ": "i",
                      "Ȋ": "I", "ȋ": "i", "Ș": "S", "ș": "s", "Â": "I", "â": "i",
                      "Î": "I", "î": "i"}

        for letter, replace_with in dictionary.items():
            value = value.replace(letter, replace_with)

        return value

    def to_hex(self, value: str):
        data = hashlib.sha1()
        data.update(value.encode())

        return data.digest()

    def to_binary(self, value: str):
        binary = self.text_to_bits(value)
        return self.base64_encode(binary)

    @staticmethod
    def text_to_bits(text, encoding='utf-8', errors='surrogatepass'):
        bits = bin(int.from_bytes(text.encode(encoding, errors), 'big'))[2:]
        return bits.zfill(8 * ((len(bits) + 7) // 8))

    @staticmethod
    def xml_to_text(xml: str):
        from xml.etree import ElementTree as ET
        root = ET.fromstring(xml)
        result = ET.tostring(root, short_empty_elements=False).decode()
        return result.replace('\t', '').replace('\n', '')
