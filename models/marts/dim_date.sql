with
    dim_date as (
        select *
        from {{ ref('int_sales_prep_date') }}
    )

select *
from dim_date