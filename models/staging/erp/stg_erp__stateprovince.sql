with
    fonte_state_province as (
        select *
        from {{ source('erp', 'STATEPROVINCE') }}
    )

    , renomeado as (
        select
            cast(STATEPROVINCEID as INT) as state_province_pk
            , cast(COUNTRYREGIONCODE as string) as country_region_fk
            , cast(NAME as string) as state_province_name            
        from fonte_state_province
    ) 

select *
from renomeado
