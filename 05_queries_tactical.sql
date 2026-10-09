-- 1. Demonstrativo simplificado de faturamento bruto total do negócio
SELECT SUM(valor_total) AS faturamento_bruto_acumulado 
FROM Venda;

-- 2. Análise de crescimento percentual do faturamento mês a mês para avaliação de expansão
SELECT 
    EXTRACT(YEAR FROM data_hora) AS ano, 
    EXTRACT(MONTH FROM data_hora) AS mes, 
    SUM(valor_total) AS faturamento_mensal 
FROM Venda 
GROUP BY ano, mes 
ORDER BY ano, mes;

-- 3. Curva ABC de clientes (Identificação dos 5 principais clientes responsáveis pelo maior volume de receita)
SELECT 
    c.nome, 
    SUM(v.valor_total) AS receita_gerada 
FROM Cliente c 
JOIN Venda v ON c.id_cliente = v.id_cliente 
GROUP BY c.id_cliente, c.nome 
ORDER BY receita_gerada DESC 
LIMIT 5;

-- 4. Indicador de capital imobilizado em estoque por categoria de produto
SELECT 
    tipo_produto, 
    SUM(quantidade_estoque * COALESCE(valor_compra, valor_venda * 0.5)) AS estimativa_capital_investido 
FROM Produto 
GROUP BY tipo_produto;

-- 5. Simulação de impacto financeiro de reajuste geral de preços de 10% frente à inflação
SELECT 
    SUM(valor_total) AS faturamento_historico, 
    SUM(valor_total * 1.10) AS faturamento_projetado_com_reajuste 
FROM Venda;

-- 6. Análise de custo exato de produção das receitas artesanais baseada no custo atualizado dos insumos (Formação de Preço)
SELECT 
    p.nome, 
    SUM(ri.quantidade_utilizada * i.valor_compra_atual) AS custo_producao_estimado 
FROM Receita r 
JOIN Produto p ON r.id_produto = p.id_produto 
JOIN Receita_Insumo ri ON r.id_receita = ri.id_receita 
JOIN Insumo i ON ri.id_insumo = i.id_insumo 
GROUP BY r.id_receita, p.nome;

-- 7. Análise demográfica do faturamento por faixa etária dos clientes fidelizados
SELECT 
    CASE 
        WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, c.data_nascimento)) < 25 THEN 'Jovem' 
        WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, c.data_nascimento)) BETWEEN 25 AND 45 THEN 'Adulto' 
        ELSE 'Sênior' 
    END AS faixa_etaria, 
    SUM(v.valor_total) AS receita_gerada 
FROM Cliente c 
JOIN Venda v ON c.id_cliente = v.id_cliente 
GROUP BY faixa_etaria;

-- 8. Mapeamento de dependência de fornecedores (Identificação de concentração de risco logístico)
SELECT 
    f.razao_social, 
    COUNT(fn.id_insumo) AS total_insumos_fornecidos 
FROM Fornecedor f 
JOIN Fornecimento fn ON f.id_fornecedor = fn.id_fornecedor 
GROUP BY f.id_fornecedor, f.razao_social 
ORDER BY total_insumos_fornecidos DESC;

-- 9. Cálculo do passivo financeiro acumulado em benefícios e recompensas no sistema de CRM
SELECT SUM(valor_acumulado) AS passivo_fidelidade_total 
FROM Cliente;

-- 10. Análise de sazonalidade anual do mix de produtos (Quantidade de itens vendidos por tipo e por mês)
SELECT 
    p.tipo_produto, 
    EXTRACT(MONTH FROM v.data_hora) AS mes, 
    SUM(iv.quantidade_vendida) AS volume_vendas 
FROM Itens_Venda iv 
JOIN Produto p ON iv.id_produto = p.id_produto 
JOIN Venda v ON iv.id_venda = v.id_venda 
GROUP BY p.tipo_produto, mes 
ORDER BY mes, p.tipo_produto;