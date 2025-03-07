with
    dim_custumers as (
        select *
        from {{ ref('int_sales_prep_custumers') }}
    )

select *
from dim_custumers