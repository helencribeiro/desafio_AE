WITH sales_order_headers_sales_reason AS (
    SELECT * FROM {{ ref('stg_erp__salesorderheadersalesreason') }}
),

sales_reason AS (
    SELECT * FROM {{ ref('stg_erp__salesreason') }}
)

SELECT 
    sohsr.sales_order_fk,
    sohsr.sales_reason_fk,
    sr.sales_reason_name
FROM sales_order_headers_sales_reason sohsr
LEFT JOIN sales_reason sr 
    ON sohsr.sales_reason_fk = sr.sales_reason_pk

