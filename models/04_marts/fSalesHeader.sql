{{ config(materialized= 'table') }}

with

    dRegion as (
        select 
            *
        from {{ ref('dRegion')}}
    )

    , dCustomer as (
        select 
            *
        from {{ ref('dCustomer')}}
    )

    , dCreditCard as (
        select 
            *
        from {{ ref('dCreditCard')}}
    )

    , dCalendar as (
        select 
            *
        from {{ ref('dCalendar')}}
    )

    , final_reason as (
        select 
            *
        from {{ ref('int_reason')}}
    ) 

 -- Joining salesorderheader with the dimensions of customer, region, credit card, reason and calendar.   

    , fSalesHeader as (
        select
            salesheader.salesorderid
            , dRegion.sk_region as fk_region
            , dCreditCard.sk_creditcard as fk_creditcard
            , dCustomer.sk_customer as fk_customer
            , dCalendar.sk_calendar as fk_calendar
            , ifnull(final_reason.reason_agg, 'Not informed') as reason_agg
            , salesheader.orderdate
            , salesheader.duedate
            , salesheader.shipdate
            , case
                when salesheader.status = 1 then 'In process'
                when salesheader.status = 2 then 'Approved'
                when salesheader.status = 3 then 'Backordered'
                when salesheader.status = 4 then 'Rejected'
                when salesheader.status = 5 then 'Shipped'
                when salesheader.status = 6 then 'Cancelled'
            end as order_status
            , case
                when salesheader.onlineorderflag = true then 'Online'
                when salesheader.onlineorderflag = false then 'Physical'
            end as sales_channel
            , salesheader.subtotal
            , salesheader.taxamt
            , salesheader.freight
            , salesheader.totaldue
        from {{ ref('stg_orderheader')}} as salesheader
        left join dRegion
            on salesheader.billtoaddressid = dRegion.addressid
        left join dCreditCard
            on salesheader.creditcardid = dCreditCard.creditcardid
        left join dCustomer
            on salesheader.customerid = dCustomer.customerid
        left join dCalendar
            on salesheader.orderdate = dCalendar.date_day
        left join final_reason
            on salesheader.salesorderid = final_reason.salesorderid      
    )

select * 
from fSalesHeader
