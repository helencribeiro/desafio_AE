with
    fonte_product as (
        select *
        from {{ source('erp', 'PRODUCT') }}
    )

    , renomeado as (
        select
            cast(PRODUCTID as INT) as product_pk
            , cast(NAME as STRING) as product_name
            , cast(PRODUCTNUMBER as STRING) as product_number
            , cast(LISTPRICE as DECIMAL(10,2)) as list_price
            , cast(PRODUCTSUBCATEGORYID as INT) as product_subcategory_fk
            , cast(SELLSTARTDATE as TIMESTAMP) as sell_start_date
            , cast(SELLENDDATE as TIMESTAMP) as sell_end_date
        from fonte_product
    ) 

    select *
    from renomeado
