{{ config(distributed_replicated=true) }}

with days as (

    select generate_series(
        '2026-03-01'::timestamp,
        '2026-07-11'::timestamp,
        '1 day'::interval
    )::date as date_day
)

select
    date_day,
    extract(year from date_day)::int as year,
    extract(quarter from date_day)::int as quarter,
    extract(month from date_day)::int as month,
    extract(day from date_day)::int as day_of_month,
    extract(isodow from date_day)::int as day_of_week,
    extract(isodow from date_day) in (6, 7) as is_weekend
from days