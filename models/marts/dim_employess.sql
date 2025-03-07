with
    dim_employee as (
        select *
        from {{ ref('int_sales_prep_employess') }}
    )

select *
from dim_employee