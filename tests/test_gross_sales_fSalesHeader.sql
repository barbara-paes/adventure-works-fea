-- tests/test_gross_sales_2011.sql
with 
    sales_detail_calculated as (
        select 
            salesorderid
            , orderqty * unitprice as gross_sales
        from 
            {{ ref('fSalesDetail') }}
    )

    , sales_2011 as (
        select 
            sales_detail_calculated.salesorderid
            , sales_detail_calculated.gross_sales
        from 
            sales_detail_calculated 
        join 
            {{ ref('fSalesHeader') }} salesheader
        on 
            sales_detail_calculated.salesorderid = salesheader.salesorderid
        where 
            extract(year from cast(salesheader.orderdate as datetime)) = 2011
    )

    , gross_sales_2011 as (
        select 
            round(sum(gross_sales), 2) as actual_gross_sales_2011
        from 
            sales_2011
    )

select 
    *
from 
    gross_sales_2011
where 
    actual_gross_sales_2011 != 12646112.16
