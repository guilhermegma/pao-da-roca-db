-- Inserindo Fornecedores
INSERT INTO Fornecedores (cnpj, razao_social, endereco) VALUES 
('11.111.111/0001-11', 'Moinho Fazenda Trigo LTDA', 'Rua da Farinha, 100 - Centro'),
('22.222.222/0001-22', 'Laticínios Vale Verde', 'Estrada do Leite, Km 2'),
('33.333.333/0001-33', 'Distribuidora Bebidas Frias', 'Av. das Indústrias, 500');

-- Inserindo Insumos
INSERT INTO Insumos (nome, unidade_medida, valor_compra_atual, quantidade_estoque) VALUES 
('Farinha de Trigo', 'kg', 3.50, 150.000),
('Fermento Biológico', 'kg', 12.00, 5.000),
('Leite Integral', 'litros', 4.00, 30.000),
('Ovos', 'unidade', 0.50, 360.000);

-- Vinculando Insumos aos Fornecedores (Fornecimento)
INSERT INTO Fornecimento (id_fornecedor, id_insumo, preco_acordado) VALUES 
(1, 1, 3.40),
(1, 2, 11.50),
(2, 3, 3.80);

-- Inserindo Clientes
INSERT INTO Clientes (cpf, nome, telefone, data_nascimento, valor_acumulado) VALUES 
('111.111.111-11', 'João Carlos da Silva', '71999991111', '1985-05-15', 150.50),
('222.222.222-22', 'Maria Antonieta', '71999992222', '1990-10-20', 35.00),
('333.333.333-33', 'Carlos Eduardo', '71999993333', '1978-02-03', 450.00);

-- Inserindo Produtos
INSERT INTO Produtos (nome, tipo_produto, valor_compra, valor_venda, quantidade_estoque) VALUES 
('Pão Francês', 'Artesanal', NULL, 0.80, 200.000),
('Bolo de Milho', 'Artesanal', NULL, 15.00, 10.000),
('Coca-Cola 2L', 'Industrializado', 6.00, 12.00, 50.000);

-- Inserindo Receitas
INSERT INTO Receitas (id_produto, descricao_preparo) VALUES 
(1, 'Misturar farinha, água, sal e fermento. Deixar descansar por 2 horas e assar a 200 graus.'),
(2, 'Bater o milho com leite, ovos e farinha. Assar por 40 min.');

-- Vinculando Insumos às Receitas (Ficha Técnica)
INSERT INTO ReceitasInsumo (id_receita, id_insumo, quantidade_utilizada) VALUES 
(1, 1, 0.020),
(1, 2, 0.001),
(2, 3, 0.200),
(2, 4, 3.000);

-- Inserindo Vendas
INSERT INTO Vendas (id_cliente, data_hora, valor_total, forma_pagamento) VALUES 
(1, '2026-10-04 07:30:00', 8.00, 'Pix'),
(NULL, '2026-10-04 08:15:00', 12.00, 'Dinheiro'),
(3, '2026-10-04 17:00:00', 31.00, 'Cartão de Crédito');

-- Inserindo Itens nas Vendas
INSERT INTO Itens_venda (id_venda, id_produto, quantidade_vendida, preco_unitario) VALUES 
(1, 1, 10.000, 0.80),
(2, 3, 1.000, 12.00),
(3, 1, 5.000, 0.80),
(3, 2, 1.000, 15.00),
(3, 3, 1.000, 12.00);