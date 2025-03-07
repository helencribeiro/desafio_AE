WITH 
fonte_salesorderheader AS (
    SELECT * FROM {{ ref('stg_erp__salesorderheader') }}
),
fonte_customer AS (
    SELECT * FROM {{ ref('stg_erp__customer') }}
),
fonte_salesterritory AS (
    SELECT * FROM {{ ref('stg_erp__salesterritory') }}
),
fonte_salesperson AS (
    SELECT * FROM {{ ref('stg_erp__salesperson') }}
),
fonte_store AS (
    SELECT * FROM {{ ref('stg_erp__store') }}
),
fonte_salesorderheadersalesreason AS (
    SELECT * FROM {{ ref('stg_erp__salesorderheadersalesreason') }}
),
fonte_salesreason AS (
    SELECT * FROM {{ ref('stg_erp__salesreason') }}
),

salesorder_customer AS (
    SELECT
        soh.sales_order_pk,
        soh.customer_fk,
        soh.sales_territory_fk
    FROM fonte_salesorderheader soh
),

customer_salesterritory AS (
    SELECT
        sc.sales_order_pk,
        sc.customer_fk,
        sc.sales_territory_fk,
        st.sales_territory_name
    FROM salesorder_customer sc
    JOIN fonte_customer c ON sc.customer_fk = c.customer_pk
    JOIN fonte_salesterritory st ON sc.sales_territory_fk = st.sales_territory_pk
),

salesperson_store AS (
    SELECT
        cst.sales_order_pk,
        cst.customer_fk,  
        sp.sales_person_pk AS salesperson_fk,
        s.store_pk AS store_fk,
        s.store_name
    FROM customer_salesterritory cst
    LEFT JOIN fonte_salesperson sp ON cst.sales_territory_fk = sp.sales_territory_fk
    LEFT JOIN fonte_store s ON sp.sales_person_pk = s.salesperson_fk
),

salesorder_salesreason AS (
    SELECT
        soh.sales_order_fk AS sales_order_pk,
        COALESCE(sr.sales_reason_name, 'Sem motivo informado') AS sales_reason_name,
        COALESCE(sr.sales_reason_pk, -1) AS reason_type
    FROM fonte_salesorderheadersalesreason soh
    LEFT JOIN fonte_salesreason sr ON soh.sales_reason_fk = sr.sales_reason_pk
)

SELECT 
    spst.sales_order_pk,
    spst.customer_fk,  
    spst.salesperson_fk,
    spst.store_fk,
    spst.store_name,
    sr.sales_reason_name,
    sr.reason_type
FROM salesperson_store spst
LEFT JOIN salesorder_salesreason sr ON spst.sales_order_pk = sr.sales_order_pk
