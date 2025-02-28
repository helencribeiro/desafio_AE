with
    /* Chamada dos modelos necessários. */
    stateprovince as (
        select *
        from {{ ref('stg_erp__stateprovince') }}
    )

    , countryregion as (
        select *
        from {{ ref('stg_erp__countryregion') }}
    )

    , salesterritory as (
        select *
        from {{ ref('stg_erp__salesterritory') }}
    )

    , enriquecer_territory as (
        select
            stateprovince.state_province_pk
            , stateprovince.state_province_name
            , stateprovince.territory_fk
            , countryregion.country_region_pk
            , countryregion.country_region_name
            , salesterritory.sales_territory_pk
            , salesterritory.sales_territory_name
        from stateprovince
        left join countryregion on stateprovince.country_region_fk = countryregion.country_region_pk
        left join salesterritory on stateprovince.territory_fk = salesterritory.sales_territory_pk
    )

select *
from enriquecer_territory

