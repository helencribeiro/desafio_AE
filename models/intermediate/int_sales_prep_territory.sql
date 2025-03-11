with
    fonte_address as (
        select *
        from {{ ref('stg_erp__address') }}
    ),

    fonte_state_province as (
        select *
        from {{ ref('stg_erp__stateprovince') }}
    ),

    fonte_country_region as (
        select *
        from {{ ref('stg_erp__countryregion') }}
    ),

    enriquecer_address as (
        select 
            addr.address_pk,  -- CHAVE PRIMÁRIA
            addr.city,
            addr.postal_code,
            sp.state_province_pk,
            sp.state_province_name,
            cr.country_region_pk,
            cr.country_region_name
        from fonte_address addr
        left join fonte_state_province sp on addr.state_province_fk = sp.state_province_pk
        left join fonte_country_region cr on sp.country_region_fk = cr.country_region_pk
    )

select * from enriquecer_address



