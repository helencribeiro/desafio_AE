with
    dim_territory as (
        select *
        from {{ ref('int_sales_prep_territory') }}
    )

select *
from dim_territory