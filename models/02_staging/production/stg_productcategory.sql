with
    product_category as(
        select
            productcategoryid
            , name as product_category
            , modifieddate
        from{{ source('production','productcategory')}}
    )

select *
from product_category