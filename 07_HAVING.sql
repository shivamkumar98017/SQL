--Display the payment methods with the heighest total payment amount at the top?
select 
 Method,
sum(Amount) as total_payment
from `e1.payments`
group by Method
order by total_payment desc


--Sort customers by city alphabatically, and written each city sort customer by age from oldest to youngest.
select 
 CustomerID,
 Age,
 City
from `e1.customers`
order by City, Age desc

select 
 CustomerID,
 Age,
 City
from `e1.customers`
order by City asc, Age desc


--Display the supplierIDs with heighest number of products first.If tied, highest average selling price first.
select 
 SupplierID,
count(ProductID) as total_prds,
avg(SellingPrice) as avg_selling_price
from `e1.products`
group by SupplierID
order by total_prds desc ,avg_selling_price desc


--Sort products by category first, and within each category sort by selling price from heighest to lowest.
select 
 ProductID,
 CategoryID,
 SellingPrice,
 ProductName
from `e1.products`
order by CategoryID, SellingPrice des


1. Take products
      ↓
2. Keep MRP > 1000
      ↓
3. Create supplier groups
      ↓
4. Count products
      ↓
5. Keep suppliers with > 2
      ↓
6. Sort highest count first
      ↓
7. Show top 5

select 
SupplierID,
count(ProductID) as prd_cnt
from `e1.products`
where MRP > 1000
group by SupplierID
having prd_cnt > 2
order by prd_cnt desc
limit 5


--Give me individual products whose MRP is greater than 20000.
select *
from `e1.products`
where MRP > 20000


--which suppliers have more than 3 products?
select
 SupplierID,
 count(ProductID) as prd_cnt
from `e1.products`
group by SupplierID
having prd_cnt > 3


--Which customers have placed more than 5 orders?
select
 CustomerID,
 count(OrderID) as total_orders
from `e1.orders`
group by CustomerID
having total_orders >5


--Suppliers with 2 or fewer products
select
 supplierID,
 count(*) as no_of_prds
from `e1.products`
group by SupplierID
having no_of_prds <= 2


--Products with sales Above 50,000.
select
ProductID,
sum(Total) as Total_sales
from `e1.order_items`
group by ProductID
having Total_sales >50000



