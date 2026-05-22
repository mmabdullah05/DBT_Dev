with customers as (

    select * from {{ ref('stg_jaffle_shop_customers') }}

),


orders as (

    select * from {{ ref('stg_jaffle_shop_orders') }}

),

payment_orderid_customerid as (
select * from {{ ref('fct_orders') }}
),

payment_join_order as (
select * 
from orders
inner join payment_orderid_customerid 
using (customer_id,order_id)
),

customer_orders as (

    select
        customer_id,
        sum(amount) as lifetime_payments,
        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(order_id) as number_of_orders

    from payment_join_order
    -- left join payment_order_customer 
    -- on orders.customer_id = payment_order_customer.customer_id
    -- and orders.order_id = payment_order_customer.order_id
   
    group by 1

),


final as (

    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce(customer_orders.number_of_orders, 0) as number_of_orders,
        coalesce(customer_orders.lifetime_payments,0) as lifetime_value 
    from customers

    left join customer_orders using (customer_id)

)

select * from final