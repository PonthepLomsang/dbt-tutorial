{{ config(
    materialized='ephemeral',
    unique_key='customer_id',
    on_schema_change='fail',
    alias="raw_customers") }}

with customers as (
    select 1 as customer_id, 'first_name1' as first_name, 'last_name1' as last_name 
    union all
    select 2 as customer_id, 'first_name2' as first_name, 'last_name2' as last_name 
    union all
    select 3 as customer_id, 'first_name3' as first_name, 'last_name3' as last_name
    union all
    select 4 as customer_id, 'first_name4' as first_name, 'last_name4' as last_name
    union all
    select 5 as customer_id, 'first_name5' as first_name, 'last_name5' as last_name
    union all
    select 6 as customer_id, 'first_name6' as first_name, 'last_name6' as last_name
    union all
    select 7 as customer_id, 'first_name7' as first_name, 'last_name7' as last_name 
) select * from customers