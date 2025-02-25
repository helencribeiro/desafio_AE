with
    fonte_employee as (
        select *
        from {{ source('erp', 'EMPLOYEE') }}
    )

    , renomeado as (
        select
            cast(BUSINESSENTITYID as INT) as employee_pk
            , cast(JOBTITLE as string) as job_title
        from fonte_employee
    ) 

select *
from renomeado
