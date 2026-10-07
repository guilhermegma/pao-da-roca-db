-- Inserindo Fornecedores
INSERT INTO Fornecedores (cnpj, razao_social, endereco) VALUES 
('11.111.111/0001-11', 'Moinho Fazenda Trigo LTDA', 'Rua da Farinha, 100 - Centro'),
('22.222.222/0001-22', 'Laticínios Vale Verde', 'Estrada do Leite, Km 2');

-- Inserindo Catálogo de Insumos (Sem quantidade aqui, apenas o nome)
INSERT INTO Insumos (nome, unidade_medida) VALUES 
('Farinha de Trigo', 'kg'),
('Fermento Biológico', 'kg'),
('Leite Integral', 'litros');

-- Inserindo Catálogo de Produtos
INSERT INTO Produtos (nome, tipo_produto, valor_venda) VALUES 
('Pão Francês', 'Artesanal', 0.80),
('Bolo de Milho', 'Artesanal', 15.00),
('Coca-Cola 2L', 'Industrializado', 12.00);

-- Vinculando Insumos aos Fornecedores
INSERT INTO Fornecimento (id_fornecedor, id_insumo, preco_acordado) VALUES 
(1, 1, 3.40),
(1, 2, 11.50),
(2, 3, 3.80);

-- Recebendo Estoque Físico: Lotes de Insumos
INSERT INTO Lote_Insumo (id_insumo, data_compra, data_fabricacao, data_validade, quantidade_atual, valor_compra) VALUES 
(1, '2026-10-01', '2026-09-15', '2027-03-15', 100.000, 3.50), -- Lote de Farinha
(2, '2026-10-01', '2026-09-20', '2026-12-20', 5.000, 12.00),  -- Lote de Fermento
(3, '2026-10-05', '2026-10-02', '2026-10-15', 20.000, 4.00);  -- Lote de Leite (Perecível)

-- Dando entrada no Estoque Físico: Lotes de Produtos (Fornadas ou Compras)
INSERT INTO Lote_Produto (id_produto, data_fabricacao, data_validade, quantidade_atual) VALUES 
(1, '2026-10-07', '2026-10-08', 150.000), -- Fornada de Pão de hoje
(2, '2026-10-06', '2026-10-10', 8.000),   -- Fornada de Bolo de ontem
(3, NULL, '2027-08-01', 45.000);          -- Engradado de Coca-Cola recebido

-- Inserindo Receitas e Ficha Técnica
INSERT INTO Receitas (id_produto, descricao_preparo) VALUES 
(1, 'Misturar farinha, água, sal e fermento. Deixar descansar por 2 horas e assar a 200 graus.');

INSERT INTO Receita_Insumo (id_receita, id_insumo, quantidade_utilizada) VALUES 
(1, 1, 0.020), -- 20g de farinha
(1, 2, 0.001); -- 1g de fermento

-- Inserindo Clientes
INSERT INTO Clientes (cpf, nome, numero_contato, data_nascimento, valor_acumulado) VALUES 
('111.111.111-11', 'João Carlos da Silva', '71999991111', '1985-05-15', 150.50),
('333.333.333-33', 'Carlos Eduardo', '71999993333', '1978-02-03', 450.00);

-- Registrando Vendas (Com Cliente Identificado e Venda Anônima)
INSERT INTO Vendas (id_cliente, data_hora, valor_total, forma_pagamento) VALUES 
(1, '2026-10-07 07:30:00', 8.00, 'Pix'),     -- João comprou
(NULL, '2026-10-07 08:15:00', 12.00, 'Dinheiro'); -- Cliente Anônimo (FK como NULL)

-- Inserindo Itens nas Vendas (Produto_Venda)
INSERT INTO Produto_Venda (id_venda, id_produto, quantidade_vendida, preco_unitario) VALUES 
(1, 1, 10.000, 0.80), -- 10 pães franceses na Venda 1
(2, 3, 1.000, 12.00); -- 1 Coca-Cola na Venda 2