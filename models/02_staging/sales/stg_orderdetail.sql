with
    order_detail as (
        select
            salesorderid
            , productid
            , orderqty
            , ROUND(unitprice, 2) as unitprice
            , ROUND(unitpricediscount, 2) as unitpricediscount
            , ROUND(COALESCE((unitprice * (1.0 - COALESCE(unitpricediscount, 0.0)) * orderqty), 0.0), 2) as linetotal
            , modifieddate
        from {{ source('sales','salesorderdetail')}}
    )

select *
from order_detail