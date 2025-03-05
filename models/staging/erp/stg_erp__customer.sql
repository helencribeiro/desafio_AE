with fonte_customer as (
    select *
    from {{ source('erp', 'CUSTOMER') }}
)

, renomeado as (
    select
        cast(CUSTOMERID as INT) as customer_pk
        , cast(STOREID as INT) as store_fk
        , cast(TERRITORYID as INT) as sales_territory_fk
        , cast(PERSONID as INT) as person_id

    from fonte_customer
)

select *
from renomeado
