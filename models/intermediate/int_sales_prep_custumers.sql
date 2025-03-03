with
    /* Chamada dos modelos necessários. */
    person as (
        select *
        from {{ ref('stg_erp__person') }}
    )

    , address as (
        select *
        from {{ ref('stg_erp__address') }}
    )

    , state_province as (
        select *
        from {{ ref('stg_erp__stateprovince') }}
    )

    , country_region as (
        select *
        from {{ ref('stg_erp__countryregion') }}
    )

    , business_entity_address as (
        select *
        from {{ ref('stg_erp__businessentityaddress') }}
    )

    , enriquecer_customer as (
        select
            person.person_pk
            , concat(person.first_name, ' ', person.middle_name, ' ', person.last_name) as full_name  
            , address.address_line1
            , address.city
            , address.state_province_fk
            , address.postal_code
            , state_province.state_province_name
            , country_region.country_region_name
        from person
        left join business_entity_address on person.person_pk = business_entity_address.person_fk
        left join address on business_entity_address.address_fk = address.address_pk
        left join state_province on address.state_province_fk = state_province.state_province_pk
        left join country_region on state_province.country_region_fk = country_region.country_region_pk
    )

select *
from enriquecer_customer