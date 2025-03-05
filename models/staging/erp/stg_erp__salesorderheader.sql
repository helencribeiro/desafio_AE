with fonte_salesorderheader as (
    select *
    from {{ source('erp', 'SALESORDERHEADER') }}
)

, renomeado as (
    select
        cast(SALESORDERID as INT) as sales_order_pk
        , cast(CUSTOMERID as INT) as customer_fk
        , cast(CREDITCARDID as INT) as credit_card_fk
        , cast(TERRITORYID as INT) as sales_territory_fk
        , cast(CURRENCYRATEID as INT) as currency_rate_fk
        , cast(ORDERDATE as DATE) as order_date
        , cast(SUBTOTAL as NUMERIC(18,4)) as subtotal
        , cast(TAXAMT as NUMERIC(18,4)) as taxamt
        , cast(FREIGHT as NUMERIC(18,4)) as freight
        , cast(TOTALDUE as NUMERIC(18,4)) as total_due
        , cast(STATUS as INT) as status


        
    from fonte_salesorderheader
)

select *
from renomeado




