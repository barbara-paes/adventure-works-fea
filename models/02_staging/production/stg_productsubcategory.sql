with
    product_subcategory as(
        select
            productsubcategoryid
            , productcategoryid
            , name as product_subcategory
            , modifieddate
        from{{ source('production','productsubcategory')}}
    )

select *
from product_subcategory