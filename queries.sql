-- DONUT SHOP DATABASE - QUERIES ANALÍTICAS
-- Banco de Dados: PostgreSQL


-- 1. TOTAL DE PEDIDOS E RECEITA POR STATUS
-- Visão geral do fluxo de pedidos
-- Inclui pedidos cancelados para análise do impacto na receita

SELECT status,
    COUNT(*)    AS total_pedidos,
    SUM(total)  AS receita_total,
    ROUND(AVG(total), 2)  AS ticket_medio
FROM pedidos
GROUP BY status
ORDER BY receita_total DESC;


-- 2. CLIENTES QUE MAIS COMPRARAM (TOP 10)
--    Identifica os clientes mais fiéis

SELECT c.nome AS cliente,
    c.cidade,
    c.estado,
    COUNT(p.id)    AS total_pedidos,
    SUM(p.total)   AS gasto_total
FROM clientes c
JOIN pedidos p ON p.cliente_id = c.id
WHERE p.status <> 'cancelado'
GROUP BY c.id, c.nome, c.cidade, c.estado
ORDER BY gasto_total DESC
LIMIT 10;


-- 3. DONUTS MAIS VENDIDOS (POR QUANTIDADE)

SELECT pr.nome  AS donut,
    cat.nome    AS categoria,
    SUM(ip.quantidade)   AS unidades_vendidas,
    SUM(ip.quantidade * ip.preco_unit)  AS receita_gerada
FROM itens_pedido ip
JOIN produtos pr  ON pr.id  = ip.produto_id
JOIN categorias cat ON cat.id = pr.categoria_id
JOIN pedidos ped  ON ped.id = ip.pedido_id
WHERE ped.status <> 'cancelado'
GROUP BY pr.id, pr.nome, cat.nome
ORDER BY unidades_vendidas DESC;


-- 4. RECEITA POR CATEGORIA
-- Clássico vs Recheado — qual vende mais?

SELECT cat.nome  AS categoria,
    COUNT(DISTINCT ip.pedido_id)  AS pedidos_com_categoria,
    SUM(ip.quantidade)  AS donuts_vendidos,
    SUM(ip.quantidade * ip.preco_unit)  AS receita_total
FROM itens_pedido ip
JOIN produtos pr    ON pr.id  = ip.produto_id
JOIN categorias cat ON cat.id = pr.categoria_id
JOIN pedidos ped    ON ped.id = ip.pedido_id
WHERE ped.status <> 'cancelado'
GROUP BY cat.id, cat.nome
ORDER BY receita_total DESC;


-- 5. HISTÓRICO COMPLETO DE UM CLIENTE
--  Substitua o ID conforme necessário

SELECT ped.id  AS pedido_id,
    ped.criado_em::DATE  AS data_pedido,
    ped.status,
    pr.nome AS donut,
    ip.quantidade,
    ip.preco_unit,
    (ip.quantidade * ip.preco_unit) AS subtotal
FROM pedidos ped
JOIN itens_pedido ip ON ip.pedido_id = ped.id
JOIN produtos pr     ON pr.id = ip.produto_id
WHERE ped.cliente_id = 1
ORDER BY ped.criado_em DESC;


-- 6. PEDIDOS COM MAIS DE 1 SABOR
-- Clientes que pediram variedade

SELECT ped.id  AS pedido_id,
    c.nome     AS cliente,
    COUNT(DISTINCT ip.produto_id) AS sabores_diferentes,
    SUM(ip.quantidade) AS total_donuts,
    SUM(ip.quantidade * ip.preco_unit)  AS valor_total
FROM pedidos ped
JOIN clientes c      ON c.id   = ped.cliente_id
JOIN itens_pedido ip ON ip.pedido_id = ped.id
GROUP BY ped.id, c.nome
HAVING COUNT(DISTINCT ip.produto_id) > 1
ORDER BY sabores_diferentes DESC;


-- 7. DONUTS COM ESTOQUE BAIXO (< 40 unidades)

SELECT pr.nome AS donut,
    cat.nome   AS categoria,
    pr.estoque AS estoque_atual,
    pr.preco
FROM produtos pr
JOIN categorias cat ON cat.id = pr.categoria_id
WHERE pr.estoque < 40
ORDER BY pr.estoque ASC;


-- 8. RECEITA MENSAL (últimos 6 meses)

SELECT TO_CHAR(DATE_TRUNC('month', criado_em), 'MM/YYYY')  AS mes,
    COUNT(id)   AS total_pedidos,
    SUM(total) AS receita_mensal
FROM pedidos
WHERE status NOT IN ('cancelado', 'pendente')
  AND criado_em >= CURRENT_DATE - INTERVAL '6 months'
GROUP BY DATE_TRUNC('month', criado_em)
ORDER BY DATE_TRUNC('month', criado_em);


-- 9. CLIENTES SEM NENHUM PEDIDO
--    Identifica clientes inativos

SELECT  c.id, c.nome, c.email, c.cidade
FROM clientes c
LEFT JOIN pedidos p ON p.cliente_id = c.id
WHERE p.id IS NULL;



-- 10. VIEW: RESUMO DE PEDIDOS POR CLIENTE

CREATE OR REPLACE VIEW vw_resumo_clientes AS
SELECT c.id AS cliente_id,
    c.nome,
    c.email,
    c.cidade,
    c.estado,
    COUNT(p.id) AS total_pedidos,
    COALESCE(SUM(p.total), 0) AS gasto_total,
    MAX(p.criado_em)   AS ultimo_pedido
FROM clientes c
LEFT JOIN pedidos p ON p.cliente_id = c.id AND p.status <> 'cancelado'
GROUP BY c.id, c.nome, c.email, c.cidade, c.estado;

-- Consultando a view:
-- SELECT * FROM vw_resumo_clientes ORDER BY gasto_total DESC;
