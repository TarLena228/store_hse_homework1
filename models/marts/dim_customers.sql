{{ config(distributed_replicated=true) }}

with confirmed_orders as (

    select
        customer_id,
        order_id,
        ordered_at,
        order_amount,
        row_number() over (
            partition by customer_id
            order by ordered_at, order_id
        ) as rn
    from {{ ref('fct_orders') }}
    where is_confirmed

),

customer_purchases as (

    select
        customer_id,
        max(case when rn = 1 then order_id end) as first_confirmed_order_id,
        min(ordered_at)                         as first_confirmed_at,
        count(*)                                as confirmed_orders_count,
        sum(order_amount)                       as confirmed_revenue
    from confirmed_orders
    group by customer_id

)

select
    c.*,
    p.first_confirmed_order_id,
    p.first_confirmed_at,
    coalesce(p.confirmed_orders_count, 0) as confirmed_orders_count,
    coalesce(p.confirmed_revenue, 0)      as confirmed_revenue,
    p.customer_id is not null             as is_buyer
from {{ ref('stg_shop__customers') }} as c
left join customer_purchases as p
    on p.customer_id = c.customer_id