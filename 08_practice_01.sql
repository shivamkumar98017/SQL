--Display supplierID and the number of products supplied by each supplier.
--Show suppliers with the heighest number of products first.
select
 supplierID,
 count(ProductID) as no_of_prds
from `e1.products`
group by SupplierID
order by no_of_prds desc


--Calculate the total sales value for each productID using the total column for order-Items.
--Display the products from heighest to lowest sales value and show only the top 10.
select
 ProductID,
 sum(Total) as total_sales_value
from `e1.order_items`
group by ProductID
order by total_sales_value desc
limit 10


--Display only products whose total sales value is greater than 50,000,
--sorted by total sales value from highest to lowest.
select
 ProductID,
 sum(Total) as total_sales_value
from `e1.order_items`
group by ProductID
having total_sales_value >50000
order by total_sales_value desc


--For only payments where status = "success",
--calculate the number of tarnsactions and total payment amount for each Method.
--Display method with the heighest total payment amount first.
select
 Method,
 count(*) as no_of_transections,
 sum(Amount) as total_payment_amount
from `e1.payments`
where status = "success"
group by Method
order by total_payment_amount desc


--Calculate the number of orders placed by every customerID,
--Display only customers who have placed more than 3 orders.
select
 CustomerID,
 count(OrderID) as total_orders
from `e1.orders`
group by CustomerID
having total_orders >3


--Consider only products having an MRP greater than 20,000.
--For each categoryID, count the number of such products.
--Display only categories having more than 2 qualifying products.
select
 CategoryID,
 count(ProductID) as total_products
from `e1.products`
where MRP > 20000
group by CategoryID
having total_products > 2


--For every WarehouseID, calculate:
--Total stock
--Average stock per inventory record
--Maximum stock
--Minimum stock
--Sort warehouses by total stock from highest to lowest.
select
 WarehouseID,
 sum(Stock) as total_stock,
 round(avg(Stock),2) as avg_stock,
 max(Stock) as max_stock,
 min(Stock) as min_stock
from `e1.inventory`
group by WarehouseID
order by total_stock desc


--For every Status in the orders table, calculate the number of orders.
--Display the most common order status first.
select
 Status,
 count(OrderID) as no_of_orders
from `e1.orders`
group by Status
order by no_of_orders desc


--Consider only order_items records where SellingPrice > 10000.
--For each ProductID, calculate:
--Number of order-item records
--Total quantity sold
--Total sales value
--Average selling price
--Display only products whose total sales value is greater than ₹50,000, sorted by total sales value from highest to lowest.

select
 ProductID,
 count(OrderItemID) as total_order_items,
 sum(Quantity) as total_sold_qnt,
 sum(Total) as total_sales_value,
 avg(SellingPrice) as avg_selling_price 
from `e1.order_items`
where SellingPrice > 10000
group by ProductID
having total_sales_value > 50000
order by total_sales_value desc
