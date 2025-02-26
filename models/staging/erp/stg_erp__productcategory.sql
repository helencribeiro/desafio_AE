with
    fonte_productcategory as (
        select *
        from {{ source('erp', 'PRODUCTCATEGORY') }}
    )

    , renomeado as (
        select
            cast(PRODUCTCATEGORYID as INT) as product_category_pk
            , cast(NAME as STRING) as category_name
        from fonte_productcategory
    ) 

    select *
    from renomeado
