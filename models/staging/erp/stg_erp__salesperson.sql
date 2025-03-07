with fonte_salesperson as (
    select *
    from {{ source('erp', 'SALESPERSON') }}
)

, renomeado as (
    select
        cast(BUSINESSENTITYID as INT) as sales_person_pk
        , cast(TERRITORYID as INT) as sales_territory_fk
        , cast(SALESQUOTA as INT) as sales_quota
        , cast(BONUS as FLOAT) as bonus
        , cast(COMMISSIONPCT as FLOAT) as commission_pct
        , cast(SALESYTD as NUMERIC) as sales_ytd
        , cast(SALESLASTYEAR as NUMERIC) as sales_last_year
    from fonte_salesperson
)

select *
from renomeado
-- VER OS TESTE PQ TEM MUITOS NULL NESSA TABELA