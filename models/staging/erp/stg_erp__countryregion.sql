with
    fonte_country_region as (
        select *
        from {{ source('erp', 'COUNTRYREGION') }}
    )

    , renomeado as (
        select
            cast(COUNTRYREGIONCODE as string) as country_region_pk
            , cast(NAME as string) as country_region_name
        from fonte_country_region
    ) 

select *
from renomeado
