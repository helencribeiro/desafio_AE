-- Teste de validação do valores brutos de vendas de 2011 solicitado pelo Carlos para confiabilidade e veracidade dos dados 

WITH sales_2011 AS (
    SELECT 
        SUM(sd.unit_price * sd.order_qty) AS total_sales_2011
    FROM {{ ref('stg_erp__salesorderdetail') }} AS sd
    JOIN {{ ref('stg_erp__salesorderheader') }} AS soh
        ON sd.sales_order_fk = soh.sales_order_pk
    WHERE soh.order_date BETWEEN '2011-01-01' AND '2011-12-31'
)

SELECT total_sales_2011
FROM sales_2011
WHERE total_sales_2011 NOT BETWEEN 12646112.00 AND 12646113.00
