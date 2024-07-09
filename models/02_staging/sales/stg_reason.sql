with
    reason as(
        select
            salesreasonid
            , name as reason
            , reasontype
            , modifieddate
        from{{ source('sales','salesreason')}}
    )

select *
from reason