{{ config(materialized= 'table') }}

with
    
    dProduct as (
        select 
            *
        from {{ ref('dProduct')}}   
    )

    , fSalesDetail as (
        select
            salesdetail.salesorderid
            , dProduct.sk_product as fk_product
            , dProduct.productid
            , salesdetail.orderqty
            , salesdetail.unitprice
            , salesdetail.unitpricediscount
            , salesdetail.linetotal
        from {{ ref('stg_orderdetail')}} as salesdetail
        left join dProduct
            on salesdetail.productid = dProduct.productid

    ) 

select *
from fSalesDetail
