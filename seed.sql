-- DONUT SHOP DATABASE - SEED (DADOS DE EXEMPLO)
-- Script popula o banco com dados fictícios para testes e análises.

-- CATEGORIAS

INSERT INTO categorias (nome) VALUES
    ('Clássico'),
    ('Recheado');


-- CLIENTES

INSERT INTO clientes (nome, email, telefone, cidade, estado) VALUES
    ('Ana Paula Silva',  'ana.silva@email.com',   '11 91234-5678', 'São Paulo',      'SP'),
    ('Carlos Mendes',    'carlos.mendes@email.com', '21 91111-4321', 'Rio de Janeiro', 'RJ'),
    ('Fernanda Costa',   'fer.costa@email.com',    '31 92222-1234', 'Belo Horizonte', 'MG'),
    ('Ricardo Oliveira', 'r.oliveira@email.com',   '41 91234-0000', 'Curitiba',       'PR'),
    ('Juliana Rocha',    'ju.rocha@email.com',     '51 99999-0001', 'Porto Alegre',   'RS'),
    ('Marcos Alves',     'marcos.alves@email.com', '85 93333-1000', 'Fortaleza',      'CE'),
    ('Patrícia Nunes',   'pat.nunes@email.com',    '71 94444-0987', 'Salvador',       'BA'),
    ('Thiago Ferreira',  'thiago.f@email.com',     '62 90000-9876', 'Goiânia',        'GO'),
    ('Camila Santos',    'camila.s@email.com',     '48 95555-8765', 'Florianópolis',  'SC'),
    ('Bruno Lima',       'bruno.lima@email.com',   '92 96666-7654', 'Manaus',         'AM');


-- PRODUTOS

INSERT INTO produtos (nome, descricao, preco, estoque, categoria_id) VALUES
    ('Donut Glazed',           'Cobertura de açúcar clássica',               8.90,  60, 1),
    ('Donut Chocolate',        'Cobertura de chocolate ao leite',             9.90,  55, 1),
    ('Donut Açúcar e Canela',  'Passado em açúcar com canela',                7.90,  70, 1),
    ('Donut Granulado',        'Cobertura branca com granulado colorido',     9.50,  50, 1),
    ('Donut Red Velvet',       'Massa red velvet com cobertura cream cheese', 12.90, 40, 1),
    ('Donut Creme de Avelã',   'Recheado com creme de avelã',                13.90, 45, 2),
    ('Donut Doce de Leite',    'Recheado com doce de leite cremoso',         12.90, 50, 2),
    ('Donut Morango',          'Recheado com geleia de morango',             12.50, 40, 2),
    ('Donut Nutella',          'Recheado com Nutella e cobertura de cacau',  14.90, 35, 2),
    ('Donut Brigadeiro',       'Recheado com brigadeiro e granulado',        13.50, 45, 2);


-- PEDIDOS

INSERT INTO pedidos (cliente_id, status, total, criado_em) VALUES
    (1,  'entregue',  44.60, '2024-11-05 10:22:00'),
    (1,  'entregue',  27.80, '2024-12-10 14:35:00'),
    (2,  'entregue',  69.50, '2024-11-20 09:10:00'),
    (2,  'pago',      29.70, '2025-01-08 16:45:00'),
    (3,  'entregue',  53.60, '2024-12-01 11:00:00'),
    (4,  'pronto',    41.80, '2025-01-15 13:20:00'),
    (5,  'entregue',  25.80, '2024-11-28 08:50:00'),
    (5,  'pago',      55.60, '2025-01-22 17:10:00'),
    (6,  'cancelado', 13.90, '2024-12-18 10:05:00'),
    (7,  'entregue',  67.00, '2024-12-05 12:30:00'),
    (8,  'pendente',  37.80, '2025-01-29 09:55:00'),
    (9,  'entregue',  44.50, '2024-11-15 15:40:00'),
    (10, 'pago',      26.80, '2025-01-18 11:25:00'),
    (3,  'em preparo',59.60, '2025-01-25 14:00:00');


-- ITENS DOS PEDIDOS

INSERT INTO itens_pedido (pedido_id, produto_id, quantidade, preco_unit) VALUES
    (1,  6,  2, 13.90),  -- 2x Creme de Avelã
    (1,  1,  2,  8.90),  -- 2x Glazed
    (2,  7,  1, 12.90),  -- 1x Doce de Leite
    (2,  3,  2,  7.90),  -- 2x Açúcar e Canela
    (3,  9,  3, 14.90),  -- 3x Nutella
    (3,  4,  2,  9.50),  -- 2x Granulado
    (4,  2,  2,  9.90),  -- 2x Chocolate
    (4,  10, 1, 13.50),  -- 1x Brigadeiro
    (5,  8,  2, 12.50),  -- 2x Morango
    (5,  5,  2, 12.90),  -- 2x Red Velvet 
    (6,  6,  2, 13.90),  -- 2x Creme de Avelã
    (6,  3,  2,  7.90),  -- 2x Açúcar e Canela 
    (7,  1,  2,  8.90),  -- 2x Glazed
    (7,  2,  1,  9.90),  -- 1x Chocolate
    (8,  9,  2, 14.90),  -- 2x Nutella
    (8,  7,  2, 12.90),  -- 2x Doce de Leite
    (9,  6,  1, 13.90),  -- 1x Creme de Avelã (cancelado, pedidos cancelados mantêm seus itens para fins históricos)
    (10, 10, 3, 13.50),  -- 3x Brigadeiro
    (10, 5,  2, 12.90),  -- 2x Red Velvet
    (11, 8,  2, 12.50),  -- 2x Morango
    (11, 2,  1,  9.90),  -- 1x Chocolate
    (12, 9,  2, 14.90),  -- 2x Nutella
    (12, 3,  2,  7.90),  -- 2x Açúcar e Canela 
    (13, 1,  2,  8.90),  -- 2x Glazed
    (13, 6,  1, 13.90),  -- 1x Creme de Avelã 
    (14, 7,  2, 12.90),  -- 2x Doce de Leite
    (14, 10, 2, 13.50),  -- 2x Brigadeiro
    (14, 5,  1, 12.90);  -- 1x Red Velvet
