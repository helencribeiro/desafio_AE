with fonte_salesreason as (
    select *
    from {{ source('erp', 'SALESREASON') }}
)

, renomeado as (
    select
        cast(SALESREASONID as INT) as sales_reason_pk
        , cast(NAME as STRING) as sales_reason_name
    from fonte_salesreason
)

select *
from renomeado