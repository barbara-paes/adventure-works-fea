with
    address as (
        select
            addressid
            , stateprovinceid
            , addressline1 as addressline
            , city 
            , modifieddate
        from{{ source('person','address')}}
    )

select *
from address