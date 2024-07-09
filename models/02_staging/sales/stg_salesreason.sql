with
    sales_reason as(
        select
            salesorderid
            , salesreasonid
            , modifieddate
        from{{ source('sales','salesorderheadersalesreason')}}
    )

select *
from sales_reason