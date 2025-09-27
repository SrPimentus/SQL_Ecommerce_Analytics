use ecommerce;

-- ========================================================
-- CLIENTES (10 clientes)
-- ========================================================
insert into clients (Fname, Minit, Lname, Address, Email, contact) values
('João', 'A', 'Silva', 'Rua A, 123', 'joao.silva@email.com', '11999999901'),
('Maria', 'B', 'Oliveira', 'Rua B, 456', 'maria.oliveira@email.com', '11999999902'),
('Carlos', 'C', 'Souza', 'Rua C, 789', 'carlos.souza@email.com', '11999999903'),
('Ana', 'D', 'Costa', 'Rua D, 321', 'ana.costa@email.com', '11999999904'),
('Lucas', 'E', 'Ferreira', 'Rua E, 654', 'lucas.ferreira@email.com', '11999999905'),
('Paula', 'F', 'Melo', 'Rua F, 987', 'paula.melo@email.com', '11999999906'),
('Ricardo', 'G', 'Almeida', 'Rua G, 147', 'ricardo.almeida@email.com', '11999999907'),
('Fernanda', 'H', 'Lima', 'Rua H, 258', 'fernanda.lima@email.com', '11999999908'),
('Juliana', 'I', 'Pereira', 'Rua I, 369', 'juliana.pereira@email.com', '11999999909'),
('Marcos', 'J', 'Gomes', 'Rua J, 159', 'marcos.gomes@email.com', '11999999910');

-- CLIENTES PF (6 pessoas físicas)
insert into client_pf (idClient, CPF) values
(1, '12345678901'),
(2, '23456789012'),
(3, '34567890123'),
(5, '45678901234'),
(7, '56789012345'),
(9, '67890123456');

-- CLIENTES PJ (4 pessoas jurídicas)
insert into client_pj (idClient, CNPJ, SocialName) values
(4, '11222333000181', 'Tech Solutions LTDA'),
(6, '22333444000192', 'Moda & Estilo SA'),
(8, '33444555000103', 'Alimentos Brasil ME'),
(10, '44555666000114', 'Game World Comércio');

-- ========================================================
-- PRODUTOS (12 produtos)
-- ========================================================
insert into product (Pname, classification_kids, category, avaliação, size, unitPrice, profitMargin) values
('Notebook Lenovo', false, 'Eletrônico', 5, null, 3500.00, 15.00),
('Smartphone Samsung', false, 'Eletrônico', 4, null, 2500.00, 20.00),
('Camiseta Polo', false, 'Vestimenta', 4, 'M', 79.90, 30.00),
('Boneco Avengers', true, 'Brinquedos', 5, null, 120.00, 40.00),
('Chocolate Nestlé', true, 'Alimentos', 5, '100g', 6.50, 25.00),
('Sofá Retrátil', false, 'Móveis', 4, '2m', 2200.00, 18.00),
('Livro SQL Avançado', false, 'Livros', 5, null, 89.90, 35.00),
('Detergente Ypê', false, 'Limpeza', 4, '500ml', 2.50, 15.00),
('PlayStation 5', false, 'Games', 5, null, 4500.00, 12.00),
('Controle Xbox', false, 'Games', 4, null, 350.00, 25.00),
('Vestido Feminino', false, 'Vestimenta', 5, 'G', 149.90, 30.00),
('Mesa Escritório', false, 'Móveis', 4, '1.5m', 799.90, 22.00);

-- ========================================================
-- FORNECEDORES (5 fornecedores)
-- ========================================================
insert into supplier (SocialName, CNPJ, contact, email) values
('Fornecedor Tech', '55666777000125', '1133334444', 'tech@supplier.com'),
('Fornecedor Moda', '66777888000136', '1133335555', 'moda@supplier.com'),
('Fornecedor Brinquedos', '77888999000147', '1133336666', 'toy@supplier.com'),
('Fornecedor Alimentos', '88999000000158', '1133337777', 'food@supplier.com'),
('Fornecedor Games', '99000111000169', '1133338888', 'games@supplier.com');

-- ========================================================
-- VENDEDORES (4 vendedores)
-- ========================================================
insert into seller (SocialName, AbstName, CNPJ, CPF, location, contact) values
('Tech Store LTDA', 'TechStore', '11112222000111', null, 'São Paulo', '11988887771'),
('Moda Fashion', 'Fashion', null, '12312312399', 'Rio de Janeiro', '21988887772'),
('Game House', 'GH Games', '22223333000122', null, 'Curitiba', '41988887773'),
('Casa & Móveis', 'MoveLar', '33334444000133', null, 'Belo Horizonte', '31988887774');

-- ========================================================
-- RELACIONAMENTO PRODUTO - VENDEDOR
-- ========================================================
insert into productSeller (idSeller, idProduct, prodQuantity) values
(1, 1, 10), (1, 2, 15), (1, 7, 5),
(2, 3, 50), (2, 11, 20),
(3, 9, 8), (3, 10, 12),
(4, 6, 6), (4, 12, 10);

-- ========================================================
-- ESTOQUE (5 estoques)
-- ========================================================
insert into productStorage (storageLocation, quantity) values
('CD São Paulo', 200),
('CD Rio de Janeiro', 150),
('CD Curitiba', 180),
('CD Belo Horizonte', 100),
('CD Salvador', 130);

-- LOCALIZAÇÃO DO ESTOQUE
insert into storageLocation (idProduct, idStorage, location) values
(1, 1, 'Prateleira A1'),
(2, 1, 'Prateleira A2'),
(3, 2, 'Prateleira B1'),
(4, 3, 'Prateleira C1'),
(5, 4, 'Prateleira D1'),
(6, 5, 'Prateleira E1');

-- ========================================================
-- PRODUTO - FORNECEDOR
-- ========================================================
insert into productSupplier (idSupplier, idProduct, quantity) values
(1, 1, 50), (1, 2, 70),
(2, 3, 100), (2, 11, 60),
(3, 4, 40),
(4, 5, 200), (4, 6, 30),
(5, 9, 25), (5, 10, 40);

-- ========================================================
-- PAGAMENTOS
-- ========================================================
insert into payments (idClient, typePayment, details, limitAvailable) values
(1, 'Cartão Crédito', '4111111111111111', 5000.00),
(2, 'Pix', 'pix-maria@email.com', 0.00),
(3, 'Boleto', 'Banco Itaú', 0.00),
(4, 'Cartão Débito', '5222222222222222', 2000.00),
(5, 'Dinheiro', 'Pagamento em espécie', 0.00),
(6, 'Cartão Crédito', '4333333333333333', 10000.00),
(7, 'Pix', 'pix-ricardo@email.com', 0.00),
(8, 'Cartão Crédito', '4444444444444444', 8000.00),
(9, 'Boleto', 'Banco Bradesco', 0.00),
(10, 'Pix', 'pix-marcos@email.com', 0.00);

-- ========================================================
-- PEDIDOS (10 pedidos)
-- ========================================================
insert into orders (idClient, id_payment, orderStatus, orderDescription, sendValue) values
(1, 1, 'Confirmado', 'Notebook para trabalho', 50.00),
(2, 2, 'Em processamento', 'Camiseta Polo e Vestido', 20.00),
(3, 3, 'Cancelado', 'PlayStation 5', 100.00),
(4, 4, 'Confirmado', 'Compra corporativa Tech', 70.00),
(5, 5, 'Confirmado', 'Chocolate e livro', 15.00),
(6, 6, 'Em processamento', 'Estoque Moda & Estilo', 40.00),
(7, 7, 'Confirmado', 'Controle Xbox', 25.00),
(8, 8, 'Em processamento', 'Móveis e decoração', 80.00),
(9, 9, 'Confirmado', 'Brinquedos e alimentos', 30.00),
(10, 10, 'Confirmado', 'Jogos e acessórios', 60.00);

-- ========================================================
-- PRODUTO - PEDIDO
-- ========================================================
insert into productOrder (idProduct, idOrder, poQuantity, poStatus) values
(1, 1, 1, 'Disponível'),
(3, 2, 2, 'Disponível'),
(11, 2, 1, 'Disponível'),
(9, 3, 1, 'Sem estoque'),
(1, 4, 3, 'Disponível'),
(5, 5, 5, 'Disponível'),
(7, 5, 1, 'Disponível'),
(11, 6, 4, 'Disponível'),
(10, 7, 2, 'Disponível'),
(6, 8, 1, 'Disponível'),
(12, 8, 2, 'Disponível'),
(4, 9, 2, 'Disponível'),
(5, 9, 10, 'Disponível'),
(9, 10, 1, 'Disponível'),
(10, 10, 1, 'Disponível');

-- ========================================================
-- ENTREGA
-- ========================================================
insert into delivery (idOrder, trackingCode, deliveryStatus) values
(1, 'BR123456789SP', 'Entregue'),
(2, 'BR987654321RJ', 'Em trânsito'),
(3, 'BR456789123PR', 'Cancelado'),
(4, 'BR741852963SP', 'Entregue'),
(5, 'BR852963741MG', 'Entregue'),
(6, 'BR963852741BA', 'Preparando'),
(7, 'BR159357258RS', 'Enviado'),
(8, 'BR357159456SC', 'Em trânsito'),
(9, 'BR258456159DF', 'Entregue'),
(10, 'BR654987321GO', 'Enviado');

