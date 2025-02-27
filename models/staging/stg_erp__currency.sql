with fonte_currency as (
    select *
    from {{ source('erp', 'CURRENCY') }}
)

, renomeado as (
    select
        cast(CURRENCYCODE as STRING) as currency_code_pk
        , cast(NAME as STRING) as currency_name
        , cast(MODIFIEDDATE as TIMESTAMP) as modified_date
    from fonte_currency
)

select *
from renomeado;