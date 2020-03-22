-- insert a row
insert into customers (
    first_name,
    last_name,
    address,
    city,
    state)
values (
    "John",
    "Smith",
    "33 wilbur",
    "storrs",
    "CT");

-- insert multiple rows
insert into shippers (name)
value ("shipper1"),("shipper2"),("shipper3");

-- insert hierachical rows | 同时在母表和子表插入行
insert into orders (customer_id,order_date,status)
values (1,'2020-3-21',1);

insert into order_items
values 
    (LAST_INSERT_ID(), 1,1,2.95),
    (LAST_INSERT_ID(), 2,1,5.95);
-- copy tables
create table orders_archived AS
select * from orders;

-- update table 单个
-- update invoices
-- set payment_total = 100/default/公式, payment_date = '2020-3-21'/due_date/NULL
-- where invoice_id = 1

-- update table 多个 preferences-->SQL editor--> turn off safe update
update invoices
set payment_total = 100, payment_date = '2020-3-21'
where client_id = 3 

-- 重启之后需要 点击表格才能使用 或者 double-clicking its name

-- 删除行
delete from invoices
where invoice_id = 1

-- restore databases
