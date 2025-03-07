-- Teste de validação do valores brutos de vendas de 2011 solicitado pelo Carlos para confiabilidade e veracidade dos dados 

WITH 
    vendas_em_2011 AS (
        SELECT SUM(gross_revenue) AS soma_total_bruto
        FROM {{ ref('int_sales_prep_metrics') }}
        WHERE order_date BETWEEN '2011-01-01' AND '2011-12-31'
    )

SELECT soma_total_bruto
FROM vendas_em_2011
WHERE soma_total_bruto NOT BETWEEN 12646112.16 - 0.01 AND 12646112.16 + 0.01

