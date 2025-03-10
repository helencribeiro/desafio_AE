WITH 
    product AS (
        SELECT * FROM {{ ref('stg_erp__product') }}
    ),

    productsubcategory AS (
        SELECT * FROM {{ ref('stg_erp__productsubcategory') }}
    ),

    productcategory AS (
        SELECT * FROM {{ ref('stg_erp__productcategory') }}
    ),

    productlistpricehistory AS (
        SELECT * FROM {{ ref('stg_erp__productlistpricehistory') }}
    ),

    enriquecerproducts AS (
        SELECT
            p.product_pk,
            p.product_name,
            p.product_number,
            p.list_price,
            p.sell_start_date,
            p.sell_end_date,
            pc.category_name,
            ps.subcategory_name,
            plh.list_price AS historical_list_price
        FROM product p
        LEFT JOIN productsubcategory ps ON p.product_subcategory_fk = ps.product_subcategory_pk
        LEFT JOIN productcategory pc ON ps.product_category_fk = pc.product_category_pk
        LEFT JOIN productlistpricehistory plh 
            ON p.product_pk = plh.product_fk
            AND plh.modified_date = (
                SELECT MAX(modified_date) 
                FROM {{ ref('stg_erp__productlistpricehistory') }} ph
                WHERE ph.product_fk = p.product_pk
            )
    )

SELECT *
FROM enriquecerproducts

