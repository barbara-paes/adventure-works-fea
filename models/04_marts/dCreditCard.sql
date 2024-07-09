{{ config(materialized= 'table') }}

with
    credit_card as (
        select
            creditcardid
            , cardtype 
            , modifieddate
        from {{ref('stg_creditcard')}}
    )

    , person_credit_card as (
        select
            creditcardid
            , businessentityid
            , modifieddate
        from{{ref('stg_personcreditcard')}}
    )

    , joined_credit_card as (
        select 
            credit_card.creditcardid
            , person_credit_card.businessentityid
            , COALESCE(credit_card.cardtype, 'Not informed') as cardtype
        from credit_card
        left join person_credit_card
            on credit_card.creditcardid = person_credit_card.creditcardid
    )

    , dCreditCard as (
        select 
            {{ dbt_utils.generate_surrogate_key(['creditcardid', 'cardtype']) }} as sk_creditcard
            , *
        from joined_credit_card
    )

select *
from dCreditCard