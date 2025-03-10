with fonte_business_entity_address as (
    select *
    from {{ source('erp', 'BUSINESSENTITYADDRESS') }}
)

, adicionar_rank as (
    select
        cast(BUSINESSENTITYID as INT) as person_fk,
        cast(ADDRESSID as INT) as address_fk,
        cast(ADDRESSTYPEID as INT) as address_type_fk,
        row_number() over (partition by BUSINESSENTITYID order by ADDRESSID) as rn
    from fonte_business_entity_address
)

, filtrar_apenas_um_endereco as (
    select *
    from adicionar_rank
    where rn = 1 -- Mantém apenas um endereço por cliente
)

select *
from filtrar_apenas_um_endereco

