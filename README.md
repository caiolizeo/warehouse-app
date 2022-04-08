# Warehouse App

## 🖥️ Sobre o projeto:


O projeto propôs criar uma aplicação web para uma empresa que gerencia a gestão de galpões e o estoque de produtos de lojas virtuais. Neles a aplicação é responsável por receber produtos novos comprados pela empresa, manter os dados de estoque atualizados e registrar a saída de produtos.
<br>
<br>
Este projeto fez parte da conclusão do treinamento Quero Ser Dev da Locaweb junto com a Campus Code, e teve a duração de três meses, totalizando 126 horas.


---
## ⚙️Configurando o projeto

```
ruby bin/setup
```

## 🚀 Rodando o projeto
``` 
rails s
```

## 🧪 Executando testes
``` 
rspec
```

## 🐋 Dockerizando projeto
build:
``` 
docker build -t warehouse-app:1.0 .
```

run:
```
docker run -it -p 3000:3000 warehouse-app:1.0
```
---
<br>
<br>

## 🔊 API

## **Galpões**

### **Listar todos galpões**

Requisição:

```
GET /api/v1/warehouses
```

Respostas:

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
---
 ### ***Ver um galpão***

Requisição:
```
GET /api/v1/warehouses/2
```

Respostas:

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

---
### ***Criar um galpão***
Requisição:

```
POST /api/v1/warehouses
```

Parâmetros:

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

Resposta:

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
---

<br>
<br>

## **Modelos de produto**

### **Listar todos os modelos de produto**

Requisição:

```
GET /api/v1/product_models
```

Resposta:
```
Status: 200 (OK)

[
  {
    "id": 1,
    "name": "SmartWatch",
    "weight": 300,
    "height": 14,
    "length": 8,
    "width": 10,
    "provider_id": 1,
    "sku": "VC4OQWPJQGMZOAIDRGSP",
    "category_id": 2,
    "status": "disabled",
    "dimensions": "14 x 10 x 8",
    "provider": {
      "id": 1,
      "trading_name": "A Presentes",
      "company_name": "A importações LTDA ME",
      "cnpj": "21.749.641/0001-13",
      "address": "Av Paulista 500",
      "email": "contato@jpresentes.com",
      "phone": "99999-9999"
    },
    "category": {
      "id": 2,
      "name": "Eletrônicos"
    }
  },
  {
    "id": 2,
    "name": "Nuggets Sadia 200g",
    "weight": 250,
    "height": 50,
    "length": 15,
    "width": 30,
    "provider_id": 3,
    "sku": "ZU3GAOKIIO2VSUURWW4D",
    "category_id": 3,
    "status": "disabled",
    "dimensions": "50 x 30 x 15",
    "provider": {
      "id": 3,
      "trading_name": "Mercados X",
      "company_name": "SuperMercados X",
      "cnpj": "52.874.953/0001-82",
      "address": "Av Paulista 500",
      "email": "contato@xmerc.com",
      "phone": "99999-5555"
    },
    "category": {
      "id": 3,
      "name": "Refrigerados/Congelados"
    }
  }
]

```
---

### **Ver um modelo de produto**

Requisição:

```
GET /api/v1/product_models
```

Resposta:
```
Status: 200 (OK)

{
  "id": 1,
  "name": "SmartWatch",
  "weight": 300,
  "height": 14,
  "length": 8,
  "width": 10,
  "provider_id": 1,
  "sku": "VC4OQWPJQGMZOAIDRGSP",
  "category_id": 2,
  "status": "disabled",
  "dimensions": "14 x 10 x 8",
  "provider": {
    "id": 1,
    "trading_name": "A Presentes",
    "company_name": "A importações LTDA ME",
    "cnpj": "21.749.641/0001-13",
    "address": "Av Paulista 500",
    "email": "contato@jpresentes.com",
    "phone": "99999-9999"
  },
  "category": {
    "id": 2,
    "name": "Eletrônicos"
  }
}
```
---

### **Cadastrar um modelo de produto**

Requisição:

```
POST /api/v1/product_models
```

Parâmetros:

```
{
  "name": "iPhone 12",
  "weight": 300,
  "height": 14,
  "length": 8,
  "width": 10,
  "provider_id": 1,
  "category_id": 2
}

```
Resposta:
```
Status: 200 (OK)

{
  "id": 1,
  "name": "iPhone 12",
  "weight": 300,
  "height": 14,
  "length": 8,
  "width": 10,
  "provider_id": 1,
  "sku": "VC4OQWPJQGMZOAIDRGSP",
  "category_id": 2,
  "status": "disabled",
  "provider": {
    "id": 1,
    "trading_name": "A Presentes",
    "company_name": "A importações LTDA ME",
    "cnpj": "21.749.641/0001-13",
    "address": "Av Paulista 500",
    "email": "contato@jpresentes.com",
    "phone": "99999-9999"
  },
  "category": {
    "id": 2,
    "name": "Eletrônicos"
  }
}
```
---
<br>
<br>

## **Fornecedores**

### **Listar todos os Fornecedores**

Requisição:

```
GET /api/v1/suppliers
```

Resposta:
```
Status: 200 (OK)

[
  {
    "id": 1,
    "trading_name": "A Presentes",
    "company_name": "A importações LTDA ME",
    "cnpj": "21.749.641/0001-13",
    "address": "Av Paulista 500",
    "email": "contato@jpresentes.com",
    "phone": "99999-9999",
    "product_models": [
      {
        "id": 1,
        "name": "SmartWatch",
        "weight": 300,
        "height": 14,
        "length": 8,
        "width": 10,
        "provider_id": 1,
        "sku": "VC4OQWPJQGMZOAIDRGSP",
        "created_at": "2022-04-08T21:30:34.276Z",
        "updated_at": "2022-04-08T21:30:34.276Z",
        "category_id": 2,
        "status": "disabled"
      }
    ]
  },
  {
    "id": 2,
    "trading_name": "C Modas",
    "company_name": "C Confecções LTDA",
    "cnpj": "08.385.207/0001-33",
    "address": "Av Europa 250",
    "email": "contato@cconfec.com",
    "phone": "99999-9000",
    "product_models": [
      {
        "id": 4,
        "name": "Camiseta Homem de ferro",
        "weight": 100,
        "height": 75,
        "length": 1,
        "width": 40,
        "provider_id": 2,
        "sku": "HMCQ7UVXH2P5706T3FTR",
        "created_at": "2022-04-08T21:30:34.382Z",
        "updated_at": "2022-04-08T21:30:34.382Z",
        "category_id": 1,
        "status": "disabled"
      }
    ]
  }
]
```

---
### **Ver um fornecedor**

Requisição:

```
GET /api/v1/suppliers/1
```

Resposta:
```
Status: 200 (OK)

{
  "id": 1,
  "trading_name": "A Presentes",
  "company_name": "A importações LTDA ME",
  "cnpj": "21.749.641/0001-13",
  "address": "Av Paulista 500",
  "email": "contato@jpresentes.com",
  "phone": "99999-9999",
  "product_models": [
    {
      "id": 1,
      "name": "SmartWatch",
      "weight": 300,
      "height": 14,
      "length": 8,
      "width": 10,
      "sku": "VC4OQWPJQGMZOAIDRGSP",
      "status": "disabled",
      "category": {
        "id": 2,
        "name": "Eletrônicos"
      }
    }
  ]
}
```

---

### **Cadastrar um fornecedor**

Requisição:
```
POST /api/v1/suppliers/
```
Parâmetros:
```
{
  "trading_name": "A Presentes",
  "company_name": "A importações LTDA ME",
  "cnpj": "21.749.641/0001-13",
  "address": "Av Paulista 500",
  "email": "contato@jpresentes.com",
  "phone": "99999-9999",
}
```
Resposta:
```
{
  "id": 1,
  "trading_name": "A Presentes",
  "company_name": "A importações LTDA ME",
  "cnpj": "21.749.641/0001-13",
  "address": "Av Paulista 500",
  "email": "contato@jpresentes.com",
  "phone": "99999-9999",
  "product_models": []
}
```
