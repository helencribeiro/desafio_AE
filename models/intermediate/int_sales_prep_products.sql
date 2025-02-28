with
    /* Chamada dos modelos necessários. */
    product as (
        select *
        from {{ ref('stg_erp__product') }}
    )

    , productcategory as (
        select *
        from {{ ref('stg_erp__productcategory') }}
    )

    , productsubcategory as (
        select *
        from {{ ref('stg_erp__productsubcategory') }}
    )

    , productlistpricehistory as (
        select *
        from {{ ref('stg_erp__productlistpricehistory') }}
    )

    , enriquecerproducts as (
        select
            product.product_pk
            , product.product_name
            , product.product_number
            , product.list_price
            , product.sell_start_date
            , product.sell_end_date
            , productcategory.category_name
            , productsubcategory.subcategory_name
            , productlistpricehistory.list_price as historical_list_price
        from product
        left join productcategory on product.product_subcategory_fk = productcategory.product_category_pk
        left join productsubcategory on product.product_subcategory_fk = productsubcategory.product_subcategory_pk
        left join productlistpricehistory on product.product_pk = productlistpricehistory.product_fk
    )

select *
from enriquecerproducts