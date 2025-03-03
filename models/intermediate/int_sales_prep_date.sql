with unique_dates as ( 
    select distinct order_date as date_pk
    from {{ ref('stg_erp__salesorderheader') }} 
)

, int_prep_time as ( 
    select
        date_pk,
        DATE_PART('year', date_pk) as year,
        DATE_PART('month', date_pk) as month,
        DATE_PART('day', date_pk) as day,
        DATE_PART('quarter', date_pk) as quarter,
        DATE_PART('week', date_pk) as year_week,
        TO_CHAR(date_pk, 'Month') as month_name, 
        DATE_PART('dayofweek', date_pk) as weekday, 
        TO_CHAR(date_pk, 'YYYY-MM') as year_month 
    from unique_dates
)

select *
from int_prep_time


