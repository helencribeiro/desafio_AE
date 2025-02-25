with
    fonte_person as (
        select *
        from {{ source('erp', 'PERSON') }}
    )

    , renomeado as (
        select
            cast (BUSINESSENTITYID as INT ) as person_pk
            , cast (FIRSTNAME as string) as first_name
            , cast (MIDDLENAME as string) as middle_name
            , cast (LASTNAME as string) as last_name
            from fonte_person

    ) 

    select *
    from renomeado