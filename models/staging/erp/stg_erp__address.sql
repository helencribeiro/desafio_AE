with
    fonte_address as (
        select *
        from {{ source('erp', 'ADDRESS') }}
    )

    , renomeado as (
        select
            cast(ADDRESSID as INT) as address_pk
            , cast(STATEPROVINCEID as INT) as state_province_fk
            , cast(POSTALCODE as string) as postal_code
            , cast(ADDRESSLINE1 as string) as address_line1
            , cast(CITY as string) as city
                        
        from fonte_address
    ) 

select *
from renomeado
