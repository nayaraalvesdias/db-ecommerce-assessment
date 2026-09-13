-- store sales overview by status
-- With "with" clause I created an overview of the revenue per store.
-- Then I used this overview to count the number of orders per status 
-- and the second query sum the total revenue per status.
-- These kind of queries are useful to build dashboard like bar graphs.
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
    count(*) filter (where status = 'CANCELED') as canceled
from store_revenue
group by store_id;


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
    COALESCE(sum(total) filter ( where status = 'PLACED'), 0.0) as incoming,
    COALESCE(sum(total) filter ( where status = 'COMPLETED'), 0.0) as received,
    COALESCE(sum(total) filter ( where status = 'CANCELED'), 0.0) as to_refund
from store_revenue
group by store_id;


-- Select using group by and having clause to count the number of orders per status for a specific customer 

select customer_id, status, count(status) as quantity from orders
left join order_items on order_id = orders.id
where customer_id = '74d8d5d5-44a0-4a6a-a736-271c6c7f45dd'
group by customer_id, status having  count(status) > 1


-- transporsion of rows to columns 
SELECT
    (SELECT count(*) FROM customer_card WHERE type = 'CREDIT') AS credit_quantity,
    (SELECT count(*) FROM customer_card WHERE type = 'DEBIT') AS debit_quantity


-- Using set operators
select customer_id from orders where status = 'PLACED'
except
-- except, intersect and union
select customer_id from orders  where status = 'CANCELED'