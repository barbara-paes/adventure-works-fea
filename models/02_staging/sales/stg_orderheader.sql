with 
    order_header as (
        select
            salesorderid
            , customerid
            , salespersonid
            , territoryid
            , billtoaddressid
            , shiptoaddressid
            , creditcardid
            , DATE(orderdate) as orderdate
            , DATE(duedate) as duedate
            , DATE(shipdate) as shipdate
            , modifieddate
            , status 
            , onlineorderflag 
            , ROUND(subtotal, 2) as subtotal
            , ROUND(taxamt, 2) as taxamt
            , ROUND(freight, 2) as freight
            , ROUND(totaldue, 2) as totaldue
        from {{ source('sales', 'salesorderheader')}}
    )

select *
from order_header