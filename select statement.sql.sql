select *
from `e1.customers`
limit 5

SELECT Name
from `e1.customers`

select city
from `e1.customers`

select method
from  `e1.payments`

select *
from `e1.employees`

select Name
from `e1.employees`

Alter `e1.employees`
rename column EmployeeID to shivam

select *
from `e1.products`

select
 ProductID,
 ProductName,
from `e1.products`


select
 ProductName,
 ProductID,
from `e1.products`


select
 ProductID,
 ProductName,
 CategoryID
from `e1.products`


select
 ProductID,
 ProductName,
 CategoryID
from `e1.products`


select
 customer_name,
from `e1.customers`


select
 selling_price
from `e1.products`


select
 city
from `e1.customers`



select distinct city
from `e1.customers`



select distinct
 Method
from `e1.payments`


select *
from `e1.suppliers`


select distinct
 state
from `e1.suppliers`


select *
from `e1.orders`


select *
from `e1.payments`


select
 Amount
from `e1.payments`



select distinct
 Amount 
from `e1.payments`


select *
from `e1.customers`


select distinct
 signupDate
from `e1.customers`


select distinct age,City
from `e1.customers`


select *
from `e1.payments`


select distinct Method,Status
from `e1.payments`
