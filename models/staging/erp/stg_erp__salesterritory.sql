with fonte_salesterritory as (
    select *
    from {{ source('erp', 'SALESTERRITORY') }}
)

, renomeado as (
    select
        cast(TERRITORYID as INT) as sales_territory_pk
        , cast(NAME as STRING) as sales_territory_name
        , cast(COUNTRYREGIONCODE as STRING) as country_region_code
    from fonte_salesterritory
)

select *
from renomeado
