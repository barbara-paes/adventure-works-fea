with
    territory as (
        select
            territoryid
            , name as territory
            , t.group continent 
            , countryregioncode
            , salesytd
            , saleslastyear
            , costytd
            , costlastyear
            , modifieddate
        from{{ source('sales','salesterritory')}} t
    )

select *
from territory