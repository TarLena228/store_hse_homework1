{{ config(severity='warn') }}

select
    o.order_id,
    o.order_amount,
    i.sum_line_amount,
    o.order_amount - i.sum_line_amount as diff
from {{ ref('fct_orders') }} as o
left join (
    select order_id, sum(line_amount) as sum_line_amount
    from {{ ref('fct_order_items') }}
    group by order_id
) as i on i.order_id = o.order_id
where abs(coalesce(o.order_amount - i.sum_line_amount, 0)) > 0.01
