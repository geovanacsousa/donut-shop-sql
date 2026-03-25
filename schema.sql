-- DONUT SHOP DATABASE - SCHEMA
-- Banco de Dados: PostgreSQL
-- Script remove tabelas existentes para recriação completa do ambiente. 


DROP TABLE IF EXISTS itens_pedido CASCADE;
DROP TABLE IF EXISTS pedidos CASCADE;
DROP TABLE IF EXISTS produtos CASCADE;
DROP TABLE IF EXISTS categorias CASCADE;
DROP TABLE IF EXISTS clientes CASCADE;

-- Clientes: armazena dados dos compradores

CREATE TABLE clientes (
    id          SERIAL PRIMARY KEY,
    nome        VARCHAR(100) NOT NULL,
    email       VARCHAR(150) NOT NULL UNIQUE,
    telefone    VARCHAR(20),
    cidade      VARCHAR(100),
    estado      CHAR(2),
    criado_em   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- Categorias: classifica os produtos do cardápio

CREATE TABLE categorias (
    id      SERIAL PRIMARY KEY,
    nome    VARCHAR(80) NOT NULL UNIQUE
);


-- Produtos: itens vendidos, com preço e controle de estoque

CREATE TABLE produtos (
    id              SERIAL PRIMARY KEY,
    nome            VARCHAR(150) NOT NULL,
    descricao       TEXT,
    preco           NUMERIC(10, 2) NOT NULL CHECK (preco >= 0),
    estoque         INTEGER NOT NULL DEFAULT 0 CHECK (estoque >= 0),
    categoria_id    INTEGER REFERENCES categorias(id) ON DELETE SET NULL,
    criado_em       TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- Pedidos: registra as compras realizadas pelos clientes

CREATE TABLE pedidos (
    id              SERIAL PRIMARY KEY,
    cliente_id      INTEGER NOT NULL REFERENCES clientes(id) ON DELETE CASCADE,
    status          VARCHAR(30) NOT NULL DEFAULT 'pendente'
                    CHECK (status IN (
                        'pendente', 
                        'pago',
                        'em preparo', 
                        'pronto',
                        'entregue', 
                        'cancelado'
                        )),
    total           NUMERIC(10, 2) NOT NULL DEFAULT 0, -- Valor total do pedido (derivado dos itens_pedido, armazenado por performance)
    criado_em       TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- Itens do pedido: associa produtos aos pedidos com quantidade e preço no momento da compra

CREATE TABLE itens_pedido (
    id          SERIAL PRIMARY KEY,
    pedido_id   INTEGER NOT NULL REFERENCES pedidos(id) ON DELETE CASCADE,
    produto_id  INTEGER NOT NULL REFERENCES produtos(id) ON DELETE RESTRICT,
    quantidade  INTEGER NOT NULL CHECK (quantidade > 0),
    preco_unit  NUMERIC(10, 2) NOT NULL CHECK (preco_unit >= 0)
);


-- ÍNDICES

CREATE INDEX idx_pedidos_cliente ON pedidos(cliente_id);
CREATE INDEX idx_itens_pedido ON itens_pedido(pedido_id);
CREATE INDEX idx_itens_produto ON itens_pedido(produto_id);
CREATE INDEX idx_produtos_categoria ON produtos(categoria_id);
