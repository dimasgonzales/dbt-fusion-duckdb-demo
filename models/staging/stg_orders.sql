-- models/staging/stg_orders.sql
-- Staging model that cleans and types raw order data

select
    order_id,
    customer_id,
    status,
    cast(amount as decimal(10, 2)) as amount,
    cast(order_date as date) as order_date,
    current_timestamp as loaded_at
from {{ ref('raw_orders') }}
