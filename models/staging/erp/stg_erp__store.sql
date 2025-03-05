with fonte_store as (
    select *
    from {{ source('erp', 'STORE') }}
)

, renomeado as (
    select
        cast(BUSINESSENTITYID as INT) as store_pk
        , cast(NAME as STRING) as store_name
        , cast(SALESPERSONID as INT) as salesperson_fk
    from fonte_store
)

select *
from renomeado


