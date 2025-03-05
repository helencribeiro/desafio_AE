WITH fonte_salesorderheader AS (
    SELECT *
    FROM {{ source('erp', 'SALESORDERHEADER') }}
),

-- Conectando SALESORDERHEADER → CUSTOMER → SALESTERRITORY
salesorder_customer AS (
    SELECT
        soh.SALESORDERID AS sales_order_pk,
        soh.CUSTOMERID AS customer_fk,
        soh.TERRITORYID AS sales_territory_fk
    FROM fonte_salesorderheader soh
),

customer_salesterritory AS (
    SELECT
        sc.sales_order_pk,
        sc.customer_fk,
        sc.sales_territory_fk,
        st.NAME AS sales_territory_name
    FROM salesorder_customer sc
    JOIN {{ source('erp', 'CUSTOMER') }} c ON sc.customer_fk = c.CUSTOMERID
    JOIN {{ source('erp', 'SALESTERRITORY') }} st ON sc.sales_territory_fk = st.TERRITORYID
),

-- Conectando SALESTERRITORY → SALESPERSON → STORE
fonte_salesperson AS (
    SELECT *
    FROM {{ source('erp', 'SALESPERSON') }}
),

salesperson_store AS (
    SELECT
        cst.sales_order_pk,
        cst.customer_fk,  
        sp.BUSINESSENTITYID AS salesperson_fk,
        s.BUSINESSENTITYID AS store_fk,
        s.NAME AS store_name
    FROM customer_salesterritory as cst
    LEFT JOIN fonte_salesperson sp ON cst.sales_territory_fk = sp.TERRITORYID
    LEFT JOIN {{ source('erp', 'STORE') }} s ON sp.BUSINESSENTITYID = s.SALESPERSONID
),

-- Conectando SALESORDERHEADER → SALESREASON
fonte_salesorderheadersalesreason AS (
    SELECT *
    FROM {{ source('erp', 'SALESORDERHEADERSALESREASON') }}
),

fonte_salesreason AS (
    SELECT *
    FROM {{ source('erp', 'SALESREASON') }}
),

salesorder_salesreason AS (
    SELECT
        soh.SALESORDERID AS sales_order_pk,
        COALESCE(sr.NAME, 'Sem motivo informado') AS sales_reason_name,
        COALESCE(sr.REASONTYPE, 'Desconhecido') AS reason_type
    FROM fonte_salesorderheadersalesreason as soh
    LEFT JOIN fonte_salesreason sr ON soh.SALESREASONID = sr.SALESREASONID
)

-- Modelo intermediário final
SELECT 
    spst.sales_order_pk,
    spst.customer_fk,  
    spst.salesperson_fk,
    spst.store_fk,
    spst.store_name,
    sr.sales_reason_name,
    sr.reason_type
FROM salesperson_store as spst
LEFT JOIN salesorder_salesreason sr ON spst.sales_order_pk = sr.sales_order_pk