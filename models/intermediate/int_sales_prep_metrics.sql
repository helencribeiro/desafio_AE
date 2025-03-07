WITH sales AS (
    -- Modelo já convertido para a moeda de referência
    SELECT * FROM {{ ref('int_sales_prep_currency_sales') }}
),

order_details AS (
    -- Dados detalhados de cada item do pedido
    SELECT * FROM {{ ref('stg_erp__salesorderdetail') }}
),

-- Calculando frete e imposto rateados fora da função de janela
freight_tax_rateado AS (
    SELECT 
        od.sales_order_fk,
        COUNT(*) AS total_itens,
        SUM(s.converted_freight) AS total_frete,
        SUM(s.converted_taxamt) AS total_imposto
    FROM order_details od
    INNER JOIN sales s 
        ON od.sales_order_fk = s.sales_order_pk
    GROUP BY od.sales_order_fk
),

metrics AS (
    SELECT 
        od.sales_order_item_pk,  -- Chave do item
        od.sales_order_fk,       -- FK do pedido
        s.customer_fk,
        s.credit_card_fk,
        s.sales_territory_fk,
        s.order_date,
        od.product_fk,
        od.order_qty,
        od.unit_price,
        od.unit_price_discount,

        -- Receita bruta = quantidade * preço unitário
        od.order_qty * od.unit_price AS gross_revenue,

        -- Desconto total = quantidade * desconto unitário
        od.order_qty * od.unit_price_discount AS total_discount,

        -- Receita líquida = receita bruta - desconto total
        (od.order_qty * od.unit_price) - (od.order_qty * od.unit_price_discount) AS net_revenue,
        
        -- Calculando frete e imposto rateado, utilizando valores agregados da subconsulta
        (ft.total_frete / ft.total_itens) AS freight_allocation,
        (ft.total_imposto / ft.total_itens) AS tax_allocation,

        -- Cálculo do total_item (pedido/item), incluindo receita líquida, frete e imposto rateados
        ((od.order_qty * od.unit_price) - (od.order_qty * od.unit_price_discount)) 
        + (ft.total_frete / ft.total_itens) 
        + (ft.total_imposto / ft.total_itens) 
        AS total_per_item,

        -- Subtotal do pedido (somando net_revenue dos itens)
        SUM((od.order_qty * od.unit_price) - (od.order_qty * od.unit_price_discount)) 
        OVER(PARTITION BY od.sales_order_fk) AS subtotal,

        -- Valor total do pedido (somando total_item por pedido)
        SUM(((od.order_qty * od.unit_price) - (od.order_qty * od.unit_price_discount)) 
        + (ft.total_frete / ft.total_itens) 
        + (ft.total_imposto / ft.total_itens)) 
        OVER(PARTITION BY od.sales_order_fk) AS total_order_value,
        s.status

    FROM order_details od
    INNER JOIN sales s 
        ON od.sales_order_fk = s.sales_order_pk
    INNER JOIN freight_tax_rateado ft
        ON od.sales_order_fk = ft.sales_order_fk
)

SELECT * FROM metrics
