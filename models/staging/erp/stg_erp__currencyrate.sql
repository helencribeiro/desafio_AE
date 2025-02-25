with fonte_currencyrate as (
    select *
    from {{ source('erp', 'CURRENCYRATE') }}
)

, renomeado as (
    select
        cast(CURRENCYRATEID as INT) as currency_rate_pk
        , cast(CURRENCYRATEDATE as DATE) as currency_rate_date
        , cast(FROMCURRENCYCODE as STRING) as from_currency_code
        , cast(TOCURRENCYCODE as STRING) as to_currency_code
        , cast(AVERAGERATE as FLOAT) as average_rate
        , cast(ENDOFDAYRATE as FLOAT) as end_of_day_rate
    from fonte_currencyrate
)

select *
from renomeado
