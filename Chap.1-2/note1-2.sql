select *
from customers
-- AND (higher precedence) or 
-- where state = 'VA' or state = 'GA' or state = 'FL' (only in this form, 
--                                                     not state = 'VA' or 'GA' or 'FL')
-- where state IN ('VA','FL','GA')
-- where  birth_date BETWEEN '1990-01-01' and '2000-01-01'
-- where last_name like '%b%' (no matter b in where , top,middle,buttom)
-- where last_name like '_____y' (xxxxxy)
-- % any number of characters
-- _ single character
-- regexp ‘e[fmq]’ ef em eq
-- regexp '[iep]w' iw ew pw
-- regexp '[a-h]e' ae be ... he 
-- where phone is NULLcustomers
-- order by state desc,first_name 
-- limit 6,3 (at the end)