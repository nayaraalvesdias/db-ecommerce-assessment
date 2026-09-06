-- store sales overview by status
-- With "with" clause I created an overview of the revenue per store.
-- Then I used this overview to count the number of orders per status and sum the total revenue per status.
-- This kind of query is useful to build dashboard like bar graphs.
with store_revenue as (select
    products.store_id,
    orders.total,
    orders.status
from customers
left join orders on orders.customer_id = customers.id
left join order_items on orders.id = order_items.order_id
left join products on products.id = order_items.product_id
left join stores on store_id = stores.id)
select
    store_id,
    count(*) filter (where status = 'PLACED') as placed,
    count(*) filter (where status = 'COMPLETED') as completed,
    count(*) filter (where status = 'CANCELED') as canceled,
    COALESCE(sum(total) filter ( where status = 'PLACED'), 0.0) as incoming,
    COALESCE(sum(total) filter ( where status = 'COMPLETED'), 0.0) as received,
    COALESCE(sum(total) filter ( where status = 'CANCELED'), 0.0) as to_refund
from store_revenue
group by store_id;

