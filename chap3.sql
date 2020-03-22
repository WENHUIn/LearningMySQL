-- inner join 
SELECT order_id, o.customer_id,first_name,last_name -- customer_id in both orders and customers
FROM orders o -- alias
JOIN customers c ON o.customer_id = c.customer_id；

-- joining across databases
select *
from sql_store.order_items oi
join sql_inventory.products p
    on oi.product_id = p.product_id；
    
-- self joins|自连接 // 自我外部链接
select 
  e.employee_id,
  e.first_name,
  m.first_name as manager
from sql_hr.employees e
left join sql_hr.employees m 
    on e.reports_to = m.employee_id -- 先是from的才到join的

-- 多表连接 | multiple
use sql_invoicing;
select 
    c.name,
    p.amount,
    pm.name as method
from clients c
join payments p 
    on c.client_id = p.client_id
join payment_methods pm
    on p.payment_id = pm.payment_method_id

-- Compound Join Conditions | 复合条件连接
-- outer join//left or right
use sql_store;
select 
  p.product_id,
  p.name,
  oi.quantity
from products p
left join order_items oi 
    on p.product_id = oi.product_id
    
-- 多表外链接 // using clause
select 
  o.order_date,
  o.order_id,
  c.first_name as customer,
  s.name as shipper,
  os.name as status
from orders o 
join customers c 
    on o.customer_id = c.customer_id
    -- using (customer_id)  !! must identital keywords!!
left join shippers s
    on o.shipper_id = s.shipper_id
    -- using (shipper_id)
left join order_statuses os
    on o.status = os.order_status_id
    
-- cross join | 将多个table直接组合在一起
-- 1.implicitly
select *
from shippers,products

-- 2.explicitly
use sql_store;
select 
  s.name as shipper,
  p.name as product
from shippers s
cross join products p;

-- UNION | combine rows
use sql_store;
select 
  c.customer_id,
  c.first_name,
  c.points,
  "Bronze" as type
from customers c
where points < 2000 
union
select 
  c.customer_id,
  c.first_name,
  c.points,
  "Silver" as type
from customers c
where points between 2000 and 3000
UNION
select 
  c.customer_id,
  c.first_name,
  c.points,
  "Gold" as type
from customers c
where points >=3000
order by first_name -- order by at the end
