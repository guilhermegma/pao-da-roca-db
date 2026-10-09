-- 1. Ranking dos 10 produtos mais vendidos no último mês por faturamento
SELECT 
    p.nome, 
    SUM(iv.quantidade_vendida) AS qtd_total, 
    SUM(iv.subtotal) AS faturamento 
FROM Itens_Venda iv 
JOIN Produto p ON iv.id_produto = p.id_produto 
JOIN Venda v ON iv.id_venda = v.id_venda 
WHERE v.data_hora >= DATE_TRUNC('month', CURRENT_DATE - INTERVAL '1 month')
  AND v.data_hora <  DATE_TRUNC('month', CURRENT_DATE)
GROUP BY p.id_produto, p.nome 
ORDER BY faturamento DESC 
LIMIT 10;

-- 2. Análise de margem bruta média por categoria de produto (Artesanal vs. Industrializado)
SELECT 
    tipo_produto, 
    AVG(valor_venda - COALESCE(valor_compra, 0)) AS margem_media 
FROM Produto 
GROUP BY tipo_produto;

-- 3. Identificação dos dias da semana e horários de maior fluxo de vendas para redimensionamento de atendimento
SELECT 
    TO_CHAR(data_hora, 'Day') AS dia_semana, 
    EXTRACT(HOUR FROM data_hora) AS hora, 
    COUNT(*) AS volume_vendas 
FROM Venda 
GROUP BY dia_semana, hora 
ORDER BY volume_vendas DESC;

-- 4. Avaliação da variação de preços de insumos em relação ao valor acordado com fornecedores
SELECT 
    f.razao_social, 
    i.nome, 
    i.valor_compra_atual, 
    fn.preco_acordado, 
    (i.valor_compra_atual - fn.preco_acordado) AS diferenca_preco 
FROM Fornecimento fn 
JOIN Fornecedor f ON fn.id_fornecedor = f.id_fornecedor 
JOIN Insumo i ON fn.id_insumo = i.id_insumo;

-- 5. Relatório de insumos com estoque crítico que possuem receitas dependentes cadastradas
SELECT DISTINCT 
    i.nome, 
    i.quantidade_estoque 
FROM Insumo i 
JOIN Receita_Insumo ri ON i.id_insumo = ri.id_insumo 
WHERE i.quantidade_estoque < 10;

-- 6. Análise do ticket médio de compras por cliente cadastrado
SELECT 
    c.nome, 
    AVG(v.valor_total) AS ticket_medio 
FROM Venda v 
JOIN Cliente c ON v.id_cliente = c.id_cliente 
GROUP BY c.id_cliente, c.nome;

-- 7. Identificação de produtos parados (sem giro de vendas) nos últimos 60 dias
SELECT 
    p.nome, 
    p.quantidade_estoque 
FROM Produto p 
WHERE p.id_produto NOT IN (
    SELECT iv.id_produto 
    FROM Itens_Venda iv 
    JOIN Venda v ON iv.id_venda = v.id_venda 
    WHERE v.data_hora >= CURRENT_DATE - INTERVAL '60 days'
);

-- 8. Comparativo do volume de vendas baseado nas diferentes formas de pagamento
SELECT 
    forma_pagamento, 
    COUNT(*) AS qtd_vendas, 
    SUM(valor_total) AS receita_total 
FROM Venda 
GROUP BY forma_pagamento;

-- 9. Análise do retorno do programa de fidelidade comparando faturamento de clientes identificados vs. anônimos
SELECT 
    CASE 
        WHEN id_cliente IS NULL THEN 'Anônimo' 
        ELSE 'Fidelizado' 
    END AS tipo_cliente, 
    SUM(valor_total) AS faturamento_total 
FROM Venda 
GROUP BY tipo_cliente;

-- 10. Análise da frequência de retorno dos clientes cadastrados no sistema
SELECT 
    c.nome, 
    COUNT(v.id_venda) AS total_visitas 
FROM Cliente c 
JOIN Venda v ON c.id_cliente = v.id_cliente 
GROUP BY c.id_cliente, c.nome 
ORDER BY total_visitas DESC;