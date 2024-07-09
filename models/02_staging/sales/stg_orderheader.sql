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
            , subtotal
            , taxamt
            , freight
            , totaldue
        from {{ source('sales', 'salesorderheader')}}
    )

select *
from order_header