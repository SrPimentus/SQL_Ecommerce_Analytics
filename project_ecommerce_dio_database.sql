-- Criação do banco de dados chamado "ecommerce"
create database ecommerce;
use ecommerce;
-- drop database ecommerce;

-- ========================================================
-- TABELA CLIENTES (Informação de Cadastro de Clientes)
-- ========================================================
create table clients(
    idClient int auto_increment primary key,  
    Fname varchar(30) not null,               
    Minit char(3),                            
    Lname varchar(30),                        
    Address varchar(255) not null,            
    Email varchar(100) unique not null,
    contact varchar(11)
);
alter table clients auto_increment=1;  

-- ========================================================
-- CLIENTE PESSOA FÍSICA (Cadastro de clientstes pessoa física)
-- ========================================================
create table client_pf(
    idClient int primary key,                 
    CPF char(11) unique not null,             
    constraint fk_client_pf foreign key (idClient) references clients(idClient)
        on update cascade on delete cascade   
);

-- ========================================================
-- CLIENTE PESSOA JURÍDICA (Cadastro de clientes pessoa jurídica)
-- ========================================================
create table client_pj(
    idClient int primary key,                 
    CNPJ char(14) unique not null,            
    SocialName varchar(255) not null,         
    constraint fk_client_pj foreign key (idClient) references clients(idClient)
        on update cascade on delete cascade
);

-- ========================================================
-- PRODUTOS (Cadastro de Produtos)
-- ========================================================
create table product(
    idProduct int auto_increment primary key, 
    Pname varchar(50) not null,               
    classification_kids bool default false,   
    category enum(                            
        'Eletrônico', 'Vestimenta', 'Brinquedos',
        'Alimentos', 'Móveis', 'Livros', 'Limpeza', 'Games'
    ) not null,
    avaliação int default 0,                
    size varchar(20),                         
    unitPrice DECIMAL(10,2) NOT NULL, -- Preço unitário        
    profitMargin DECIMAL(5,2) NOT NULL -- Margem de Lucro
);
alter table product auto_increment=1;

-- ========================================================
-- PAGAMENTOS (Controle de Pagamentos)
-- ========================================================
create table payments(
    id_payment int auto_increment primary key, 
    idClient int not null,                     
    typePayment enum('Dinheiro', 'Boleto', 'Cartão Débito', 'Cartão Crédito', 'Pix') not null,
    details varchar(100), -- Ex: número do cartão ou chave Pix
    limitAvailable DECIMAL(10,2) default 0.00, -- Limite disponível (para cartão, por ex.)
    constraint fk_payment_client foreign key (idClient) references clients(idClient)
        on update cascade on delete cascade
);
alter table payments auto_increment=1;

-- ========================================================
-- PEDIDOS (Lista de Pedidos)
-- ========================================================
create table orders(
    idOrder int auto_increment primary key,   
    idClient int,                             
    id_payment int,                           
    orderStatus enum('Cancelado', 'Confirmado', 'Em processamento') default 'Em processamento',
    orderDescription varchar(255),            -- Observação do pedido
    sendValue DECIMAL(10,2) default 10.00,    -- Valor do frete
    constraint fk_orders_client foreign key (idClient) references clients(idClient)
        on update cascade on delete set null, -- Se cliente for excluído, fica NULL
    constraint fk_orders_payment foreign key (id_payment) references payments(id_payment)
        on update cascade on delete set null  -- Se pagamento for excluído, fica NULL
);
alter table orders auto_increment=1;

-- ========================================================
-- ENTREGA (Transporte do Produto)
-- ========================================================
create table delivery(
    idDelivery int auto_increment primary key,
    idOrder int not null,
    trackingCode varchar(50) unique, -- Código de rastreio
    deliveryStatus enum('Preparando', 'Enviado', 'Em trânsito', 'Entregue', 'Cancelado') default 'Preparando', -- Status da Entrega
    constraint fk_delivery_order foreign key (idOrder) references orders(idOrder)
        on update cascade on delete cascade
);

-- ========================================================
-- ESTOQUE (Controle de Estoque)
-- ========================================================
create table productStorage(
    idProdStorage int auto_increment primary key,
    storageLocation varchar(255), -- Localização do estoque
    quantity int default 0 -- Quantidade disponível
);

-- ========================================================
-- FORNECEDOR (Cadastro de Fornecedores)
-- ========================================================
create table supplier(
    idSupplier int auto_increment primary key,
    SocialName varchar(255) not null,         
    CNPJ char(14) not null unique,            
    contact char(11),                         
    email varchar(100) unique                 
);

-- ========================================================
-- VENDEDOR (Cadastro de Vendedores)
-- ========================================================
create table seller(
    idSeller int auto_increment primary key,
    SocialName varchar(255) not null, -- Nome/Razão social
    AbstName varchar(255), -- Nome fantasia
    CNPJ char(14) unique,
    CPF char(11) unique,
    location varchar(255), -- Localização
    contact char(11) not null -- Telefone
);

-- ========================================================
-- RELACIONAMENTO PRODUTO x VENDEDOR (Quais produtos estão sendo vendidos pelos vendedores?)
-- ========================================================
create table productSeller(
    idSeller int,
    idProduct int,
    prodQuantity int default 1,               
    primary key (idSeller, idProduct),
    constraint fk_productSeller_seller foreign key (idSeller) references seller(idSeller),
    constraint fk_productSeller_product foreign key (idProduct) references product(idProduct)
);

-- ========================================================
-- RELACIONAMENTO PRODUTO x PEDIDO (Quais produtos foram incluídos aos pedidos?)
-- ========================================================
create table productOrder(
    idProduct int,
    idOrder int,
    poQuantity int default 1, -- Quantidade do produto no pedido
    poStatus enum('Disponível', 'Sem estoque') default 'Disponível',
    primary key (idProduct, idOrder),
    constraint fk_productOrder_product foreign key (idProduct) references product(idProduct),
    constraint fk_productOrder_order foreign key (idOrder) references orders(idOrder)
);

-- ========================================================
-- LOCALIZAÇÃO DO ESTOQUE 
-- ========================================================
create table storageLocation(
    idProduct int,
    idStorage int,
    location varchar(255) not null, -- Localização detalhada do item
    primary key (idProduct, idStorage),
    constraint fk_storageLocation_product foreign key (idProduct) references product(idProduct),
    constraint fk_storageLocation_storage foreign key (idStorage) references productStorage(idProdStorage)
);

-- ========================================================
-- RELACIONAMENTO PRODUTO x FORNECEDOR (Quem é o fornecedor do produto?)
-- ========================================================
create table productSupplier(
    idSupplier int,
    idProduct int,
    quantity int not null, -- Quantidade fornecida
    primary key (idSupplier, idProduct),
    constraint fk_productSupplier_supplier foreign key (idSupplier) references supplier(idSupplier),
    constraint fk_productSupplier_product foreign key (idProduct) references product(idProduct)
);
