--case when statements
--if-elseif-else

--syntax:
--case
    --when condition1 then result1
    --when condition2 then result2
    --when condition3 then result3
    --else default_result
--end


--categorise customers as 
--18-20: genz,
--21-40:adult,
--41 onward : senior_citizen

select
  CustomerID,
  Age,
  Name,
  case
    when Age >= 18 and Age <= 20 then "Genz"
    when Age >= 21 and Age <= 40 then "Adult"
    else "Senior_citizen"
  end as age_group  
from `e1.customers` as c


select
  CustomerID,
  Age,
  Name,
  case
    when Age >= 18 and Age <= 20 then "Genz"
    when Age <= 40 then "Adult"
    when age > 40  then "Senior_citizen"
  end as age_group  
from `e1.customers` as c


F --> Female
M  --> Male
select
   CustomerID,
   Name,
   Gender, 
   case
      when Gender = "M" then "Male"
      else "Female"
   end as Gender_New 
from `e1.customers` 


--For every order, calculate the total order value by adding the
--Total column from order_items.
--Then classify each order as:

--High Value → Total order value ≥ ₹50,000
--Medium Value → Total order value between ₹20,000 and ₹49,999
--Low Value → Total order value < ₹20,000


--Display:
--OrderID --> orders
--OrderDate --> orders
--CustomerName --> customer
--TotalOrderValue --> order_items
--OrderCategory --> create using total_sales
--Show the highest-value orders first. --> order by


select 
  o.OrderID,
  o.OrderDate,
  c.Name,
sum(oi.Total) as total_sales,
case
 when sum(oi.Total)  >= 50000 then "High Value"
 when sum(oi.Total) >= 20000 then "Medium Value"
 else "Low Value"
 end as orderCategory
from `e1.orders` as o
inner join `e1.customers` as c  
on o.CustomerID = c.CustomerID
inner join `e1.order_items` as oi 
on oi.OrderID = o.OrderID 
group by 
   o.OrderID,
   o.OrderDate,
   c.Name
order by total_sales desc


--Problem Statement
--Create a category-level sales report containing:


--CategoryID --> category
--CategoryName --> category
--Number of products in the category --> product
--Number of different products sold --> order_items
--Total quantity sold --> order_items
--Total sales value --> order_items
--Average selling price --> order_items


--Only consider order-item records where:
--SellingPrice > ₹10,000 --> where
--Display only categories where:
--Total sales value > ₹5,00,000 --> having
--Sort categories from highest to lowest total sales. --> order by

select 
  c.categoryID,
  c.categoryName,
  count(distinct p.ProductID) as total_prds,
  count(distinct oi.ProductID) as different_prds_sold,
  sum(oi.Quantity) as total_qty_sold,
  sum(oi.Total) as total_sales,
  round(avg(oi.SellingPrice),2) as avg_selling_price
from `e1.categories` as c
inner join `e1.products` as p  
on c.categoryID = p.CategoryID 
inner join `e1.order_items` as oi 
on oi.ProductID = p.ProductID
where oi.SellingPrice > 10000
group by 
  c.categoryID,
  c.categoryName
having total_sales > 500000 
order by total_sales desc


--Find products where:
--MRP is greater than ₹15,000 --> where
--Discount percentage is greater than 20% -->
--Total sales value is greater than ₹75,000
--Display:
--ProductID --> product
--ProductName --> product
--CategoryName --> category
--MRP --> product
--SellingPrice --> product
--Discount percentage --> derieved field --> (mrp - sp)*100/mrp
--Total sales --> order_items
--Sort by discount percentage from highest to lowest.

select 
  p.ProductID,
  p.ProductName,
  c.categoryName,
  p.MRP,
  p.SellingPrice,
  (p.MRP-p.SellingPrice)*100/p.MRP as Discount_perc,
  sum(oi.Total) as total_sales
from `e1.products` as p 
inner join `e1.categories` as c   
on p.CategoryID = c.categoryID 
inner join `e1.order_items` as oi 
on p.ProductID = oi.ProductID 
where p.MRP > 15000
group by 
  p.ProductID,
  p.ProductName,
  c.categoryName,
  p.MRP,
  p.SellingPrice
having total_sales > 75000 
and (p.MRP-p.SellingPrice)*100/p.MRP > 20
order by Discount_perc desc



















