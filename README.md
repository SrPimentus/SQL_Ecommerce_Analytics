# 🛒 Projeto de Banco de Dados para E-commerce  

<img width="1408" height="768" alt="Image" src="https://github.com/user-attachments/assets/a63801c5-d652-43f5-abd5-76dd12f72d08" />

> 🚀 Este projeto foi desenvolvido durante o módulo **"Explorando Bancos Relacionais e Consultas em SQL"** do **Bootcamp Klabin - Análise de Dados com Excel e Power BI Dashboards** da [Digital Innovation One (DIO)](https://www.dio.me/) em parceria com a empresa **Klabin**.  

--- 

## 📌 Sobre o Projeto  

O objetivo foi **replicar e refinar a modelagem de um banco de dados para um cenário de e-commerce**, contemplando desde a **definição de chaves e constraints**, até a criação do **script SQL** com inserção de dados de teste e queries mais complexas.  

Durante o desafio, foram aplicados conceitos de **modelagem lógica, relacional e EER**, além da implementação de boas práticas de integridade e consistência de dados.  

> ⚠️ Observação: todos os dados utilizados para abastecer o banco foram gerados de forma aleatória utilizando **inteligência artificial**, garantindo diversidade sem expor informações reais de clientes ou empresas.

---

## 📚 Objetivo de Aprendizado  

Este projeto me permitiu:  
- Consolidar conceitos de **modelagem relacional** e **EER**.  
- Praticar **criação de schemas SQL complexos**.  
- Simular hipóteses de negócio reais através de consultas avançadas.  

---

## 📊 Consultas SQL  

O projeto inclui queries que respondem a hipóteses de negócio, como:  

- Quantos pedidos foram feitos por cliente?  
- Existe algum vendedor que também é fornecedor?  
- Qual a relação entre produtos e fornecedores?  
- Como se distribuem os produtos segundo a **curva ABC** baseada em margem de lucro?  

> Todas as queries estão comentadas no código para facilitar o entendimento.

---

## 🛠️ Tecnologias Utilizadas  

- **<img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/mysql/mysql-original-wordmark.svg" alt="MySQL Logo" width="35" style="vertical-align:middle; margin-right:5px;"> MySQL** para criação e gerenciamento do banco de dados.
- **<img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/microsoftsqlserver/microsoftsqlserver-original.svg" alt="Workbench Logo" width="30" style="vertical-align:middle; margin-right:5px;"> Workbench** para modelagem visual.
- **<img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/azuresqldatabase/azuresqldatabase-original.svg" alt="SQL Logo" width="30" style="vertical-align:middle; margin-right:5px;"> SQL** para consultas e manipulação de dados.

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

## 📐 Diagramas do Projeto  

### 📝 Diagrama do modelo de Banco de dados Relacional Refinado
<img width="928" height="1299" alt="Image" src="https://github.com/user-attachments/assets/8101566a-d14e-4740-af7a-a25b91a9a4db" /> 

---

## 🔍 Hipóteses e Análises do Projeto


| Análise | Hipótese | Descrição / Objetivo | Conclusão |
|---------|----------|-------------------|------------|
| Clientes cadastrados | - | Identificar quem são os clientes e como contatá-los | Foi possível listar todos os 10 clientes com seus emails para contato. |
| Produtos infantis disponíveis | - | Verificar quais produtos atendem ao público infantil | 2 produtos classificados como infantis: Boneco Avengers e Chocolate Nestlé. |
| Entregas cadastradas com rastreamento | Acompanhamento do status pode reduzir o número de reclamações | Monitorar status das entregas | Hipótese plausível: é possível acompanhar todas as entregas, mas não há dados de reclamações para confirmar efeito. |
| Quantidade de pedidos por cliente | - | Identificar clientes mais ativos | Clientes com maior número de pedidos: João e Ana. |
| Algum vendedor também é fornecedor | - | Verificar se há sobreposição de funções | Nenhum vendedor também é fornecedor. |
| Produtos, fornecedores e estoques | - | Relacionar produtos aos fornecedores e quantidades fornecidas | 'Fornecedor Alimentos' fornece a maior quantidade. |
| Produtos com categorias e preços | Categorias com preços mais altos podem gerar maior margem de lucro | Observar faixa de preço por categoria | Verdadeiro: produtos mais caros tendem a gerar maior margem de lucro. |
| Produtos com maior margem de lucro | Alguns produtos são mais rentáveis mesmo com menor volume | Identificar produtos mais lucrativos | Verdadeiro: alguns produtos têm margem significativamente maior, independente do volume. |
| Volume de compra: PJ x PF | Clientes PJ compram em maior quantidade que PF | Comparar quantidade de itens comprados por tipo de cliente | Falso: PF comprou mais itens que PJ neste dataset. |
| Top 5 produtos mais vendidos | Poucos produtos concentram a maior parte das vendas | Identificar produtos mais vendidos | Verdadeiro: poucos produtos concentram a maior parte das vendas. |
| Receita total por cliente | Existe concentração de receita em poucos clientes | Calcular receita total por cliente | Verdadeiro: poucos clientes concentram a maior parte da receita. |
| Categoria que mais gera receita | Algumas categorias concentram maior valor de receita | Identificar categorias mais lucrativas | Verdadeiro: uma categoria específica gera maior receita que as demais. |
| Ranking de vendedores por quantidade vendida | Pequeno número de vendedores concentra a maior parte das vendas | Listar vendedores mais ativos | Verdadeiro: vendas concentradas em poucos vendedores. |
| Pedidos cancelados por tipo de cliente | Clientes PJ podem ter maior índice de cancelamento | Comparar pedidos cancelados por tipo | Falso: neste dataset, apenas PF teve pedido cancelado. |
| Fornecedores que mais contribuem para estoque | Poucos fornecedores concentram a maior parte do fornecimento | Identificar principais fornecedores | Verdadeiro: um fornecedor concentra a maior parte do estoque fornecido. |
| Tempo médio de entrega | - | Calcular média de dias para pedidos entregues | Tempo médio de entrega pode ser calculado e utilizado como referência. |
| Classificação ABC de produtos | Poucos produtos (classe A) geram a maior parte do lucro | Categorizar produtos por contribuição ao lucro | Verdadeiro: poucos produtos geram a maior parte do lucro total. |
| Clientes com receita acima de R$2.000 | - | Identificar clientes que geram maior receita | Clientes com maior receita: João, Ana e Lucas. |

---

## 🛠️ Instruções de Uso

Para rodar o projeto na sua máquina, siga os passos abaixo:

1. **Clonar o repositório**  
```bash
git clone https://github.com/LucasPBar/sql-ecommerce-analytics.git
cd sql-ecommerce-analytics
```
2. Abrir o MySQL Workbench ou outro cliente SQL de sua preferência.

3. Criar um novo schema com o nome desejado (ex: `ecommerce_db`).

4. Executar os scripts SQL na seguinte ordem para garantir a criação correta do banco, inserção de dados e execução das queries de análise:

  - `project_ecommerce_dio_database.sql` → Criação da infraestrutura do banco de dados (tabelas, chaves e relacionamentos).  
  - `project_ecommerce_dio_data.sql` → Abastecimento do banco com dados de teste gerados por inteligência artificial.  
  - `project_ecommerce_dio_analise.sql` → Queries para recuperar informações e testar hipóteses de negócio.

5. Explorar os dados: abra o arquivo de queries (`project_ecommerce_dio_analise.sql`) para testar consultas ou criar análises adicionais conforme desejar.

> ⚠️ Observação: Todos os dados utilizados foram gerados de forma aleatória com o uso de inteligência artificial, não correspondendo a informações reais de clientes ou empresas.
**

--- 
## 📬 Contato

| | | |
| :--- | :--- | :--- |
| **👤 Nome:** | Lucas Pimenta Barretto | |
| **<img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/linkedin/linkedin-original.svg" alt="LinkedIn" width="24" style="vertical-align:middle; margin-right:8px;"> LinkedIn:** | [linkedin.com/in/lucaspimentabarretto](https://www.linkedin.com/in/lucaspimentabarretto) | |
| **💼 Portfólio**  | [Data Science Portfolio](https://www.datascienceportfol.io/lucaspimenta1805) |


---
