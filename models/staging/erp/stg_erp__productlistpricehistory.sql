with
    fonte_productlistpricehistory as (
        select *
        from {{ source('erp', 'PRODUCTLISTPRICEHISTORY') }}
    )

    , renomeado as (
        select
            cast(PRODUCTID as INT) as product_fk
            , cast(STARTDATE as TIMESTAMP) as start_date
            , cast(ENDDATE as TIMESTAMP) as end_date
            , cast(LISTPRICE as DECIMAL(10,2)) as list_price
        from fonte_productlistpricehistory
    ) 

    select *
    from renomeado
