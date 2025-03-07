with
    fct_sales as (
        select *
        from {{ ref('int_prep_fact_sales') }}
    )

select *
from fct_sales