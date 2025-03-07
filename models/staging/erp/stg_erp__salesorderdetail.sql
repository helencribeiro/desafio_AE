WITH fonte_salesorderdetail AS (
    SELECT *
    FROM {{ source('erp', 'SALESORDERDETAIL') }}
)

, renomeado AS (
    SELECT
        -- Criando a chave primária composta
        CAST(SALESORDERID AS VARCHAR) || '-' || CAST(PRODUCTID AS VARCHAR) AS sales_order_item_pk,
        -- Chaves estrangeiras
        CAST(SALESORDERID AS INT) AS sales_order_fk,
        CAST(PRODUCTID AS INT) AS product_fk,
        CAST(SPECIALOFFERID AS INT) AS special_offer_fk,

        -- Outras colunas relevantes
        CAST(ORDERQTY AS INT) AS order_qty,
        CAST(UNITPRICE AS NUMERIC(18,4)) AS unit_price,
        CAST(UNITPRICEDISCOUNT AS NUMERIC(18,4)) AS unit_price_discount

    FROM fonte_salesorderdetail
)

SELECT *
FROM renomeado

