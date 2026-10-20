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
