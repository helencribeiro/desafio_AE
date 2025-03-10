with
    /* Chamada dos modelos necessários. */
    employees as (
        select *
        from {{ ref('stg_erp__employee') }}
    )

    , departments as (
        select *
        from {{ ref('stg_erp__department') }}
    )

    , employee_department_history as (
        select *
        from {{ ref('stg_erp__employeedepartmenthistory') }}
        WHERE end_date IS NULL
    )

    , enriquecer_employees as (
        select
            employees.employee_pk
            , employees.job_title
            , departments.department_name
            , employee_department_history.start_date
            , employee_department_history.end_date
        from employees
        left join employee_department_history on employees.employee_pk = employee_department_history.employee_fk
        left join departments on employee_department_history.department_fk = departments.department_pk
    )

select *
from enriquecer_employees

