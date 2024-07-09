{{ config(materialized= 'table') }}

with
    calendar as (
        {{ dbt_date.get_date_dimension("2011-01-01", "2014-12-31") }}
    )

    , dCalendar as (
        select 
            {{ dbt_utils.generate_surrogate_key(['date_day', 'day_of_week_name']) }} as sk_calendar
            , *
        from calendar
    )


select *
from dCalendar