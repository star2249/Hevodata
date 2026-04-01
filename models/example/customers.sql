{{ config(
    materialized='table'
) }}

with customer_data as (
    select
        ID as customer_id,
        FIRST_NAME as first_name,
        LAST_NAME as last_name
    from SALES_RAW_CUSTOMERS
),

order_data as (
    select
        USER_ID as customer_id,
        min(ORDER_DATE) as first_order,
        max(ORDER_DATE) as most_recent_order,
        count(*) as number_of_orders
    from SALES_RAW_ORDERS
    group by USER_ID
),

payment_data as (
    select
        o.USER_ID as customer_id,
        sum(p.AMOUNT) as customer_lifetime_value
    from SALES_RAW_PAYMENTS p
    join SALES_RAW_ORDERS o
      on p.ORDER_ID = o.ID
    group by o.USER_ID
)

select
    cd.customer_id,
    cd.first_name,
    cd.last_name,
    od.first_order,
    od.most_recent_order,
    od.number_of_orders,
    pd.customer_lifetime_value
from customer_data cd
left join order_data od
    on cd.customer_id = od.customer_id
left join payment_data pd
    on cd.customer_id = pd.customer_id
