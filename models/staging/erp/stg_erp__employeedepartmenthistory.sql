with
    fonte_employee_department_history as (
        select *
        from {{ source('erp', 'EMPLOYEEDEPARTMENTHISTORY') }}
    )

    , renomeado as (
        select
            cast(BUSINESSENTITYID as INT) as employee_fk
            , cast(DEPARTMENTID as INT) as department_fk
            , cast(STARTDATE as DATE) as start_date
            , cast(ENDDATE as DATE) as end_date
        from fonte_employee_department_history
    ) 

select *
from renomeado
