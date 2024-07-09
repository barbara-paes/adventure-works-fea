with
    country_region as (
        select
            countryregioncode
            , name as country_name
            , modifieddate
        from{{ source('person','countryregion')}}
    )

select *
from country_region