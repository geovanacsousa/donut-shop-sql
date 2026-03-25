#  🍩 Donut Shop Database
Projeto de banco de dados relacional em PostgreSQL com foco em organização, consistência e exploração analítica de dados de uma loja de donuts.

---


## 📋 Sobre o Projeto

Este projeto simula o banco de dados de uma loja de donuts, cobrindo o cadastro de clientes, cardápio com categorias, e o ciclo completo de pedidos. 
O objetivo é demonstrar boas práticas de modelagem relacional, integridade de dados e construção de consultas analíticas voltadas à geração de insights.


---

## 🗂️ Estrutura do Repositório

```
donut-shop-sql/
├── schema.sql    # Criação das tabelas, constraints e índices
├── seed.sql      # Dados de exemplo para testes
├── queries.sql   # Consultas analíticas (relatórios e KPIs) 
└── README.md 
```

---

## 🧩 Modelo de Dados (ER) 

```
clientes
  └── pedidos (1:N)
        └── itens_pedido (1:N)
              └── produtos (N:1)
                    └── categorias (N:1)
```

### Tabelas

| Tabela         | Descrição                                          |
|----------------|----------------------------------------------------|
| `clientes`     | Dados dos compradores                              |
| `categorias`   | Classificação dos produtos (Clássico e Recheado)   |                            
| `produtos`     | Cardápio com preço e controle de estoque           |
| `pedidos`      | Cabeçalho do pedido com status e valor total       |
| `itens_pedido` | Itens de cada pedido com quantidade e preço        |

---

## ⚙️ Como Executar

### Pré-requisitos
- [PostgreSQL](https://www.postgresql.org/download/) (versões recentes)
- ou uma instância em nuvem como Neon (https://neon.tech)

### Passo a passo

```bash
# 1. Conecte ao PostgreSQL
psql -U postgres

# 2. Crie e acesse o banco de dados
CREATE DATABASE donut_shop;
\c donut_shop

# 3. Execute os scripts na ordem
\i schema.sql
\i seed.sql
\i queries.sql
```

---

## 📊 Consultas Disponíveis

As queries em `queries.sql` cobrem os seguintes cenários:

1. **Total de pedidos e receita por status** — visão geral do fluxo
2. **Clientes que mais compraram** — ranking dos mais fiéis
3. **Donuts mais vendidos** — por quantidade e receita gerada
4. **Receita por categoria** — Clássico vs Recheado
5. **Histórico completo de um cliente** — detalhamento individual
6. **Pedidos com mais de 1 sabor** — análise de variedade
7. **Donuts com estoque baixo** — alerta de reposição
8. **Receita mensal** — evolução nos últimos 6 meses
9. **Clientes sem pedidos** — identificação de inativos
10. **View de resumo por cliente** — `vw_resumo_clientes`

---

## 🛠️ Tecnologias

- **PostgreSQL**
- SQL (DDL + DML + DQL)

---

## 📌 Conceitos Aplicados

O projeto foi estruturado separando os tipos de operações SQL para refletir um fluxo real de desenvolvimento:

- DDL (Data Definition Language)
 Responsável pela definição da estrutura do banco de dados
→ schema.sql
- DML (Data Manipulation Language)
Responsável pela manipulação dos dados
→ seed.sql
- DQL (Data Query Language)
Responsável pela consulta e análise dos dados
→ queries.sql

Recursos Utilizados
- Chaves primárias e estrangeiras (`PRIMARY KEY`, `FOREIGN KEY`)
- Restrições de integridade (`CHECK`, `NOT NULL`, `UNIQUE`)
- Relacionamentos `1:N` e `N:N` via tabela associativa
- `JOIN` (INNER, LEFT)
- Agregações com `GROUP BY`, `HAVING`, `SUM`, `COUNT`, `AVG`
- Índices para otimização de consultas
- `VIEW` para encapsulamento de lógica de negócio
- Funções de data (`DATE_TRUNC`, `TO_CHAR`, `INTERVAL`)
