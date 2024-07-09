with
    person as(
        select
            businessentityid
            , persontype
            , firstname
            , middlename
            , lastname
            , IFNULL(CONCAT(firstname, ' '), '') || IFNULL(CONCAT(middlename, ' '), '') || lastname as fullname
            , modifieddate
        from{{ source('person','person')}}
    )

select *
from person