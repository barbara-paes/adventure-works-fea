with
    customer as(
        select
            customerid
            , personid
            , storeid
            , territoryid
            , modifieddate
        from{{ source('sales','customer')}}
    )

select *
from customer