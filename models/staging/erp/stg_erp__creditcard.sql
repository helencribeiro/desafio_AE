with fonte_creditcard as (
    select *
    from {{ source('erp', 'CREDITCARD') }}
)

, renomeado as (
    select
        cast(CREDITCARDID as INT) as credit_card_pk
        , cast(CARDTYPE as STRING) as card_type
    from fonte_creditcard
)

select *
from renomeado
