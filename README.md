# 🛒 Projeto de Banco de Dados para E-commerce  

<img width="1408" height="768" alt="Image" src="https://github.com/user-attachments/assets/a63801c5-d652-43f5-abd5-76dd12f72d08" />

> 🚀 Este projeto foi desenvolvido durante o módulo **"Explorando Bancos Relacionais e Consultas em SQL"** do **Bootcamp Klabin - Análise de Dados com Excel e Power BI Dashboards** da [Digital Innovation One (DIO)](https://www.dio.me/) em parceria com a empresa **Klabin**.  

---

## 📌 Sobre o Projeto  

O objetivo foi **replicar e refinar a modelagem de um banco de dados para um cenário de e-commerce**, contemplando desde a **definição de chaves e constraints**, até a criação do **script SQL** com inserção de dados de teste e queries mais complexas.  

Durante o desafio, foram aplicados conceitos de **modelagem lógica, relacional e EER**, além da implementação de boas práticas de integridade e consistência de dados.  

---

## ✨ Refinamentos Aplicados  

### 🔹 Clientes (Clients)  
- Estrutura de **herança Super-Tipo/Sub-Tipo**: separação em `client_pf` e `client_pj`.  
- Campos específicos para CPF e CNPJ, ambos **UNIQUE e NOT NULL**.  
- Inclusão de atributos como **email** (único) e **contact**.  
- Ajustes de tamanho e obrigatoriedade em campos-chave.  

### 🔹 Produtos (Product)  
- Adição de campos financeiros: **unitPrice** e **profitMargin**.  
- Ampliação das categorias com **Livros, Limpeza e Games**.  
- Ajuste de tipos de dados e tamanhos para maior consistência.  

### 🔹 Pagamentos (Payments)  
- Criação de chave primária própria (`id_payment`).  
- Relacionamento direto com clientes.  
- Expansão dos tipos de pagamento: **Pix, Crédito e Débito**.  
- Inclusão do campo `details` e melhoria de nomenclatura.  

### 🔹 Pedidos (Orders)  
- Integração com a tabela `payments`.  
- Ajustes em nomes e tipos de dados (como `sendValue`).  

### 🔹 Logística (Delivery)  
- Nova tabela para rastreio de entregas.  
- Atributos como `trackingCode` (único) e `deliveryStatus` (ENUM detalhado).  

### 🔹 Fornecedor (Supplier) e Vendedor (Seller)  
- Inclusão de **email único** em fornecedor.  
- Ajustes de tamanho em CPF e CNPJ.  

### 🔹 Tabelas de Relacionamento  
- Padronização de nomenclaturas.  
- Correção em `storageLocation` e outras entidades.  

---
## 🔍 Hipóteses e Análises do Projeto

| Análise | Hipótese | Descrição / Objetivo | Tabela / Colunas principais |
|---------|----------|-------------------|----------------------------|
| Clientes cadastrados | - | Identificar quem são os clientes e como contatá-los | clients (Fname, Lname, Email) |
| Produtos infantis disponíveis | Produtos infantis podem ter maior rotatividade em datas comemorativas | Verificar quais produtos atendem ao público infantil | product (Pname, classification_kids) |
| Entregas cadastradas com rastreamento | Acompanhamento do status pode reduzir o número de reclamações de clientes | Obter status de entrega e código de rastreamento | delivery (trackingCode, deliveryStatus) |
| Quantidade de pedidos por cliente | - | Identificar clientes mais ativos | clients, orders (idClient, Fname, Lname, idOrder) |
| Algum vendedor também é fornecedor | - | Verificar se há sobreposição de funções | seller, supplier (CNPJ, SocialName) |
| Produtos, fornecedores e estoques | - | Relacionar produtos aos fornecedores e quantidades fornecidas | supplier, productSupplier, product (SocialName, Pname, quantity) |
| Produtos com categorias e preços | Categorias com preços mais altos podem gerar maior margem de lucro | Observar faixa de preço por categoria de produto | product (Pname, category, unitPrice) |
| Produtos com maior margem de lucro | Alguns produtos são mais rentáveis mesmo com menor volume | Identificar produtos mais lucrativos | product (Pname, unitPrice, profitMargin) |
| Volume de compra: PJ x PF | Clientes PJ compram em maior quantidade que PF | Comparar quantidade total de itens comprados por tipo de cliente | orders, productOrder, client_pj, client_pf |
| Top 5 produtos mais vendidos | Poucos produtos concentram a maior parte das vendas | Obter ranking dos produtos mais vendidos | productOrder, product (Pname, poQuantity) |
| Receita total por cliente | Existe concentração de receita em poucos clientes | Calcular receita total gerada por cada cliente | clients, orders, productOrder, product |
| Categoria que mais gera receita | Algumas categorias concentram maior valor de receita | Identificar categorias mais lucrativas | productOrder, product, orders |
| Ranking de vendedores por quantidade vendida | Pequeno número de vendedores concentra a maior parte das vendas | Listar vendedores com maiores vendas em volume | productOrder, product, productSeller, seller |
| Pedidos cancelados por tipo de cliente | Clientes PJ podem ter maior índice de cancelamento | Comparar número de pedidos cancelados entre PJ e PF | orders, client_pj, client_pf |
| Fornecedores que mais contribuem para estoque | Poucos fornecedores concentram a maior parte do fornecimento | Identificar fornecedores que mais fornecem produtos | productSupplier, supplier |
| Tempo médio de entrega | Tempo médio de entrega pode ser usado para SLA com clientes | Calcular média de dias para pedidos entregues | delivery, orders |
| Classificação ABC de produtos | Poucos produtos (classe A) geram a maior parte do lucro | Categorizar produtos com base no lucro acumulado | productOrder, product, orders |
| Clientes com receita acima de R$2.000 | - | Identificar clientes que geram maior receita | clients, orders, productOrder, product |

---

## 📊 Consultas SQL  

O projeto inclui queries que respondem a hipóteses de negócio, como:  

- Quantos pedidos foram feitos por cliente?  
- Existe algum vendedor que também é fornecedor?  
- Qual a relação entre produtos e fornecedores?  
- Como se distribuem os produtos segundo a **curva ABC** baseada em margem de lucro?  

> Todas as queries estão comentadas no código para facilitar o entendimento.  

---

## 📐 Diagramas do Projeto  

### 📝 Diagrama do modelo de Banco de dados Relacional Refinado
<img width="928" height="1299" alt="Image" src="https://github.com/user-attachments/assets/8101566a-d14e-4740-af7a-a25b91a9a4db" /> 

---

## 🛠️ Tecnologias Utilizadas  

- **<img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/mysql/mysql-original-wordmark.svg" alt="MySQL Logo" width="35" style="vertical-align:middle; margin-right:5px;"> MySQL** para criação e gerenciamento do banco de dados.
- **<img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/microsoftsqlserver/microsoftsqlserver-original.svg" alt="Workbench Logo" width="30" style="vertical-align:middle; margin-right:5px;"> Workbench** para modelagem visual.
- **<img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/azuresqldatabase/azuresqldatabase-original.svg" alt="SQL Logo" width="30" style="vertical-align:middle; margin-right:5px;"> SQL** para consultas e manipulação de dados.

---

## 📚 Objetivo de Aprendizado  

Este projeto me permitiu:  
- Consolidar conceitos de **modelagem relacional** e **EER**.  
- Praticar **criação de schemas SQL complexos**.  
- Simular hipóteses de negócio reais através de consultas avançadas.  

---

## 📬 Contato

| | | |
| :--- | :--- | :--- |
| **👤 Nome:** | Lucas Pimenta Barretto | |
| **<img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/linkedin/linkedin-original.svg" alt="LinkedIn" width="24" style="vertical-align:middle; margin-right:8px;"> LinkedIn:** | [linkedin.com/in/lucaspimentabarretto](https://www.linkedin.com/in/lucaspimentabarretto) | |
| **📧 Email:** | lucaspimenta1805@gmail.com | |


---
