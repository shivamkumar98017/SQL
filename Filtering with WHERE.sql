select *
from `e1.customers`
limit 5

select distinct CustomerID  --customerID id already unique
from `e1.customers`


--Where clause
SELECT column1,column2,...
FROM table_name
WHERE condition


--give me information of the customer with id C014
select *
from `e1.customers`
where CustomerID = "C014"


select
 CustomerID,
 Name,
 Gender
from `e1.customers`
where CustomerID = "C014"


--The customer support team wants a list of all customers with their city.
select
 CustomerID,
 City,
from `e1.customers`


--show all categories availabe.
select distinct
 CategoryID
 from `e1.products`


--Display Customer from Nagpur
select 
 CustomerID,
 City,
 from `e1.customers`
 where city = "Nagpur"


--Display all the female Customer
select 
 Gender,
 CustomerID,
 Age,
 City,
 Name,
 SignupDate
 from `e1.customers`
 where  gender = "F"

 select *
 from `e1.customers`
 where gender = "F"


-- find the customers who have spent more than 1,00,000 -->this will need join concept
select *
from `e1.payments`


select *
from `e1.payments`
where Amount > 100000


--Display the customer Older than 30
select *
from `e1.customers`
where Age > 30


--Display the products Costing at most 50,000
select *
from `e1.products`
where SellingPrice <= 50000


--Display Delivered Orders
select *
from `e1.orders`
where status = "Delivered"


--Display Orders that are not Delivered
select *
from `e1.orders`
where Status != "Delivered"


--Count Total Customers
select count(*)
from `e1.customers`


--Count Customers from Mumbai
select count(*)
from `e1.customers`
where City = "Mumbai"


--The HR Manager wants to see the names of employees working in the Operations department.
select *
from `e1.employees`
where Department = "Operations"


--Display all products supplied by supplier ID 3.
select *
from `e1.products`
where SupplierID = "SUP003"


--The Inventory team wants to see the products having stock less than 30 units.
select *
from `e1.inventory`
where Stock < 30

select
 ProductID
from `e1.inventory`
where stock < 30


--Find all customers who signed up after 2023-01-01.
select *
from `e1.customers`
where SignupDate > "2023-01-01"


--Count all customers who signed up after 2023-01-01.
select count(*)
from `e1.customers`
where SignupDate > "2023-01-01"


--Count how many different product categories exist in the products table.
select distinct
 CategoryID
from `e1.products`

select count( distinct CategoryID)
from `e1.products`









