with
    credit_card as(
        select
            creditcardid
            , cardtype 
            , modifieddate
        from{{ source('sales','creditcard')}}
    )

select *
from credit_card