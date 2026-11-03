date --> 2024-01-15
yyyy-mm-dd

select current_date() as today


--show the details of the customers who have joined in the recent 1000 days
select 
  Name,
  SignupDate
from `e1.customers`
where SignupDate >= date_sub(current_date(),interval 1000 day)


select
OrderID,
OrderDate,
extract (year from OrderDate) as order_year
from `e1.orders`



select
OrderID,
OrderDate,
extract (month from OrderDate) as order_month
from `e1.orders`


select
OrderID,
OrderDate,
extract (day from OrderDate) as order_day
from `e1.orders`


select
OrderID,
OrderDate,
extract (year from OrderDate) as order_year,
extract (month from OrderDate) as order_month,
extract (day from OrderDate) as order_day
from `e1.orders`


--How many orders were placed in each year?
select
  extract(year from OrderDate) as order_year,
  count(*) as no_of_orders
from `e1.orders`
group by Order_year
order by order_year desc


--How many orders were placed in each month?
select
extract(month from OrderDate) as order_month,
count(*) as no_of_orders
from `e1.orders`
group by order_month
order by order_month desc


select
extract(year from OrderDate) as order_year,
extract(month from OrderDate) as order_month,
count(*) as no_of_orders
from `e1.orders`
group by
  order_month,
  order_year
order by order_year desc,order_month desc



date1 = 2024-03-15
date_trunc('2024-0315',month)


select
  OrderDate,
  date_trunc(OrderDate,Month)
from `e1.orders`



select
 OrderDate,
 date_trunc(OrderDate,year) 
from `e1.orders`



--What were the total sales for each month?
select
  date_trunc(OrderDate,Month) as sales_month,
  sum(oi.Total) as total_sales
from `e1.orders` as o     
inner join `e1.order_items` as oi   
  on oi.OrderID = o.OrderID
group by sales_month
order by sales_month  





select DATE_DIFF(DATE '2024-01-20', DATE '2024-01-10', DAY) as day_diff


How many days has each customer been registered?
select
CustomerID,
SignupDate,
DATE_DIFF(current_date(), SignupDate,DAY) as days
from `e1.customers`


--Find customers who have placed at least 5 orders.
--Display:
--CustomerID --> customers
--Customer name --> customers
--City --> customers
--Number of orders --> orders
select
  c.CustomerID,
  c.Name,
  c.City,
  count(distinct o.OrderID) as no_of_orders
from `e1.customers` as c   
inner join `e1.orders` as o    
  on o.CustomerID = c.CustomerID
group by 
  c.CustomerID,
  c.Name,
  c.City
having count(distinct o.OrderID) > 5 
order by count(distinct o.OrderID) desc


--For every customer, number their orders chronologically.
--Display:
--CustomerID
--OrderID
--OrderDate
--Order number
--For example:
--Customer C001
--Order O001 → 1
--Order O005 → 2
--Order O010 → 3
select
  CustomerID,
  OrderID,
  OrderDate,
  row_number() over(partition by CustomerID order by OrderDate,OrderID) as order_number
from `e1.orders`


--Find the number of orders placed on Saturday and Sunday.
--Display:
--Day name
--Number of orders
select format_date('%A',DATE '2026-09-10')
select extract(DAYOFWEEK FROM DATE '2026-09-10')


select
  format_date('%A',OrderDate)as day_name,
  count(*) as order_count
from `e1.orders`
where extract (DAYOFWEEK from orderDate) in (1,7)
group by day_name
order by order_count desc 


--%A → Full weekday name (Monday, Tuesday, Wednesday...)
--%a → Short weekday name (Mon, Tue, Wed...)
--%B → Full month name (January, February...)


--Classify every order as:
--Weekend
--Weekday
--Then count the orders in each group.
 
select
case
 when extract(DAYOFWEEK from OrderDate) in (1,7) then 'weekend'
 else 'Weekday'     
end as Day_type,
count(*) as order_count 
from `e1.orders`
group by Day_type


--Find how many customers signed up in each calendar month,irrespective of the year.
--For example, combine all January signups together.
select
 extract(month from signupdate) as signup_month,
 format_date('%B',signupdate) as Month_Name,
 count(*) as customer_counts
from `e1.customers`
group by
 signup_month,
 Month_Name


--Classify every order as:
--First Half → January to June
--Second Half → July to December
--Then count orders.
select
case
 when extract(month from orderdate) <= 6 then "First Half"
 else "Second Half"
end as year_type,
count(*) as no_of_orders 
from `e1.orders`
group by year_type

 
--Calculate total sales for orders placed in the first half and second half of the year.

select
 case 
  when extract(MONTH from orderdate)<=6 then "First Half"
  else "Second Half"
end as year_type,
  sum(oi.Total) as total_sales    
from `e1.orders` as o
inner join `e1.order_items` as oi    
  on o.OrderID = oi.OrderID
group by year_type
order by total_sales desc  


--Find which day of the week has the highest number of customer signups.
select
 extract(DAYOFWEEK from signupdate) as day_num,
 format_date('%A',signupdate) as day_name,
 count(*) as no_of_signup
from `e1.customers` 
group by day_num,day_name
order by no_of_signup desc


--Find how many orders were placed during the first seven days of each month.
select
  date_trunc(OrderDate,MONTH) as order_month,
  count(*) as no_of_orders
from `e1.orders`
where extract(DAY from orderdate)<= 7
group by order_month


select
Date_trunc(OrderDate, MONTH) as order_month,
format_date('%B', OrderDate) as month_name,
count(*) as no_of_orders
from `e1.orders`
where extract(DAY from orderDate) <= 7
group by order_month, month_name



--Find customers who placed their first order in the same calendar month and year in which they signed up.
with first_orders as (
select
CustomerID,
min(orderdate) as first_order_date
from `e1.orders`
group by CustomerID
)


select
c.CustomerID,
c.Name,
c.SignupDate,
f.first_order_date
from `e1.customers` as c
inner join first_orders as f
on c.CustomerID = f.customerID
where
date_trunc(c.SignupDate, MONTH) =
date_trunc(f.first_order_date, MONTH)
order by c.SignupDate


--Calculate total sales for each calendar week
--Group customers into signup cohorts based on the month in which they registered.
--Display:
--Signup month
--Number of customers
