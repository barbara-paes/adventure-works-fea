with
    person_credit_card as(
        select
            creditcardid
            , businessentityid
            , modifieddate
        from{{ source('sales','personcreditcard')}}
    )

select *
from person_credit_card