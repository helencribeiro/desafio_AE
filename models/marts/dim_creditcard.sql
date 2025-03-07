with
    dim_creditcard as (
        select *
        from {{ ref('int_sales_creditcard') }}
    )

select *
from dim_creditcard