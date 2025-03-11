with
    customer as (
        select *
        from {{ ref('stg_erp__customer') }}
    )

    , person as (
        select *
        from {{ ref('stg_erp__person') }}
    )

    , store as (
        select *
        from {{ ref('stg_erp__store') }}
    )

    , business_entity_address as (
        select *
        from {{ ref('stg_erp__businessentityaddress') }}
    )

    , address as (
        select *
        from {{ ref('stg_erp__address') }}
    )

    , enriquecer_customer as (
        select
            customer.customer_pk,  
            concat(person.first_name, ' ', coalesce(person.middle_name, ''), ' ', person.last_name) as full_name,
            customer.sales_territory_fk,  
            store.store_name,  
            address.address_line1,   
            address.city
        from customer
        left join person on customer.customer_pk = person.person_pk
        left join store on customer.store_fk = store.store_pk
        left join business_entity_address on store.store_pk = business_entity_address.person_fk
        left join address on business_entity_address.address_fk = address.address_pk
    )

select *
from enriquecer_customer
