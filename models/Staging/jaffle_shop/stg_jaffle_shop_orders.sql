 {{ config(
    materialized='view'
) }}

  select
        id as order_id,
        user_id as customer_id,
        order_date,
        status,
        CURRENT_TIMESTAMP as etl_loaded_at 

    from {{ source('jaffle_shop', 'orders') }}
