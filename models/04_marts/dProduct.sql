{{ config(materialized= 'table') }}

with

    product as (
        select
            productid
            , productsubcategoryid
            , product_name
            , productnumber
            , color
            , size
            , productline
            , style
            , standardcost
            , listprice
            , modifieddate
        from{{ ref('stg_product')}}
    )

    , product_subcategory as (
        select
            productsubcategoryid
            , productcategoryid
            , product_subcategory
            , modifieddate
        from{{ ref('stg_productsubcategory')}}
    )

    , product_category as (
        select
            productcategoryid
            , product_category
            , modifieddate
        from{{ ref('stg_productcategory')}}
    )

    , joined_product as (
        select 
            product.productid
            , product.productsubcategoryid
            , product_subcategory.productcategoryid
            , product.product_name
            , product.productnumber
            , product.color
            , product.style
            , product_subcategory.product_subcategory
            , product_category.product_category
        from product
        left join product_subcategory on product.productsubcategoryid = product_subcategory.productsubcategoryid
        left join product_category on product_subcategory.productcategoryid = product_category.productcategoryid
    )

    , dProduct as (
        select 
            {{ dbt_utils.generate_surrogate_key(['productid', 'productnumber']) }} as sk_product
            , *
        from joined_product     
    )

select *
from dProduct