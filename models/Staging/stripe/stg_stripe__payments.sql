  
  select 
  id as payment_id,
  orderid as order_id,
  paymentmethod as payment_method,
  amount / 100  as payment_amount,
  created as purchase_date
 from {{ source('stripe', 'payments') }}
  where status = 'success'