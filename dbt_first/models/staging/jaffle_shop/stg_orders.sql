with orders as (

    select id as order_id,
    user_id as customer_id,
    order_date,
    status,
    order_total as amount
    from {{ source('jaffle_shop', 'orders') }}

)

select * from orders
