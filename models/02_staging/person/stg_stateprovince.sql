with
    state_province as (
        select
            stateprovinceid 
            , territoryid 
            , stateprovincecode 
            , countryregioncode 
            , name as state_name
            , modifieddate
        from{{ source('person','stateprovince')}}
    )

select *
from state_province