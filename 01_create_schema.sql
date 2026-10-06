-- 1. Criação da tabela Fornecedores
CREATE TABLE Fornecedores (
    id_fornecedor SERIAL PRIMARY KEY,
    cnpj VARCHAR(18) UNIQUE NOT NULL,
    razao_social VARCHAR(150) NOT NULL,
    endereco VARCHAR(200)
);

-- 2. Criação da tabela Insumos
CREATE TABLE Insumos (
    id_insumo SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    unidade_medida VARCHAR(20) NOT NULL,
    valor_compra_atual DECIMAL(10, 2),
    quantidade_estoque DECIMAL(10, 3) NOT NULL
);

-- 3. Criação da tabela Associativa Fornecimento
CREATE TABLE Fornecimento (
    id_fornecedor INT REFERENCES Fornecedores(id_fornecedor),
    id_insumo INT REFERENCES Insumos(id_insumo),
    preco_acordado DECIMAL(10, 2),
    PRIMARY KEY (id_fornecedor, id_insumo)
);

-- 4. Criação da tabela Clientes
CREATE TABLE Clientes (
    id_cliente SERIAL PRIMARY KEY,
    cpf VARCHAR(14) UNIQUE,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(20),
    data_nascimento DATE,
    valor_acumulado DECIMAL(10, 2) DEFAULT 0.00
);

-- 5. Criação da tabela Produtos
CREATE TABLE Produtos (
    id_produto SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    tipo_produto VARCHAR(50) NOT NULL,
    valor_compra DECIMAL(10, 2),
    valor_venda DECIMAL(10, 2) NOT NULL,
    quantidade_estoque DECIMAL(10, 3) NOT NULL
);

-- 6. Criação da tabela Receitas
CREATE TABLE Receitas (
    id_receita SERIAL PRIMARY KEY,
    id_produto INT NOT NULL REFERENCES Produtos(id_produto),
    descricao_preparo TEXT
);

-- 7. Criação da tabela Associativa ReceitasInsumo
CREATE TABLE ReceitasInsumo (
    id_receita INT REFERENCES Receitas(id_receita),
    id_insumo INT REFERENCES Insumos(id_insumo),
    quantidade_utilizada DECIMAL(10, 3) NOT NULL,
    PRIMARY KEY (id_receita, id_insumo)
);

-- 8. Criação da tabela Vendas
CREATE TABLE Vendas (
    id_venda SERIAL PRIMARY KEY,
    id_cliente INT REFERENCES Clientes(id_cliente),
    data_hora TIMESTAMP NOT NULL,
    valor_total DECIMAL(10, 2) NOT NULL,
    forma_pagamento VARCHAR(50) NOT NULL
);

-- 9. Criação da tabela Associativa Itens_venda
CREATE TABLE Itens_venda (
    id_venda INT REFERENCES Vendas(id_venda),
    id_produto INT REFERENCES Produtos(id_produto),
    quantidade_vendida DECIMAL(10, 3) NOT NULL,
    preco_unitario DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (id_venda, id_produto)
);