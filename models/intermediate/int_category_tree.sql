with recursive categories as (

    select
        category_id,
        parent_category_id,
        category_name::text as category_name
    from {{ ref('stg_shop__product_categories') }}

),

tree as (

    select
        category_id,
        category_name,
        category_name as root_category_name
    from categories
    where parent_category_id is null

    union all

    select
        c.category_id,
        c.category_name,
        t.root_category_name
    from categories as c
    join tree as t
        on c.parent_category_id = t.category_id

)

select
    t.category_id,
    t.category_name,
    p.category_name as parent_category_name,
    t.root_category_name
from tree as t
left join categories as c
    on c.category_id = t.category_id
left join categories as p
    on p.category_id = c.parent_category_id