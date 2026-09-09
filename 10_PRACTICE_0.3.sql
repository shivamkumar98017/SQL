--Calculate the number of orders and percentage of total orders represented by each order status.
select
 Status,
 count(OrderID) as total_orders,
 round(count(OrderID)*100.0/ (select count(*) from `e1.orders`),2) as percentage_of_orders
from `e1.orders`
group by Status
order by percentage_of_orders desc


--Using order_items, find the top 5 products based on total quantity sold.
--Display:
--ProductID
--Total quantity sold
--Number of order-item records
--Total sales valu
select 
 ProductID,
 sum(Quantity) as total_qnt_sold,
 count(OrderItemID) as total_order_item,
 sum(Total) as total_sales_value
from `e1.order_items`
group by ProductID
order by total_qnt_sold desc
limit 5


--Consider only order-item records where the total value of that item is greater than ₹2500.
--For each product, calculate:
--Number of such records
--Total quantity
--Total sales value
--Display products having at least 3 qualifying records.
select
 ProductID,
 count(*) as total_records,
 sum(quantity) as total_qnt,
 sum(Total) as Total_sales_value
from `e1.order_items`
where Total > 2500
group by ProductID
having total_records >=3


--For each product, calculate:
--Minimum selling price
--Maximum selling price
--Average selling price
--Number of order-item records
--Display only products where the minimum selling price is greater than ₹10,000.
--Sort by average selling price descending
select
 ProductID,
 min(SellingPrice) as min_sp,
 max(SellingPrice) as max_sp,
 avg(SellingPrice) as avg_sp,
 count(OrderID) as No_of_order_items
from `e1.order_items`
group by ProductID
having min_sp > 10000
order by avg_sp desc


----For every warehouse, calculate:
--Number of different products stored
--Total stock
--Average stock per product
--Display only warehouses storing at least 5 different products.
--Sort by total stock descending.
select
 WarehouseID,
 count(distinct ProductID) as no_of_products,
 sum(Stock) as total_stock,
 round(avg(Stock),2) as avg_stock
from `e1.inventory`
group by WarehouseID
having no_of_products >= 5
order by total_stock desc


--Find products whose MRP is greater than the average MRP of all products.
select *
from `e1.products`
where MRP > (
          select
          avg(MRP)
          from `e1.products`
          )


--Find products whose MRP is below the average MRP.
select *
from `e1.products`
where MRP < (
           select
          avg(MRP)
          from `e1.products`
)


--Find the product or products having the highest MRP.
select *
from `e1.products`
where MRP = (select
                  max(MRP)
                  from `e1.products`
                  )


--find those products which have the top 5 mrp prices.
select distinct(MRP)
from `e1.products`
order by MRP desc
limit 5

