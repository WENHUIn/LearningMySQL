use sql_invoicing;

create table invoices_archived as
select 
  i.invoice_id,
  i.number,
  i.client_id as client,
  i.invoice_total,
  i.payment_total,
  i.invoice_date,
  i.due_date
from invoices i 
join clients c
    using (client_id)
where payment_date is not null