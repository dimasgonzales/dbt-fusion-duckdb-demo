-- tests/assert_positive_ids.sql
-- Singular test: Ensure all order IDs are positive

select
    order_id
from {{ ref('stg_orders') }}
where order_id <= 0
