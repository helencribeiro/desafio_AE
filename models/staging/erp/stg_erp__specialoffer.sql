with fonte_specialoffer as (
    select *
    from {{ source('erp', 'SPECIALOFFER') }}
)

, renomeado as (
    select
        cast(SPECIALOFFERID as INT) as special_offer_pk
        , cast(DESCRIPTION as STRING) as special_offer_description
        , cast(DISCOUNTPCT as FLOAT) as discount_pct
    from fonte_specialoffer
)

select *
from renomeado
