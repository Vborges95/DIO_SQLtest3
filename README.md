# DIO_SQLtest3

# 🛒 Projeto de Banco de Dados - E-commerce

Este projeto consiste na modelagem lógica de um banco de dados para um sistema de **e-commerce**, com base em boas práticas de modelagem relacional, uso de chaves primárias e estrangeiras, constraints e normalização. A implementação foi feita em MySQL.

## 📘 Descrição

A estrutura foi projetada para suportar operações comuns de um sistema de comércio eletrônico, como:

- Cadastro de clientes (Pessoa Física e Jurídica)
- Gerenciamento de produtos, categorias e fornecedores
- Registro de pedidos, itens de pedido, pagamentos e entregas
- Controle de estoque por produto
- Associação de vendedores às vendas

## 🗺️ Modelo Entidade-Relacionamento (EER)

Abaixo está o diagrama ER que representa a estrutura do banco de dados modelado para o cenário de e-commerce:

![Modelo ER do Banco de Dados](./diagrama3.png)

## 🛠️ Estrutura das Tabelas

- **Cliente**: Suporta tanto PF quanto PJ (mutuamente exclusivos via constraint).
- **Endereço**: Ligado ao cliente.
- **Fornecedor**: Fornece produtos.
- **Categoria**: Classifica produtos.
- **Produto**: Referencia categoria e fornecedor.
- **Estoque**: Relacionado ao produto.
- **Vendedor**: Realiza vendas.
- **Pedido**: Contém cliente, vendedor e status.
- **ItemPedido**: Representa os itens em um pedido.
- **Pagamento**: Permite múltiplas formas de pagamento por pedido.
- **Entrega**: Registra status e código de rastreio.

## 🧪 Scripts

- Criação das tabelas com constraints
- Inserção de dados fictícios (mínimo 3 por entidade)
- Consultas SQL utilizando:

### ✅ Comandos usados:
- `SELECT`, `WHERE`, `JOIN`, `ORDER BY`, `GROUP BY`, `HAVING`
- Cálculo de valores derivados (ex: total por item)
- Filtros por tipo, valor, status etc.

## ❓ Exemplos de Consultas

- Quantos pedidos foram feitos por cliente
- Relação entre produtos e fornecedores
- Produtos em estoque e sua quantidade
- Pedidos com status e código de rastreio
- Vendedores com média de frete por pedido

## 📁 Organização

- `create_database.sql` – Criação do banco e tabelas
- `insert_data.sql` – População com dados fictícios
- `queries.sql` – Consultas de teste

## 🚀 Como usar

1. Abra o MySQL Workbench
2. Execute o script de criação do banco
3. Insira os dados de exemplo
4. Teste as queries fornecidas

---

**Autor:** Vinicius Borges  
**Desafio:** DIO – Projeto de Modelagem de Banco de Dados  
**Tecnologias:** MySQL
