with salesreason as (
    select *
    from {{ ref('stg_erp__salesreason') }}
)

select *
from salesreason
