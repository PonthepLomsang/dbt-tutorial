{{ config(
    materialized='ephemeral',
    unique_key='customer_id',
    on_schema_change='fail',
    alias="raw_orders") }}

with orders as (
    select 1 as order_id, 2 as customer_id, to_date('20250103','yyyymmdd') as order_date, 'D' as status
    union all
    select 2 as order_id, 2 as customer_id, to_date('20250103','yyyymmdd') as order_date, 'D' as status
    union all
    select 3 as order_id, 5 as customer_id, to_date('20250603','yyyymmdd') as order_date, 'C' as status
    union all
    select 4 as order_id, 6 as customer_id, to_date('20250205','yyyymmdd') as order_date, 'P' as status
), customer_orders as (
    select
        customer_id,
        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(order_id) as number_of_orders
    from orders
    group by 1
) select * from customer_orders