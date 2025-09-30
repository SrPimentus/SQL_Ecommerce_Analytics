use ecommerce;

-- Recuperações simples com SELECT Statement
-- Filtros com WHERE Statement
-- Crie expressões para gerar atributos derivados
-- Defina ordenações dos dados com ORDER BY
-- Condições de filtros aos grupos – HAVING Statement
-- Crie junções entre tabelas para fornecer uma perspectiva mais complexa dos dado

-- ======================================================
-- Recuperação de Dados
-- ======================================================

-- Quem são os clientes cadastrados e como podemos contatá-los?
SELECT 
	concat(Fname,' ',Lname) as nome_completo, Email 
FROM 
	clients;
    
-- Produtos infantis disponíveis
SELECT Pname FROM product WHERE classification_kids = true;

-- Entregas cadastradas com rastreamento e status
-- Hipótese: Acompanhamento do status pode reduzir o número de reclamações de clientes.
SELECT trackingCode, deliveryStatus FROM delivery;
    
-- Quantidade de pedidos feitos por cliente
SELECT 
    c.idClient,
    c.Fname AS nome,
    c.Lname AS sobrenome,
    COUNT(o.idOrder) AS total_pedidos
FROM clients c
JOIN orders o ON c.idClient = o.idClient
GROUP BY c.idClient, c.Fname, c.Lname
ORDER BY total_pedidos DESC;

-- Algum vendedor também é fornecedor?
SELECT 
    s.SocialName AS nome_vendedor,
    s.CNPJ AS cnpj_vendedor,
    sup.SocialName AS nome_fornecedor,
    sup.CNPJ AS cnpj_fornecedor
FROM seller s
JOIN supplier sup ON s.CNPJ = sup.CNPJ;

-- Relação de produtos, fornecedores e estoques
SELECT
    S.SocialName AS Nome_Fornecedor, 
    P.Pname AS Nome_Produto,         
    PS.quantity AS Quantidade_Fornecida 
FROM
    supplier S
JOIN
    productSupplier PS ON S.idSupplier = PS.idSupplier 
JOIN
    product P ON PS.idProduct = P.idProduct
ORDER BY
	Quantidade_Fornecida DESC;

-- Produtos disponíveis com categorias e preços
-- Hipótese: Categorias com preços mais altos podem gerar maior margem de lucro.
SELECT 
	Pname as produto, 
    category as categoria, 
    unitPrice as preco_venda 
FROM 
	product
order by 
	unitPrice desc;

-- Produtos com maior margem de lucro
-- Hipótese: Alguns produtos são mais rentáveis que outros, mesmo com menor volume de vendas.
SELECT 
	idProduct, 
    Pname, 
    category,unitPrice as preco_venda,
    profitMargin as margem_lucro 
FROM 
	product
order by 
	margem_lucro desc;

-- Volume de compra: clientes PJ x PF
-- Hipótese: Clientes PJ compram em maior quantidade que clientes PF.
select 
    case 
        when pj.idClient is not null then 'Pessoa Jurídica'
        else 'Pessoa Física'
    end as tipo_cliente,
    sum(po.poQuantity) as total_itens_comprados
from orders o
join productOrder po on o.idOrder = po.idOrder
left join client_pj pj on o.idClient = pj.idClient
left join client_pf pf on o.idClient = pf.idClient
group by tipo_cliente;

-- Top 5 produtos mais vendidos
-- Hipótese: Poucos produtos concentram a maior parte das vendas.
select 
    p.Pname as produto,
    sum(po.poQuantity) as quantidade_total
from productOrder po
join product p on po.idProduct = p.idProduct
group by p.Pname
order by quantidade_total desc
limit 5;

-- Receita total por cliente 
-- Hipótese: Existe uma concentração de receita em poucos clientes.
select 
	concat(c.Fname,' ',c.Lname) as nome_completo,
    sum(po.poQuantity * p.unitPrice) as receita_cliente
from orders o
join clients c on o.idClient = c.idClient
join productOrder po on o.idOrder = po.idOrder
join product p on po.idProduct = p.idProduct
where o.orderStatus = 'Confirmado'
group by c.idClient
order by receita_cliente desc;

-- Categoria de produto que mais gera receita
-- Hipótese: Algumas categorias concentram maior valor de receita.
select 
    p.category,
    sum(po.poQuantity * p.unitPrice) as receita_categoria
from productOrder po
join product p on po.idProduct = p.idProduct
join orders o on po.idOrder = o.idOrder
where o.orderStatus = 'Confirmado'
group by p.category
order by receita_categoria desc;

-- Ranking de vendedores (lojas) por quantidade vendida
-- Hipótese: Pequeno número de vendedores concentra a maior parte das vendas.
select 
    s.SocialName as vendedor,
    sum(po.poQuantity) as total_vendido
from productOrder po
join product p on po.idProduct = p.idProduct
join productSeller ps on p.idProduct = ps.idProduct
join seller s on ps.idSeller = s.idSeller
group by s.idSeller
order by total_vendido desc;

-- Pedidos cancelados por tipo de cliente (PJ x PF)
-- Hipótese: Clientes PJ podem ter maior índice de cancelamento por volume de compras.
select 
    case 
        when pj.idClient is not null then 'Pessoa Jurídica'
        else 'Pessoa Física'
    end as tipo_cliente,
    count(*) as total_cancelados
from orders o
left join client_pj pj on o.idClient = pj.idClient
left join client_pf pf on o.idClient = pf.idClient
where o.orderStatus = 'Cancelado'
group by tipo_cliente;

-- Fornecedores que mais contribuem para o estoque
-- Hipótese: Poucos fornecedores concentram a maior parte do fornecimento.
select 
    s.SocialName as fornecedor,
    sum(psup.quantity) as total_fornecido
from productSupplier psup
join supplier s on psup.idSupplier = s.idSupplier
group by s.idSupplier
order by total_fornecido desc;

-- Tempo médio de entrega de pedidos concluídos
-- Hipótese: O tempo médio de entrega pode ser utilizado para SLA com clientes.
select 
    d.deliveryStatus,
    avg(datediff(curdate(), o.orderDate)) as tempo_medio_dias
from delivery d
join orders o on d.idOrder = o.idOrder
where d.deliveryStatus = 'Entregue'
group by d.deliveryStatus;


-- Classificação ABC de produtos com base na margem de lucro total
-- Hipótese: Poucos produtos (classe A) geram a maior parte do lucro.
with lucro_produtos as (
    -- 1. Calcula o lucro total de cada produto
    select 
        p.idProduct,
        p.Pname,
        -- Fórmula: (Preço unitário × Margem de lucro %) × Quantidade vendida
        sum(po.poQuantity * (p.unitPrice * (p.profitMargin / 100))) as lucro_total
    from productOrder po
    join product p on po.idProduct = p.idProduct
    join orders o on po.idOrder = o.idOrder
    where o.orderStatus = 'Confirmado' -- Considera apenas vendas confirmadas
    group by p.idProduct, p.Pname
),
lucro_ordenado as (
    -- 2. Ordena os produtos pelo lucro em ordem decrescente
    select 
        lp.*,
        -- Percentual do lucro de cada produto em relação ao total
        (lp.lucro_total / (select sum(lucro_total) from lucro_produtos)) * 100 as perc_lucro
    from lucro_produtos lp
    order by lp.lucro_total desc
),
acumulado as (
    -- 3. Calcula o percentual acumulado do lucro
    select 
        lo.*,
        sum(lo.perc_lucro) over (order by lo.lucro_total desc) as perc_acumulado
    from lucro_ordenado lo
)
-- 4. Classificação ABC
select 
    a.idProduct,
    a.Pname,
    round(a.lucro_total,2) as lucro_total,
    round(a.perc_lucro,2) as perc_lucro,
    round(a.perc_acumulado,2) as perc_acumulado,
    case 
        when a.perc_acumulado <= 80 then 'A'   -- Classe A: até 80% do lucro acumulado
        when a.perc_acumulado <= 95 then 'B'   -- Classe B: de 80% a 95%
        else 'C'                               -- Classe C: restante
    end as classificacao
from acumulado a;

-- Clientes com receita superior a R$ 2.000 em pedidos confirmados
SELECT 
    c.Fname AS nome,
    c.Lname AS sobrenome,
    SUM(po.poQuantity * p.unitPrice) AS receita_total
FROM orders o
JOIN clients c ON o.idClient = c.idClient
JOIN productOrder po ON o.idOrder = po.idOrder
JOIN product p ON po.idProduct = p.idProduct
WHERE o.orderStatus = 'Confirmado'
GROUP BY c.idClient, c.Fname, c.Lname
HAVING receita_total > 2000
ORDER BY receita_total DESC;



