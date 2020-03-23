-- functions sum()
use sql_invoicing;
SELECT 
  "First half of 2019" as date_range,
  sum(invoice_total) as total_sales,
  sum(payment_total) as total_payments,
  sum(invoice_total- payment_total) as what_we_expect
FROM invoices
where invoice_date between '2019-01-01' and '2019-06-30'
UNION
SELECT 
  "Second half of 2019" as date_range,
  sum(invoice_total) as total_sales,
  sum(payment_total) as total_payments,
  sum(invoice_total- payment_total) as what_we_expect
FROM invoices
where invoice_date between '2019-07-01' and '2019-12-31'
UNION
SELECT 
  "Total" as date_range,
  sum(invoice_total) as total_sales,
  sum(payment_total) as total_payments,
  sum(invoice_total- payment_total) as what_we_expect
FROM invoices
where invoice_date between '2019-01-01' and '2019-12-31';

-- functions group by
SELECT
  date,
  sum(amount) as total_payment,
  name as payment_method
from payments p
join payment_methods pm
  on p.payment_method = pm.payment_method_id
group by date,payment_method
order by date;

-- having after rows are grouped
use sql_store;
select 
  c.customer_id,
  c.first_name,
  c.last_name,
  sum(oi.quantity*oi.unit_price) as total_sales
from customers c
join orders using (customer_id)
join order_items oi using (order_id)
where state = "VA"
group by 
  c.customer_id,
  c.first_name,
  c.last_name
having total_sales > 100;

-- rollup apply to aggragate functions
use sql_invoicing;
select 
  pm.name as payment,
  sum(amount) as total_payment
from payments p
join payment_methods pm
  on p.payment_id = pm.payment_method_id
group by payment with rollup;

-- find clients withou invoices
use sql_invoicing;
select *
from clients
where client_id not in (
    select distinct client_id
    from invoices);

-- find customers who have order lettuce
use sql_store;
select c.customer_id, c.first_name,c.last_name
from customers 
where customer_id in (
             select o.customer_id
             from orders o
             join order_items using (order_id)
             where product_id = 3);

select distinct c.customer_id, c.first_name,c.last_name
from customers c
left join orders using(customer_id)
left join order_items oi using(order_id)
where oi.product_id = 3；

-- select invoices larger than all invoices of client3
select *
from invoices
where invoice_total > ALL (
             select invoice_total
             from invoices
             where client_id =3);

-- = ANY equals IN	

-- correlated subquery
select *
from invoices 
where invoice_total > (
       select avg(invoice_total)
       from invoices i
       where i.client_id  = client_id);
       
-- exist
-- find products that have never been ordered
use sql_store;
select *
from products p 
where not exists (
      select product_id
      from order_items
      where product_id = p.product_id;
