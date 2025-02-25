with
    fonte_business_entity_address as (
        select *
        from {{ source('erp', 'BUSINESSENTITYADDRESS') }}
    )

    , renomeado as (
        select
            cast(BUSINESSENTITYID as INT) as person_fk
            , cast(ADDRESSID as INT) as address_fk
            , cast(ADDRESSTYPEID as INT) as address_type_fk
        from fonte_business_entity_address
    ) 

select *
from renomeado
