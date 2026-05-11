with customers as (

    select * from {{ ref('stg_jaffle_shop_customers') }}

),

orders as (

    select * from {{ ref('stg_jaffle_shop_orders') }}

),

payments as (
   select * from {{ ref('stg_stripe__payments') }}
),

 fct as (
select *
    from customers

    left join orders using (customer_id)

    left join payments using (order_id)
)

select 
customer_id,order_id,payment_amount
 from fct