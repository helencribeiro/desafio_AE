with fonte_salesorderheadersalesreason as (
    select *
    from {{ source('erp', 'SALESORDERHEADERSALESREASON') }}
)

, renomeado as (
    select
        cast(SALESORDERID as INT) as sales_order_fk
        , cast(SALESREASONID as INT) as sales_reason_fk
    from fonte_salesorderheadersalesreason
)

select *
from renomeado
