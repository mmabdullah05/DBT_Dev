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
order_id,customer_id,payment_amount as amount
 from fct