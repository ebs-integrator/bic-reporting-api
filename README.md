# BIC Reporting API


BIC (Biroul Istoriilor de Credit) `bicr.md` Reporting API Implementation

## Requirements

1. Python 3.8


## Installation

Before running this project you should have certificates from `bicr.md` and signing domain from `itsec.md` , at the moment those are:
```
1.pem (CHAIN)
2.pem (CA)
3.pem (KEY)
private.pem (user certificate)
```

Setup .env:
```sh
cp .env.example .env
```


```sh
SERVICE_BIC_HOST=http://sigun.bicr.md/api/bulkReport2/
SERVICE_BIC_USERNAME=test
SERVICE_BIC_PASSWORD=test

SERVICE_SIGNATURE_HOST=
SERVICE_SIGNATURE_CERTIFICATES=certificates
SERVICE_SIGNATURE_TEMPLATES=templates
SERVICE_SIGNATURE_PRIVATES=privates
```

```sh
Replace 1.pem , 2.pem , 3.pem , privat.pem under certificates & privates folder
```

Install dependencies
```sh
pipenv install
```

Run migrations
```sh
python manage.py migrate
```

Run server
```sh
python manage.py runserver
```

## Requests

Place order example
```sh
POST http://127.0.0.1:8000/api/orders/
{
    "id": 100,
    "idno": "2",
    "title": "Company"
}
```
Parse received XML
```sh
POST http://127.0.0.1:8000/api/parsers/xml/
{
    "idno": "2",
    "xml": "<xml/>"
}
```
Generate parsed XML `BIC - PDF`
```sh
GET http://127.0.0.1:8000/api/parsers/1/
```