with fonte_specialofferproduct as (
    select *
    from {{ source('erp', 'SPECIALOFFERPRODUCT') }}
)

, renomeado as (
    select
        cast(SPECIALOFFERID as INT) as special_offer_fk
        , cast(PRODUCTID as INT) as product_fk
    from fonte_specialofferproduct
)

select *
from renomeado;