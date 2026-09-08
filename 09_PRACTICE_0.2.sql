--For each supplier, calculate:
--Number of products supplied
--Average MRP of those products
--Maximum MRP of those products
--Display only suppliers who supply at least 3 products.
--Sort them by the number of products supplied from highest to
--lowest.
select
 SupplierID,
 count(ProductID) as no_of_products,
 avg(MRP) as avg_MRP,
 max(MRP) as max_MRP
from `e1.products`
group by SupplierID
having no_of_products >= 3
order by no_of_products desc


--Find each CategoryID where the average MRP of products is
--greater than ₹15,000.
--Display:
--CategoryID
--Number of products
--Average MRP
--Maximum MRP
--Sort categories by average MRP from highest to lowest
select
CategoryID,
count(ProductID) as no_of_products,
avg(MRP) as avg_MRP,
max(MRP) as max_MRP
from `e1.products`
group by CategoryID
having avg_MRP >15000
order by avg_MRP desc


--Using order_items, calculate the total quantity sold and
--total sales value for every product.
--Display only products where:
--Total quantity sold is at least 10
--Total sales value is greater than ₹1,00,000
--Sort by total sales value descending

select
ProductID,
sum(Quantity) as total_quantity,
sum(Total) as Total_sales
from `e1.order_items`
group by ProductID
having total_quantity >= 10
and Total_sales > 100000
order by Total_sales desc


--Find products where the selling price is lower than the MRP.
--Display:
--ProductID
--ProductName
--MRP
--SellingPrice
--Discount amount
--Sort products by the highest discount amount first.
select
 ProductID,
 ProductName,
 MRP,
 SellingPrice,
 (MRP-SellingPrice) as discount_amount
from `e1.products`
where MRP > SellingPrice
order by discount_amount desc

--Find products where the discount is at least 10% of MRP.
--Display:
--ProductID
--ProductName
--MRP
--SellingPrice
--Discount percentage
--Sort by discount percentage from highest to lowest
select
 ProductID,
 ProductName,
 MRP,
 SellingPrice,
 round(((MRP-SellingPrice)/MRP),2)*100 as discount_percentage
from `e1.products`
WHERE ((MRP - SellingPrice) / MRP) * 100 >= 10
order by discount_percentage desc


--Consider only successful payments.
--For each payment method, calculate:
--Number of successful transactions
--Total payment amount
--Average payment amount
--Maximum payment amount
--Display only methods where the total successful payment amount
--exceeds ₹1,00,000
select
 Method,
 count(*) as no_of_sucessful_transaction,
 sum(Amount) as Total_amt,
 round(avg(Amount),2) as avg_amt,
 max(Amount) as max_amt
from `e1.payments`
where Status = "success"
group by Method
having Total_amt > 100000


--Find customers who have placed between 4 and 8 orders,inclusive.
--Display:
--CustomerID
--Number of orders
--Sort customers by order count descending and display only the top 10.
select
CustomerID,
count(OrderID) as no_of_orders
from `e1.orders`
group by customerID
having no_of_orders between 4 and 8
order by no_of_orders desc
limit 10


--For each warehouse, calculate:
--Total stock
--Average stock
--Highest stock for a product
--Lowest stock for a product
--Display only warehouses where total stock is greater than 500.
--Sort by total stock descending
select
 WarehouseID,
 sum(Stock) as Total_stock,
 round(avg(Stock),2) as avg_stock,
 max(Stock) as highest_stock,
 min(Stock) as lowest_stock,
from `e1.inventory`
group by WarehouseID
having Total_stock > 500
order by Total_stock desc


--Find products that have at least one inventory record where stock is below 20 units.
--Display:
--ProductID
--Number of inventory records
--Minimum stock
--Maximum stock
--Show only products whose minimum stock is below 20.
select
ProductID,
count(*) as total_records,
min(Stock) as min_stock,
max(Stock) as max_stock
from `e1.inventory`
group by ProductID
having min_stock < 20
and total_records >=1






