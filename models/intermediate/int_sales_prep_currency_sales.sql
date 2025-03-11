WITH sales AS (
    SELECT 
        so.sales_order_pk,
        so.customer_fk,
        so.credit_card_fk,
        so.address_fk,
        so.sales_territory_fk,
        so.currency_rate_fk,
        so.order_date,
        so.subtotal,
        so.taxamt,
        so.freight,
        so.total_due,
        so.status,
        COALESCE(cr.average_rate, 1) AS conversion_rate,
        COALESCE(so.sales_person_fk, st.salesperson_fk) AS sales_person_fk -- Prioriza o salesperson da ordem, mas usa o da loja se necessário
    FROM {{ ref('stg_erp__salesorderheader') }} as so
    LEFT JOIN {{ ref('stg_erp__currencyrate') }} as cr 
        ON so.currency_rate_fk = cr.currency_rate_pk
    LEFT JOIN {{ ref('stg_erp__store') }} as st 
        ON so.customer_fk = st.store_pk  -- Relaciona customer com store
),
converted_sales AS (
    SELECT 
        sales_order_pk,
        customer_fk,
        sales_person_fk,
        credit_card_fk,
        address_fk,
        sales_territory_fk,
        currency_rate_fk,
        order_date,
        subtotal * conversion_rate AS converted_subtotal,
        taxamt * conversion_rate AS converted_taxamt,
        freight * conversion_rate AS converted_freight,
        total_due * conversion_rate AS converted_total_due,
        status
     
    FROM sales
)
SELECT * FROM converted_sales


