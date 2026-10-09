-- 1. Consulta de estoque atual de um determinado produto para resposta rápida ao cliente na barraca
SELECT quantidade_estoque 
FROM Produto 
WHERE nome = 'Pão Francês';

-- 2. Listagem de todas as vendas realizadas no caixa durante o dia corrente
SELECT * 
FROM Venda 
WHERE DATE(data_hora) = CURRENT_DATE;

-- 3. Consulta de preços unitários para rápida visualização no atendimento
SELECT nome, valor_venda 
FROM Produto;

-- 4. Verificação de produtos com estoque abaixo do limite mínimo (ex: 50 unidades) para reposição imediata
SELECT nome, quantidade_estoque 
FROM Produto 
WHERE quantidade_estoque < 50;

-- 5. Emissão do comprovante detalhado de uma venda específica (itens, quantidades, valores e sub-totais)
SELECT p.nome, iv.quantidade_vendida, iv.preco_unitario, iv.subtotal 
FROM Itens_Venda iv 
JOIN Produto p ON iv.id_produto = p.id_produto 
WHERE iv.id_venda = 123;

-- 6. Consulta de fornecedores e os preços acordados para um insumo específico necessário na produção do dia
SELECT f.razao_social, fn.preco_acordado 
FROM Fornecedor f 
JOIN Fornecimento fn ON f.id_fornecedor = fn.id_fornecedor 
WHERE fn.id_insumo = 5;

-- 7. Consulta de clientes cadastrados por nome ou telefone para aplicação do programa de fidelidade (CRM)
SELECT id_cliente, nome, valor_acumulado 
FROM Cliente 
WHERE nome LIKE '%Maria%' OR telefone = '71999999999';

-- 8. Consulta da ficha técnica de uma receita para iniciar a produção imediata pela equipe da cozinha
SELECT i.nome, ri.quantidade_utilizada, i.unidade_medida 
FROM Receita_Insumo ri 
JOIN Insumo i ON ri.id_insumo = i.id_insumo 
WHERE ri.id_receita = 10;

-- 9. Verificação da quantidade de insumos disponíveis no estoque antes de iniciar uma fornada
SELECT nome, quantidade_estoque, unidade_medida 
FROM Insumo;

-- 10. Consulta de fechamento de caixa do operador ao final do expediente agrupado por forma de pagamento
SELECT forma_pagamento, SUM(valor_total) AS total_arrecadado 
FROM Venda 
WHERE DATE(data_hora) = CURRENT_DATE 
GROUP BY forma_pagamento;