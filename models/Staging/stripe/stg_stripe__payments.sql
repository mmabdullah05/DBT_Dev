  
  select 
  id as payment_id,
  orderid as order_id,
  paymentmethod as payment_method,
  amount as payment_amount,
  created as purchase_date
 from raw.stripe.payments
  where status = 'success'