with
    fonte_department as (
        select *
        from {{ source('erp', 'DEPARTMENT') }}
    )

    , renomeado as (
        select
            cast(DEPARTMENTID as INT) as department_pk
            , cast(NAME as string) as department_name
        from fonte_department
    ) 

select *
from renomeado
