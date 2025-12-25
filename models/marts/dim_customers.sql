-- models/marts/dim_customers.sql
-- Customer dimension with aggregated order metrics

select
    customer_id,
    count(*) as total_orders,
    sum(case when status = 'completed' then 1 else 0 end) as completed_orders,
    sum(case when status = 'pending' then 1 else 0 end) as pending_orders,
    sum(amount) as total_amount,
    min(order_date) as first_order_date,
    max(order_date) as last_order_date
from {{ ref('stg_orders') }}
group by customer_id
