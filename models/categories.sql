with categories as (
    select distinct
        category_code as id,
        upper(category_code_description) as description
    from opa
)

select * from categories
