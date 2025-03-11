with
    dim_salesreason as (
        select *
        from {{ ref('int_sales_prep_salesreason') }}
    )

select *
from dim_salesreason