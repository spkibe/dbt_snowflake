--dimcustomers.sql

--create it as a table not view
{{ config(materialized='table') }}

with customers as (

    select * from {{ ref('stg_customers') }}
),

orders as (

    select * from {{ ref('stg_orders') }}
),

customer_orders as(
    select customer_id,
    min(order_date) as first_orderdate,
    max(order_date) as latest_orderdate,
    count(order_id) as num_of_orders,
    sum(amount) as lifetime_value
from orders
group by 1
),
final as (
select c.customer_id,
c.first_name,
c.last_name,
co.first_orderdate,
co.latest_orderdate,
co.num_of_orders,
co.lifetime_value

from customers c
left join customer_orders co using(customer_id) 
)
select * from final
