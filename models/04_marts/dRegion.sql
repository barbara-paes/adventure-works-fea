{{ config(materialized= 'table') }}

with
    address as (
        select
            addressid
            , stateprovinceid
            , addressline
            , city 
            , modifieddate
        from{{ ref('stg_address')}}
    )

    , state_province as (
        select
            stateprovinceid 
            , territoryid 
            , stateprovincecode 
            , countryregioncode 
            , state_name
            , modifieddate
        from{{ ref('stg_stateprovince')}}
    )

    , country_region as (
        select
            countryregioncode
            , country_name
            , modifieddate
        from{{ ref('stg_countryregion')}}
    )

    , territory as (
        select
            territoryid
            , territory
            , continent
            , countryregioncode
            , salesytd
            , saleslastyear
            , costytd
            , costlastyear
            , modifieddate
        from{{ ref('stg_territory')}} 
    )

    , joined_region as (
        select
            address.addressid
            , address.stateprovinceid
            , state_province.territoryid
            , address.addressline
            , address.city
            , state_province.state_name
            , state_province.stateprovincecode
            , country_region.country_name
            , state_province.countryregioncode
            , territory.continent
        from address
        left join state_province 
            on address.stateprovinceid = state_province.stateprovinceid
        left join country_region
            on state_province.countryregioncode = country_region.countryregioncode
        left join territory
            on state_province.territoryid = territory.territoryid
    )

    , dRegion as (
        select 
            {{ dbt_utils.generate_surrogate_key(['addressid', 'addressline', 'city']) }} as sk_region
            , *
        from joined_region
    )

select *
from dRegion