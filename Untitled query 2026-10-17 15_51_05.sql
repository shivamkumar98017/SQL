--For every employee, calculate:

--EmployeeID --> employee
--Employee name --> employee
--Department --> employee
--Number of orders handled --> order
--Number of orders whose total value exceeds ₹50,000 --> case when
--Total sales value of all orders handled --> order_items
--Display only employees who have handled at least 5 orders. --> having

--Sort employees by total sales value from highest to lowest. --> order by


select
  e.EmployeeID,
  e.Name,
  e.Department,
  count(distinct o.OrderID) as orders_handled,
  count(
    distinct case 
    when OrderTotals.order_value > 50000
     then o.OrderID
     end
    ) as HighValueOrders,
    sum(OrderTotals.order_value) as total_sales
from `e1.employees` as e   
inner join `e1.orders` as o   
on e.EmployeeID = o.EmployeeID
inner join (select 
OrderID,
sum(Total) as order_value
from `e1.order_items` as oi
group by OrderID) as OrderTotals
on o.OrderID = OrderTotals.OrderID
  group by 
  e.EmployeeID,
  e.Name,
  e.Department
having orders_handled >= 5
order by total_sales desc  



--For every employee, calculate:
--EmployeeID --> employee
--Employee name --> employee
--Department --> employee
--Number of orders handled --> orders
--Number of different customers served --> orders

--Display only employees who have handled more than 5 orders. -->having

--Sort employees by number of orders handled from highest to lowest. --> order by
select 
  e.EmployeeID,
  e.Name,
  e.Department,
  count(distinct o.OrderID) as order_handled,
  count(distinct o.CustomerID) as served_customers
from `e1.employees` as e   
inner join `e1.orders` as o   
on e.EmployeeID = o.EmployeeID
group by 
  e.EmployeeID,
  e.Name,
  e.Department
having count(distinct o.OrderID) > 5
order by count(distinct o.OrderID) desc



--For every city, calculate:

--Number of customers --> customers
--Number of orders --> orders
--Total sales value --> order_items
--Average order-item value --> order_items
--Display only cities where the total sales value is greater than ₹3,00,000. --> having

--Sort cities by total sales in descending order. --> order by

select
  c.City, 
  count(c.CustomerID) as no_of_customers,
  count(o.OrderID) as no_of_orders,
  sum(oi.Total) as total_sales,
  round(avg(oi.Total),2) as avg_item_value
from `e1.customers` as c  
inner join `e1.orders` as o    
on c.CustomerID = o.CustomerID
inner join `e1.order_items` as oi 
on oi.OrderID = o.OrderID
group by 
  c.City
having total_sales > 300000
order by total_sales desc  


--For every product that has been sold, calculate:

--ProductID --> product
--ProductName --> product
--Number of orders containing the product --> order_items
--Total quantity sold --> order_items
--Average selling price --> order_items
--Display only products whose average selling price is greater than ₹15,000. --> having

--Show the highest average selling price first. --> order by

select 
  p.ProductID,
  p.ProductName,
  count(distinct oi.OrderID) as no_of_orders,
  sum(oi.Quantity) as sold_qty,
  avg(oi.SellingPrice) as avg_selling_price,
from `e1.products` as p 
inner join `e1.order_items` as oi  
on p.ProductID = oi.ProductID
group by 
  p.ProductID,
  p.ProductName
having avg(oi.SellingPrice) >15000
order by avg(oi.SellingPrice) desc   



--For every category, calculate:
--CategoryName --> category
--Number of products --> product
--Minimum MRP --> product
--Maximum MRP --> product
--Difference between maximum and minimum MRP --> product
--Display only categories where the difference between the maximum and minimum MRP is greater than ₹10,000
select 
  c.categoryName,
  count(distinct p.ProductID) as no_of_prds,
  min(p.MRP) as min_MRP,
  max(p.MRP) as max_MRP,
  (max(p.MRP)-min(p.MRP)) as mrp_diff
from `e1.categories` as c 
inner join `e1.products` as p   
on c.categoryID = p.CategoryID 
group by
 c.categoryName
having (max(p.MRP)-min(p.MRP)) > 10000



--For each payment method, calculate:

--Number of successful transactions
--Total successful payment amount
--Average successful transaction amount
--Maximum successful transaction amount
--Display only payment methods having more than 10 successful transactions.

--Sort by average transaction amount from highest to lowest.

select 
  count(*) as success_trnx,
  sum(Amount) as total_amt,
  avg(Amount) as avg_amt,
  max(Amount) as max_amt
from `e1.payments`
where Status = "successs"
group by 
  Method 
having success_trnx > 10
order by avg_amt desc



--Find the top 15 products based on total quantity sold.
--Display:
--ProductID --> product
--ProductName --> product
--CategoryName --> category
--Total quantity sold --> order_items
--Total sales value --> order_items
--Sort by quantity sold from highest to lowest. --> order by
select
  p.ProductID,
  p.ProductID,
  c.categoryName,
  sum(oi.Quantity) as total_qty_sold,
  sum(oi.Total) as total_sales
from `e1.products` as p 
inner join `e1.categories` as c   
on c.categoryID = p.CategoryID
inner join `e1.order_items` as oi 
on oi.ProductID = p.ProductID
group by 
  p.ProductID,
  p.ProductID,
  c.categoryName
order by sum(oi.Quantity) desc  
limit 15

