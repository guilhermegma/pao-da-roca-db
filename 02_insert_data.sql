-- Carga inicial: Clientes
INSERT INTO Cliente (cpf, nome, telefone, data_nascimento, valor_acumulado) VALUES
('11111111111', 'João Silva', '71988888888', '1985-05-15', 150.50),
('22222222222', 'Maria Oliveira', '71999999999', '1992-10-20', 320.00),
('33333333333', 'Carlos Souza', '71977777777', '1978-03-08', 0.00);

-- Carga inicial: Fornecedores
INSERT INTO Fornecedor (cnpj, razao_social, endereco) VALUES
('12345678000199', 'Moinho do Nordeste Ltda', 'Rua Industrial, 100 - Feira de Santana'),
('98765432000188', 'Laticínios Fazenda Boa', 'Rodovia BA-052, Km 12 - Ipirá'),
('45612378000155', 'Distribuidora de Bebidas Jacuípe', 'Av. Principal, 500 - Riachão do Jacuípe');

-- Carga inicial: Produtos
INSERT INTO Produto (nome, tipo_produto, valor_compra, valor_venda, quantidade_estoque) VALUES
('Pão Francês', 'Artesanal', NULL, 0.50, 200),
('Bolo de Fubá', 'Artesanal', NULL, 15.00, 10),
('Refrigerante Cola 2L', 'Industrializado', 6.00, 10.00, 30),
('Queijo Mussarela 100g', 'Industrializado', 3.50, 5.50, 50),
('Pão Doce', 'Artesanal', NULL, 1.50, 45);

-- Carga inicial: Insumos
INSERT INTO Insumo (nome, unidade_medida, valor_compra_atual, quantidade_estoque) VALUES
('Farinha de Trigo', 'kg', 4.50, 150.000),
('Açúcar Refinado', 'kg', 3.80, 50.000),
('Fermento Biológico', 'kg', 25.00, 5.000),
('Ovo Branco', 'unidade', 0.60, 360.000),
('Leite Integral', 'litros', 4.20, 60.000);

-- Carga inicial: Receitas
INSERT INTO Receita (descricao_preparo, id_produto) VALUES
('Misturar farinha, água, fermento e sal. Sovar bem, deixar descansar e assar a 200 graus.', 1),
('Bater ovos, leite, óleo, açúcar e fubá. Adicionar fermento e assar a 180 graus por 40 min.', 2);

-- Carga inicial: Insumos por Receita
INSERT INTO Receita_Insumo (id_receita, id_insumo, quantidade_utilizada) VALUES
(1, 1, 0.500),
(1, 3, 0.010),
(2, 2, 0.300),
(2, 4, 3.000),
(2, 5, 0.200);

-- Carga inicial: Acordos de Fornecimento
INSERT INTO Fornecimento (id_fornecedor, id_insumo, preco_acordado) VALUES
(1, 1, 4.30),
(1, 2, 3.60),
(2, 5, 4.00),
(2, 4, 0.55);

-- Carga inicial: Vendas
INSERT INTO Venda (data_hora, valor_total, forma_pagamento, id_cliente) VALUES
('2026-10-08 07:30:00', 10.00, 'Pix', 1),
('2026-10-08 08:15:00', 25.50, 'Cartão de Crédito', 2),
('2026-10-08 09:00:00', 5.00, 'Dinheiro', NULL);

-- Carga inicial: Itens da Venda
INSERT INTO Itens_Venda (id_venda, id_produto, quantidade_vendida, preco_unitario, subtotal) VALUES
(1, 1, 20, 0.50, 10.00),
(2, 2, 1, 15.00, 15.00),
(2, 3, 1, 10.00, 10.00),
(2, 1, 1, 0.50, 0.50),
(3, 1, 10, 0.50, 5.00);

---
