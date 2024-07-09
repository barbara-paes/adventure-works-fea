with
    order_detail as (
        select
            salesorderid
            , productid
            , orderqty
            , unitprice
            , unitpricediscount
            , COALESCE(unitprice * (1.0 - COALESCE(unitpricediscount, 0.0)) * orderqty, 0.0) as linetotal
            , modifieddate
        from {{ source('sales','salesorderdetail')}}
    )

select *
from order_detail