{{ config(materialized= 'table') }}

with
    sales_reason as (
        select
            salesorderid
            , salesreasonid
            , modifieddate
        from {{ ref('stg_salesreason') }}
    )

    , reason as (
        select
            salesreasonid
            , reason
            , reasontype
            , modifieddate
        from {{ ref('stg_reason') }}
    )

    , joined_reason as (
        select
            sales_reason.salesorderid
            , string_agg(reason.reason, ', ') as reason_agg
        from sales_reason
        left join reason 
            on sales_reason.salesreasonid = reason.salesreasonid
        group by 
            sales_reason.salesorderid
    )

    , dReason as (
        select 
            {{ dbt_utils.generate_surrogate_key(['salesorderid', 'reason_agg']) }} as sk_reason
            , salesorderid
            , reason_agg
        from joined_reason
    )

select *
from dReason
