## Warehouse App
### API:

# Galpões

### Listar todos galpões
---
**Requisição:**

```
GET /api/v1/warehouses
```

**Respostas:**

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
```
Status: 200 (OK)

{
  "alert": "Nenhum galpão cadastrado"
}
```
```
Status: 500 (Internal Server Error)

{
  "error": "Erro de conexão com o servidor"
}

```

### Ver um galpão
---
**Requisição:**
```
GET /api/v1/warehouses/2
```

**Respostas:**

```
Status: 200 (OK)

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
```

```
Status: 404 (Not Found)

{
  "error": Objeto não encontrado
}
```

```
Status: 500 (Internal Server Error)

{
  "error": "Erro de conexão com o servidor"
}
```





### Criar um galpão
---
**Requisição:**

```
POST /api/v1/warehouses
```

**Parâmetros:**

```
{
  "name": "Maceió",
  "code": "MCZ",
  "description": "Ótimo galpão",
  "address": "Avenida X",
  "city": "Maceió",
  "state": "AL",
  "postal_code": "57050-000",
  "total_area": 10000,
  "useful_area": 8000
}

```

**Resposta:**

```
Status: 201 (Criado)

{
  "id": 5,
  "name": "Maceió",
  "code": "MCZ",
  "description": "Ótimo galpão",
  "city": "Maceió",
  "state": "AL",
  "postal_code": "57050-000",
  "total_area": 10000,
  "useful_area": 8000
}
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
