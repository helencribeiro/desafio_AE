WITH 
    metrics AS (
        SELECT *
        FROM {{ ref('int_sales_prep_metrics') }}  -- Novo modelo com granularidade correta
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
            -- PKs
            metrics.sales_order_item_pk,  -- Chave do item de venda
            metrics.sales_order_fk AS sales_order_pk,  -- Chave do pedido
            metrics.product_fk,  -- Chave do produto

            -- FKs
            metrics.customer_fk,  -- FK do cliente
            metrics.credit_card_fk,  -- FK do cartão de crédito
            metrics.sales_territory_fk,  -- FK do território de vendas
            sales_store.salesperson_fk,  -- FK do vendedor
            --order_sales_reasons.sales_reason_fk,  -- FK do motivo de venda
            -- Datas
            -- Assumindo que a data está em metrics, se necessário, adicione data específica
            metrics.order_date AS date_fk,

            -- Colunas numéricas
            metrics.order_qty,  -- Quantidade do pedido
            metrics.unit_price,  -- Preço unitário
            metrics.unit_price_discount,  -- Desconto no preço unitário
            metrics.gross_revenue,  -- Receita bruta
            metrics.total_discount,  -- Desconto total
            metrics.net_revenue,  -- Receita líquida
            metrics.freight_allocation,  -- Alocação de frete
            metrics.tax_allocation,  -- Alocação de imposto
            metrics.total_per_item,  -- Total por item (incluindo frete e imposto)
            metrics.subtotal,  -- Subtotal do pedido
            metrics.total_order_value,  -- Valor total do pedido

            -- Colunas categóricas
            sales_store.sales_reason_name,  -- Nome do motivo de venda
            sales_store.store_name,  -- Nome da loja
            -- STATUS do pedido, já incluído no modelo de métricas
            sales_store.reason_type,  -- Tipo de motivo de venda
            metrics.status  -- Status do pedido

        FROM metrics  
        LEFT JOIN special_offers 
            ON metrics.product_fk = special_offers.special_offer_pk
        LEFT JOIN order_sales_reasons 
            ON metrics.sales_order_fk = order_sales_reasons.sales_order_fk
        LEFT JOIN sales_reasons 
            ON order_sales_reasons.sales_reason_fk = sales_reasons.sales_reason_pk
        LEFT JOIN sales_store  
            ON metrics.sales_order_fk = sales_store.sales_order_pk
        LEFT JOIN sales_territories
            ON metrics.sales_territory_fk = sales_territories.sales_territory_pk  -- Junção com territórios
    )

SELECT * 
FROM joined
