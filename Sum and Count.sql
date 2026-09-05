--How many different cities do the customers belong to?
select count( distinct city)
from `e1.customers`


--How many different products do we have?
select count(distinct ProductID)
from `e1.products`

select count(*)
from `e1.products`


--How many customers are from Mumbai?
select count(CustomerID)
from `e1.customers`
where city = "Mumbai"


--Count the number of different customers that we have/ calculate the number of rows
select count(*)
from `e1.customers`


--count(column) counts the number of non-null values in the column
select count(CustomerID)
from `e1.customers`


--How many different supplier states exist?
select count (distinct State)
from `e1.suppliers`


--What is the total value presented by all order-item records?
select 
sum(Total)
from `e1.order_items`


--How many individual product unit were sold across all order-item records?
select sum(Quantity)
from `e1.order_items`


--Total quantity sold where order items have a quantity greater than 1.
select 
sum(Quantity)
from `e1.order_items`
where Quantity >1






