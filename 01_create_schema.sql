-- 1. Criação das Entidades Fortes (Catálogo e Cadastros)
CREATE TABLE Fornecedores (
    id_fornecedor SERIAL PRIMARY KEY,
    cnpj VARCHAR(18) UNIQUE NOT NULL,
    razao_social VARCHAR(150) NOT NULL,
    endereco VARCHAR(200)
);

CREATE TABLE Insumos (
    id_insumo SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    unidade_medida VARCHAR(20) NOT NULL
);

CREATE TABLE Produtos (
    id_produto SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    tipo_produto VARCHAR(50) NOT NULL,
    valor_venda DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Clientes (
    id_cliente SERIAL PRIMARY KEY,
    cpf VARCHAR(14) UNIQUE,
    nome VARCHAR(100) NOT NULL,
    numero_contato VARCHAR(20),
    data_nascimento DATE,
    valor_acumulado DECIMAL(10, 2) DEFAULT 0.00
);

-- 2. Criação das Entidades de Estoque Físico e Validade
CREATE TABLE Lote_Insumo (
    id_lote_insumo SERIAL PRIMARY KEY,
    id_insumo INT REFERENCES Insumos(id_insumo),
    data_compra DATE NOT NULL,
    data_fabricacao DATE,
    data_validade DATE NOT NULL,
    quantidade_atual DECIMAL(10, 3) NOT NULL,
    valor_compra DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Lote_Produto (
    id_lote_produto SERIAL PRIMARY KEY,
    id_produto INT REFERENCES Produtos(id_produto),
    data_fabricacao DATE,
    data_validade DATE NOT NULL,
    quantidade_atual DECIMAL(10, 3) NOT NULL
);

-- 3. Criação das Tabelas Associativas e de Receituário
CREATE TABLE Fornecimento (
    id_fornecedor INT REFERENCES Fornecedores(id_fornecedor),
    id_insumo INT REFERENCES Insumos(id_insumo),
    preco_acordado DECIMAL(10, 2),
    PRIMARY KEY (id_fornecedor, id_insumo)
);

CREATE TABLE Receitas (
    id_receita SERIAL PRIMARY KEY,
    id_produto INT NOT NULL REFERENCES Produtos(id_produto),
    descricao_preparo TEXT
);

CREATE TABLE Receita_Insumo (
    id_receita INT REFERENCES Receitas(id_receita),
    id_insumo INT REFERENCES Insumos(id_insumo),
    quantidade_utilizada DECIMAL(10, 3) NOT NULL,
    PRIMARY KEY (id_receita, id_insumo)
);

-- 4. Criação das Tabelas de Vendas (PDV)
CREATE TABLE Vendas (
    id_venda SERIAL PRIMARY KEY,
    id_cliente INT REFERENCES Clientes(id_cliente), -- FK Opcional (permite NULL)
    data_hora TIMESTAMP NOT NULL,
    valor_total DECIMAL(10, 2) NOT NULL,
    forma_pagamento VARCHAR(50) NOT NULL
);

CREATE TABLE Produto_Venda (
    id_venda INT REFERENCES Vendas(id_venda),
    id_produto INT REFERENCES Produtos(id_produto),
    quantidade_vendida DECIMAL(10, 3) NOT NULL,
    preco_unitario DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (id_venda, id_produto)
);