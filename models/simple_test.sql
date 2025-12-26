-- Simple test model with inline dummy data
{{ config(materialized='view') }}

select 1 as id, 'hello' as message
union all
select 2 as id, 'world' as message
