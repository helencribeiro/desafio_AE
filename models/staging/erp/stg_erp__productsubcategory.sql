with
    fonte_productsubcategory as (
        select *
        from {{ source('erp', 'PRODUCTSUBCATEGORY') }}
    )

    , renomeado as (
        select
            cast(PRODUCTSUBCATEGORYID as INT) as product_subcategory_pk
            , cast(PRODUCTCATEGORYID as INT) as product_category_fk
            , cast(NAME as STRING) as subcategory_name
        from fonte_productsubcategory
    ) 

    select *
    from renomeado
