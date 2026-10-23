--Total sales made by each product
select 
  ProductID,
  sum(Total) as total_sales
from `e1.order_items`
group by ProductID



--Show every order-item record, but also show the total sales of that product beside every row.
select
  ProductID,
  OrderID,
  Total,
  sum(Total) over(partition by ProductID) as product_total_sales
from `e1.order_items`


-- function() over(partition by column order by column)


--For every order-item record, display:
--ProductID
--SellingPrice
--Average selling price of that product
select 
  productID,
  SellingPrice,
  avg(SellingPrice) over(partition by ProductID) as prd_avg_price
from `e1.order_items`



--For every order-item record, show:
--ProductID
--OrderID
--Number of order-item records for that product
select
  ProductID,
  OrderID,
  count(*) over (partition by ProductID) as no_of_records
from `e1.order_items`



--For every order-item record, display:
--OrderID
--ProductID
--Total
--Total sales across the entire order_items table
select
  OrderID,
  ProductID,
  Total,
  overall_sales,
  round((Total*100)/overall_sales,4) as perc_total_sales
from (select
  OrderID,
  ProductID,
  Total,
  sum(Total) over() as overall_sales
from `e1.order_items`)



--Display every order-item record and assign a row number based on Total, from highest to lowest.
select 
  OrderID,
  ProductID,
  Total,
row_number() over(order by Total) as row_num
from `e1.order_items`


--For every order-item record, display:
--ProductID
--SellingPrice
--Average selling price of that product
select 
  ProductID,
  SellingPrice,
  avg(SellingPrice) over(partition by ProductID) avg_selling_price
from `e1.order_items`


--Display every order-item record and assign a row number based on Total, from highest to lowest.
select 
  ProductID,
  OrderID,
  Total,
row_number() over (order by Total desc) as sales_rank
from `e1.order_items`


--For every product, assign a row number to its order-item records based on sales from highest to lowest.
select
  ProductID,
  OrderID,
  Total,
  row_number() over(partition by ProductID order by Total desc) as prd_row_rank
from `e1.order_items`


| Product | Sales |
| ------- | ----: |
| P001    | 10000 |
| P002    |  9000 |
| P003    |  9000 |
| P004    |  7000 |

row_number() -->
p1->1
p2->2
p3->3
p4->4


rank()
p1 -> 1
p2 -> 2
p3 -> 2
p4 -> 4

dense_rank()
p1 -> 1
p2 -> 2
p3 -> 2
p4 -> 3

CTE --> Common Table Expression

with product_sales as (
  select 
   ProductID,
   sum(Total) as total_sales
  from `e1.order_items`
  group by ProductID
)

select 
 ProductID,
 total_sales,
 rank() over(order by total_sales desc) as sales_rank
from product_sales



with product_sales as (
  select 
   ProductID,
   sum(Total) as total_sales
  from `e1.order_items`
  group by ProductID
)

select 
 ProductID,
 total_sales,
 dense_rank() over(order by total_sales desc) as sales_rank
from product_sales


--For every customer, show the number of orders they have placed,including customers with zero orders.
select 
  c.CustomerID,
  c.Name,
  count(o.OrderID) as order_count
from `e1.customers` as c  
left join `e1.orders` as o 
on c.CustomerID = o.CustomerID
group by 
  c.CustomerID,
  c.Name
order by  order_count desc 



--Show every order with:
Customer name --> customers
Product name --> products
Category --> category
Quantity --> order_items
Selling price --> order_items
Total --> order_items

select
c.Name,
p.ProductName,
ct.CategoryName,
oi.Quantity,
oi.SellingPrice,
oi.Total
from `e1.customers` as c
inner join `e1.orders` as o
on c.CustomerID = o.CustomerID
inner join `e1.order_items` as oi
on o.OrderID = oi.OrderID
inner join `e1.products` as p
on oi.ProductID = p.ProductID
inner join `e1.categories` as ct
on p.CategoryID = ct.CategoryID


--Customer name --> customers
Product name --> products
Category --> category
Quantity --> order_items
Selling price --> order_items
Total --> order_items
Sales by Category and Supplier

select
cat.CategoryName,
s.SupplierName,
sum(oi.Total) as total_sales
from `e1.categories` as cat
inner join `e1.products` as p
on cat.CategoryID = p.CategoryID
inner join `e1.suppliers` as s
on s.SupplierID = p.SupplierID
inner join `e1.order_items` as oi
on p.ProductID = oi.ProductID
group by
cat.CategoryName,
s.SupplierName
order by total_sales desc


--How many different products has each customer purchased?
select
  c.CustomerID,
  c.Name,
  count(distinct oi.ProductID) as diff_prds
from `e1.customers` as c 
inner join `e1.orders` as o
  on c.CustomerID = o.CustomerID
inner join `e1.order_items` as oi 
  on oi.OrderID = o.OrderID 
group by 
  c.CustomerID,
  c.Name 
order by diff_prds desc


--The management wants to understand which product categories are generating the most revenue.

--Using the products, categories, and order_items tables,
--calculate the total sales generated by each category.
--Display:
--CategoryID
--CategoryName
--Total Sales
--Number of different products sold
--Only include categories where the total sales are greater than ₹1,00,000.

--Sort the result from highest to lowest total sales.
select
  c.categoryID,
  c.categoryName,
  sum(oi.Total) as total_sales,
  count(distinct p.ProductID) as prds_sales
from `e1.products` as p 
inner join `e1.categories` as c  
  on c.categoryID = p.CategoryID
inner join `e1.order_items` as oi     
  on oi.ProductID = p.ProductID
group by
  c.categoryID,
  c.categoryName
having total_sales > 100000
order by total_sales desc  


--The marketing team wants to identify customers who have generated significant revenue.

--Using the customers, orders, and order_items tables, calculate
--the total amount spent by each customer.
--Display:
--CustomerID --> customers
--Customer Name --> customers
--City --> customers
--Total Spent --> order_items
--Only display customers whose total spending is greater than ₹50,000. --> having

--Sort customers from highest spender to lowest spender. --> order by
select
  c.CustomerID,
  c.Name,
  c.City,
  sum(oi.Total) as total_spending
from `e1.customers` as c   
inner join `e1.orders` as o
  on c.CustomerID = o.CustomerID
inner join `e1.order_items` as oi    
  on oi.OrderID = o.OrderID  
group by 
  c.CustomerID,
  c.Name,
  c.City
having total_spending > 50000  
order by total_spending desc  



--The procurement team wants to compare suppliers based on the sales generated by the products they supply.

--Using suppliers, products, and order_items, calculate:
--SupplierID
--SupplierName
--Number of products supplied
--Total sales generated by those products
--Display only suppliers whose products have generated more than ₹2,00,000 in total sales.
--Sort by total sales in descending order.
select
  s.SupplierID,
  s.SupplierName,
  count(distinct p.ProductID) as supplied_prds,
  sum(oi.Total) as total_sales
from `e1.suppliers` as s    
inner join `e1.products` as p
  on s.SupplierID = p.SupplierID
inner join `e1.order_items` as oi  
  on oi.ProductID = p.ProductID
group by 
   s.SupplierID,
  s.SupplierName
having total_sales > 200000
order by total_sales desc


--The CRM team wants to understand the sequence in which customers placed their orders.

--For every order, display:
--CustomerID --> customer
--OrderID --> orders
--OrderDate --> orders
--The order number for that customer
--For example:
--Customer C001
--First order → 1
--Second order → 2
--Third order → 3
--The numbering should be based on OrderDate, from oldest to newest
SELECT 
  c.CustomerID,
  o.OrderID,
  o.OrderDate,
  ROW_NUMBER() OVER (
    PARTITION BY c.CustomerID 
    ORDER BY o.OrderDate ASC
  ) AS OrderSequence
FROM `e1.customers` AS c
INNER JOIN `e1.orders` AS o    
  ON c.CustomerID = o.CustomerID
ORDER BY c.CustomerID, o.OrderDate ASC



--Find the total amount successfully paid by each customer.
--Display:
--CustomerID --> customers
--Customer name --> customers
--Number of successful payments --> payments
--Total successful payment amount --> payments
--customers --> orders --> payments
--Show only customers whose successful payment amount is greater than ₹50,000. --> having
select 
  c.CustomerID,
  c.Name,
  count(p.PaymentID) as no_of_payments,
  sum(p.Amount) as Total_amt
from `e1.customers` as c
inner join `e1.orders` as o     
  on c.CustomerID = o.CustomerID
inner join `e1.payments` as p    
  on p.OrderID = o.OrderID
where p.Status = "success"
group by 
  c.CustomerID,
  c.Name
having sum(p.Amount) > 50000  
order by sum(p.Amount) desc


--For each category, calculate:
--Category name --> category
--Number of products --> products
--Average MRP --> products
--Average selling price --> products
--Average discount amount --> mrp - sp --> products
--Consider:
--Discount = MRP - SellingPrice
--Display categories with at least 5 products, --> having
select 
  c.categoryName,
  count(p.ProductID) as no_of_prds,
  round(avg(p.MRP),2) as avg_mrp,
  round(avg(p.SellingPrice),2) as avg_sp,
  round(avg(p.MRP-p.SellingPrice),2) as avg_dis_amt,
from `e1.categories` as c     
inner join `e1.products` as p 
on c.categoryID = p.CategoryID
group by 
  c.categoryName
having  count(p.ProductID) >= 5  
order by avg_mrp desc


--For every supplier, calculate:
--Supplier name
--Number of products supplied
--Number of order-item records
--Total quantity sold
--Total sales value
--Include suppliers even if they currently have no sales.
--Sort by total sales from highest to lowest
select
  s.SupplierName,
  count(distinct p.ProductID) as no_of_prds,
  count(oi.OrderItemID) as no_of_oi_recors,
  coalesce(sum(oi.Quantity),0) as total_qnty,
  coalesce(sum(oi.Total),2) as total_sales
from `e1.suppliers` as s     
left join `e1.products` as p     
  on p.SupplierID = s.SupplierID
left join `e1.order_items` as oi   
  on oi.ProductID = p.ProductID 
group by 
  s.SupplierName
order by total_sales desc



--For every warehouse, calculate:
--Warehouse name
--Number of orders handled
--Total inventory stock
--Average inventory stock
--include warehouses even if they have no orders.
select 
  w.WarehouseName,
  count(distinct o.OrderID) as no_of_orders,
  coalesce(sum(i.Stock),0) as total_inve,
  coalesce(round(avg(i.Stock),2),0) as avg_inve,
from `e1.warehouses` as w    
left join `e1.orders` as o     
 on w.WarehouseID = o.WarehouseID
left join `e1.inventory` as i     
 on i.WarehouseID = w.WarehouseID
group by 
w.WarehouseName 


--Find the category whose products have the highest average selling price.

--Display:
--CategoryID
--CategoryName
--Average selling price
select
  c.CategoryID,
  c.CategoryName,
round(avg(p.SellingPrice)) as avg_sp
from e1.categories as c
inner join e1.products as p
  on p.CategoryID = c.CategoryID
group by
  c.CategoryID,
  c.CategoryName
order by avg_sp desc
limit 1

