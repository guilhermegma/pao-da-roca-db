-- Reset do schema para recriação limpa das tabelas
DROP SCHEMA IF EXISTS public CASCADE;
CREATE SCHEMA public;

-- Criando o tipo ENUM
CREATE TYPE tipo_produto_enum AS ENUM ('Artesanal', 'Industrializado');

-- Tabela: Cliente
CREATE TABLE Cliente (
    id_cliente INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    cpf VARCHAR(11) NOT NULL UNIQUE,
    nome VARCHAR(150) NOT NULL,
    telefone VARCHAR(20),
    data_nascimento DATE,
    valor_acumulado DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    CONSTRAINT chk_valor_acumulado CHECK (valor_acumulado >= 0)
);

-- Tabela: Fornecedor
CREATE TABLE Fornecedor (
    id_fornecedor INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    cnpj VARCHAR(14) NOT NULL UNIQUE,
    razao_social VARCHAR(150) NOT NULL,
    endereco VARCHAR(255)
);

-- Tabela: Produto
CREATE TABLE Produto (
    id_produto INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    tipo_produto tipo_produto_enum NOT NULL,
    valor_compra DECIMAL(10,2),
    valor_venda DECIMAL(10,2) NOT NULL,
    quantidade_estoque INT NOT NULL DEFAULT 0,
    CONSTRAINT chk_estoque_produto CHECK (quantidade_estoque >= 0),
    CONSTRAINT chk_valor_venda CHECK (valor_venda >= 0)
);

-- Tabela: Insumo
CREATE TABLE Insumo (
    id_insumo INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    unidade_medida VARCHAR(20) NOT NULL,
    valor_compra_atual DECIMAL(10,2) NOT NULL,
    quantidade_estoque DECIMAL(10,3) NOT NULL DEFAULT 0,
    CONSTRAINT chk_estoque_insumo CHECK (quantidade_estoque >= 0)
);

-- Tabela: Lote_Insumo
CREATE TABLE Lote_Insumo (
    id_lote_insumo INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_insumo INT NOT NULL,
    data_compra DATE NOT NULL,
    data_fabricacao DATE,
    data_validade DATE,
    quantidade_atual DECIMAL(10,3) NOT NULL,
    valor_compra DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_loteinsumo_insumo FOREIGN KEY (id_insumo)
        REFERENCES Insumo (id_insumo)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT chk_qtd_lote_insumo CHECK (quantidade_atual >= 0),
    CONSTRAINT chk_valor_compra_lote CHECK (valor_compra >= 0)
);

-- Tabela: Lote_Produto
CREATE TABLE Lote_Produto (
    id_lote_produto INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_produto INT NOT NULL,
    data_fabricacao DATE,
    data_validade DATE,
    quantidade_atual INT NOT NULL,
    CONSTRAINT fk_loteproduto_produto FOREIGN KEY (id_produto)
        REFERENCES Produto (id_produto)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT chk_qtd_lote_produto CHECK (quantidade_atual >= 0)
);

-- Tabela: Receita
CREATE TABLE Receita (
    id_receita INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    descricao_preparo TEXT,
    id_produto INT NOT NULL UNIQUE,
    CONSTRAINT fk_receita_produto FOREIGN KEY (id_produto) 
        REFERENCES Produto (id_produto) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Tabela: Receita_Insumo
CREATE TABLE Receita_Insumo (
    id_receita INT NOT NULL,
    id_insumo INT NOT NULL,
    quantidade_utilizada DECIMAL(10,3) NOT NULL,
    PRIMARY KEY (id_receita, id_insumo),
    CONSTRAINT fk_receitainsumo_receita FOREIGN KEY (id_receita) 
        REFERENCES Receita (id_receita) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_receitainsumo_insumo FOREIGN KEY (id_insumo) 
        REFERENCES Insumo (id_insumo) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT chk_qtd_utilizada CHECK (quantidade_utilizada > 0)
);

-- Tabela: Fornecimento
CREATE TABLE Fornecimento (
    id_fornecedor INT NOT NULL,
    id_insumo INT NOT NULL,
    preco_acordado DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id_fornecedor, id_insumo),
    CONSTRAINT fk_fornecimento_fornecedor FOREIGN KEY (id_fornecedor) 
        REFERENCES Fornecedor (id_fornecedor) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_fornecimento_insumo FOREIGN KEY (id_insumo) 
        REFERENCES Insumo (id_insumo) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT chk_preco_acordado CHECK (preco_acordado >= 0)
);

-- Tabela: Venda
CREATE TABLE Venda (
    id_venda INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    data_hora TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    valor_total DECIMAL(10,2) NOT NULL,
    forma_pagamento VARCHAR(30) NOT NULL,
    id_cliente INT NULL,
    CONSTRAINT fk_venda_cliente FOREIGN KEY (id_cliente) 
        REFERENCES Cliente (id_cliente) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT chk_valor_total CHECK (valor_total >= 0)
);

-- Tabela: Itens_Venda
CREATE TABLE Itens_Venda (
    id_venda INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade_vendida INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id_venda, id_produto),
    CONSTRAINT fk_itensvenda_venda FOREIGN KEY (id_venda) 
        REFERENCES Venda (id_venda) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_itensvenda_produto FOREIGN KEY (id_produto) 
        REFERENCES Produto (id_produto) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT chk_qtd_vendida CHECK (quantidade_vendida > 0)
);

CREATE OR REPLACE VIEW Produto_Venda AS 
SELECT id_venda, id_produto, quantidade_vendida, preco_unitario, subtotal 
FROM Itens_Venda;