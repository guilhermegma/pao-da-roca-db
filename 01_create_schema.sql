-- Criando o tipo ENUM
CREATE TYPE tipo_produto_enum AS ENUM ('Artesanal', 'Industrializado');

-- Tabela: Cliente
CREATE TABLE Clientes (
    id_cliente INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    cpf VARCHAR(11) NOT NULL UNIQUE,
    nome VARCHAR(150) NOT NULL,
    telefone VARCHAR(20),
    data_nascimento DATE,
    valor_acumulado DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    CONSTRAINT chk_valor_acumulado CHECK (valor_acumulado >= 0)
);

-- Tabela: Fornecedor
CREATE TABLE Fornecedores (
    id_fornecedor INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    cnpj VARCHAR(14) NOT NULL UNIQUE,
    razao_social VARCHAR(150) NOT NULL,
    endereco VARCHAR(255)
);

-- Tabela: Produto
CREATE TABLE Produtos (
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
CREATE TABLE Insumos (
    id_insumo INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    unidade_medida VARCHAR(20) NOT NULL,
    valor_compra_atual DECIMAL(10,2) NOT NULL,
    quantidade_estoque DECIMAL(10,3) NOT NULL DEFAULT 0,
    CONSTRAINT chk_estoque_insumo CHECK (quantidade_estoque >= 0)
);

-- Tabela: Receita
CREATE TABLE Receitas (
    id_receita INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    descricao_preparo TEXT,
    id_produto INT NOT NULL UNIQUE,
    CONSTRAINT fk_receita_produto FOREIGN KEY (id_produto) 
        REFERENCES Produto (id_produto) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Tabela: Venda
CREATE TABLE Vendas (
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
CREATE TABLE Fornecimentos (
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