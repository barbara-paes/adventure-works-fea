with
    product as(
        select
            productid
            , productsubcategoryid
            , name as product_name
            , productnumber
            , color
            , size
            , productline
            , style
            , standardcost
            , listprice
            , modifieddate
        from{{ source('production','product')}}
    )

select *
from product