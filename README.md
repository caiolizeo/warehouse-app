# README

## API

### Galpões

#### Listar todos os galpões
**Requisição:**

```
GET /api/v1/warehouses
```

**Resposta:**

```
Status: 200 (OK)

[
  {
    "id": 1,
    "name": "Maceió",
    "code": "MCZ",
    "description": "Ótimo galpão",
    "city": "Maceió",
    "state": "AL",
    "postal_code": "57050-000",
    "total_area": 10000,
    "useful_area": 8000
  },
  {
    "id": 2,
    "name": "São Paulo",
    "code": "SPX",
    "description": "em sp",
    "city": "São Paulo",
    "state": "SP",
    "postal_code": "04000-000",
    "total_area": 5000,
    "useful_area": 4000
  }
]
```



This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
