WITH 
    currency_sales AS (
        SELECT *
        FROM {{ ref('int_sales_prep_currency_sales') }}
    ),

    order_details AS (
        SELECT *
        FROM {{ ref('stg_erp__salesorderdetail') }}
    ),

    credit_cards AS (
        SELECT *
        FROM {{ ref('stg_erp__creditcard') }}
    ),

    sales_territories AS (
        SELECT *
        FROM {{ ref('stg_erp__salesterritory') }}
    ),

    special_offers AS (
        SELECT *
        FROM {{ ref('stg_erp__specialoffer') }}
    ),

    sales_reasons AS (
        SELECT *
        FROM {{ ref('stg_erp__salesreason') }}
    ),

    salespeople AS (
        SELECT *
        FROM {{ ref('stg_erp__salesperson') }}
    ),

    order_sales_reasons AS (
        SELECT *
        FROM {{ ref('stg_erp__salesorderheadersalesreason') }}
    ),

    sales_store AS (
        SELECT *
        FROM {{ ref('int_sales_prep_store') }}
    ),

    joined AS (
        SELECT 
            order_details.sales_order_fk AS sales_order_pk,
            currency_sales.customer_fk,
            currency_sales.credit_card_fk,
            currency_sales.sales_territory_fk,
            currency_sales.currency_rate_fk,
            currency_sales.order_date AS date_fk,
            currency_sales.converted_subtotal AS subtotal,
            currency_sales.converted_total_due AS total_due,
            currency_sales.status,
            order_details.product_fk,
            order_details.special_offer_fk,
            order_details.order_qty,
            order_details.unit_price,
            order_details.unit_price_discount,
            order_details.order_qty * order_details.unit_price_discount AS total_discount,
            order_details.order_qty * order_details.unit_price AS gross_revenue,
            currency_sales.converted_total_due AS net_revenue,
            special_offers.special_offer_description,
            order_sales_reasons.sales_reason_fk, -- Garantindo que vem da tabela correta
            sales_store.store_fk,  
            sales_store.salesperson_fk,  
            sales_store.sales_reason_name,  -- Garantindo que vem da tabela correta
            sales_store.reason_type  -- Garantindo que vem da tabela correta
        FROM order_details
        INNER JOIN currency_sales 
            ON order_details.sales_order_fk = currency_sales.sales_order_pk
        LEFT JOIN special_offers 
            ON order_details.special_offer_fk = special_offers.special_offer_pk
        LEFT JOIN order_sales_reasons 
            ON currency_sales.sales_order_pk = order_sales_reasons.sales_order_fk
        LEFT JOIN sales_reasons 
            ON order_sales_reasons.sales_reason_fk = sales_reasons.sales_reason_pk
        LEFT JOIN sales_store  
            ON currency_sales.sales_order_pk = sales_store.sales_order_pk
    )

SELECT * 
FROM joined