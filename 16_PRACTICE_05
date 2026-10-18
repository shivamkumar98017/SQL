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

--For every warehouse, calculate:

--WarehouseID --> warehouse
--Warehouse name --> warehouse
--Number of inventory records --> inventory
--Total stock --> sum()
--Average stock --> avg()
--Highest stock in a single inventory record --> max()
--Display only warehouses where the average stock per inventory record is greater than 100. --> having

--Sort by total stock descending. --> order by

select 
  w.WarehouseID,
  w.WarehouseName,
  count(i.WarehouseID) as inventory_records,
  sum(i.Stock)as total_stock,
  round(avg(i.Stock),2) as avg_stock,
  max(i.Stock) as highest_stock
from `e1.warehouses` as w
inner join `e1.inventory` as  i  
on i.WarehouseID = w.WarehouseID 
group by 
  w.WarehouseID,
  w.WarehouseName
having avg(i.Stock) > 100  
order by sum(i.Stock) desc


--Find products that:
--Exist in the product catalogue
--Have inventory records
--Have never appeared in any order item --> order_items
--Display:
--ProductID --> product
--ProductName --> product
--SupplierID --> product
--Number of inventory records --> inventory
--Total stock --> inventory
--Sort by total stock from highest to lowest.
select 
 p.productID,
 p.ProductName,
 p.SupplierID,
 count(i.WarehouseID) as no_of_inv,
 sum(i.Stock) as total_stock
from `e1.products` as p    
inner join  `e1.inventory` as i     
on i.ProductID = p.ProductID
left join `e1.order_items` as oi 
on p.ProductID = oi.ProductID
where oi.ProductID is null
group by 
  p.productID,
 p.ProductName,
 p.SupplierID
order by sum(i.Stock) desc 


--For each supplier, calculate:
--SupplierName --> supplier
--Number of products --> products
--Average MRP --> products
--Highest MRP --> products
--Lowest MRP --> products
--Classify each supplier as:
--Premium Supplier if average MRP >= ₹30,000
--Mid-Range Supplier if average MRP >= ₹15,000
--Budget Supplier otherwise
--Display the suppliers with the highest average MRP first.
select 
  s.SupplierName,
  count(p.ProductID) as no_of_prds,
  avg(p.MRP) as avg_mrp,
  max(p.MRP) as max_mrp,
  min(p.MRP) as min_mrp,
case 
 when avg(p.MRP) >= 30000 then "Premium Supplier" 
 when avg(p.MRP) >= 15000 then "Mid-Range supplier"
 else "Budget supplier"
 end as supplierCategory
from `e1.suppliers` as s  
inner join `e1.products` as p      
on p.SupplierID = s.SupplierID
group by 
  s.SupplierName
order by avg(p.MRP) desc



--Find customers who have purchased products from at least 3 different categories.--> count( distinct categoryid)

--Display:
--CustomerID --> customers
--Customer name --> customers
--Number of different categories purchased --> product
--Total quantity purchased --> order_items
--Total amount spent --> order_items
--Sort by number of different categories purchased from highest to lowest.

select 
  c.CustomerID,
  c.Name,
  count(distinct p.CategoryID) as diff_categories,
  sum(oi.Quantity) as Total_quantity,
  sum(oi.Total) as total_amount,
from `e1.customers` as c     
inner join `e1.orders` as o   
on c.CustomerID = o.CustomerID
inner join `e1.order_items` as oi 
on oi.OrderID = o.OrderID
inner join `e1.products` as p  
on p.ProductID = oi.ProductID
group by 
  c.CustomerID,
  c.Name
having count(distinct p.CategoryID) >= 3 
order by count(distinct p.CategoryID) desc



---Find customers who have at least one order associated with a failed payment.
--Display:
--CustomerID --> customer
--CustomerName --> customer
--Number of orders having failed payments --> orders
--Total value of those orders --> order_items
--Display customers with the highest failed-payment order value first.
select 
  c.CustomerID,
  c.Name,
  count(distinct o.OrderID)as failed_orders,
  sum(oi.Total) as total_value,
from `e1.orders` as o
inner join `e1.customers` as c   
on o.CustomerID = c.CustomerID
inner join `e1.order_items` as oi 
on oi.OrderID = o.OrderID
inner join `e1.payments` as p 
on p.OrderID = o.OrderID
where p.Status = "Failed"
group by 
  c.CustomerID,
  c.Name
order by sum(oi.Total) desc  


--Find employees who have handled at least one order whose total value is greater than ₹75,000.

--Display:
--EmployeeID --> employee
--EmployeeName --> employee
--Number of high-value orders --> orders
--Total value of high-value orders --> order_items
--Average high-value order amount --> order_items
--having
--Sort by total high-value sales from highest to lowest.
select 
  e.EmployeeID,
  e.Name,
  sum(oi.Total) as total_sales_val,
  count(distinct o.OrderID) as no_of_ords,
  avg(oi.Total) as high_val_ord_amt
from `e1.employees` as e  
inner join `e1.orders` as o 
on e.EmployeeID = o.EmployeeID
inner join `e1.order_items` as oi 
on o.OrderID = oi.OrderID
group by 
  e.EmployeeID,
  e.Name
having sum(oi.Total) > 75000
order by sum(oi.Total) desc
