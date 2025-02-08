
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(
    materialized='incremental',
    unique_key='customer_id',
    on_schema_change='fail',
    alias="customers_dashboard") }}

with final as (

    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce(customer_orders.number_of_orders, 0) as number_of_orders,
        current_timestamp as load_timestamp
        
    from {{ref('raw_customers')}} as customers
    left join {{ref('raw_orders')}} as customer_orders using (customer_id)

)
select * from final

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
