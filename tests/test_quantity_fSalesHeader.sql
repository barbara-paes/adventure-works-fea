with
    order_quantity_validation as (
        select
            count(salesorderid) as quantity_orders
        from {{ref ('fSalesHeader')}}
        where orderdate between '2011-01-01' and '2014-12-31'

    )

select * 
from order_quantity_validation
where quantity_orders != 31465