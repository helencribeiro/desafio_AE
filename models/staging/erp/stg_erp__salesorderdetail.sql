with fonte_salesorderdetail as (
    select *
    from {{ source('erp', 'SALESORDERDETAIL') }}
)

, renomeado as (
    select
        cast(SALESORDERID as INT) as sales_order_fk
        , cast(PRODUCTID as INT) as product_fk
        , cast(ORDERQTY as INT) as order_qty
        , cast(UNITPRICE as NUMERIC) as unit_price
        , cast(UNITPRICEDISCOUNT as NUMERIC) as unit_price_discount
    from fonte_salesorderdetail
)

select *
from renomeado
