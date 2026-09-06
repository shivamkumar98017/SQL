--order by

select...
from table...
order by column(s)


default oder--> ascending

--Suppose we want products from the lowest selling price too the heighest.
select 
 ProductID,
 SellingPrice
from `e1.products`
order by SellingPrice asc

select 
 ProductID,
 SellingPrice
from `e1.products`
order by SellingPrice


--Show the most expensive product first.
select
 ProductID,
 SellingPrice
from `e1.products`
order by SellingPrice desc


--Display all the products alphabetically.
select 
 ProductName
from `e1.products`
order by ProductName asc

select 
 ProductName
from `e1.products`
order by ProductName


--Oldest customers --> youngest customers.
select 
 CustomerID,
 Age
from `e1.customers`
order by Age desc


--Show the top 10 most expensive products
select 
 ProductID,
 SellingPrice
from `e1.products`
order by SellingPrice desc
limit 10


--Show the top 10 least expensive products
select 
 ProductID,
 SellingPrice
from `e1.products`
order by SellingPrice asc
limit 10

select 
 ProductID,
 SellingPrice
from `e1.products`
order by SellingPrice 
limit 10


--Which inventory records have the lowest stock?
select
 ProductID,
 Stock
from `e1.inventory`
order by Stock asc

select
 ProductID,
 Stock
from `e1.inventory`
order by Stock


--Show the top 5 most valuable payments.
select *
from `e1.payments`
order by Amount desc


--Sorting order item by sales value.
select
 ProductID,
 OrderID,
 Total
from `e1.order_items`
order by total asc

select
 ProductID,
 OrderID,
 Total
from `e1.order_items`
order by total 


--Show the highest_rated review records first.
select *
from `e1.reviews`
order by Rating desc


--Show products with MRP above 10,000 starting with the most expensive.
select
 ProductName,
 CategoryID,
 SellingPrice
from `e1.products`
where MRP > 10000
order by MRP desc


--Find the five cheapest products whose MRP is above 700>
select
 ProductID,
 ProductName,
 MRP
from `e1.products`
where MRP >700
order by MRP asc
limit 5

select
 ProductID,
 ProductName,
 MRP
from `e1.products`
where MRP >700
order by MRP 
limit 5


--Suppliers with the largest product catalog first.
select
  SupplierID,
count(*) as catalog_size
from `e1.products`
group by SupplierID
order by catalog_size 


--Which 5 suppliers provide the largest number of products?
select
 SupplierID,
count(*) as catalog_size
from `e1.products`
group by SupplierID
order by catalog_size 
limit 5


--Top 5 products by total sales
select
 ProductID,
sum(Total) as total_sales
from `e1.order_items`
group by ProductID
order by total_sales desc
limit 5


--Sort products by category first,and within each category sort by selling price from heighest to lowest.
select*
from `e1.products`
order by CategoryID asc, SellingPrice desc











