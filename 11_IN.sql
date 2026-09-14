--find all the products whose mrp is greater than the average mrp.
select 
avg(MRP)
from `e1.products`

select
 MRP
from `e1.products`
where MRP > 2312.7400000000

select 
 MRP 
from `e1.products`
where MRP > (
            select
             round(avg(MRP),2)
          from `e1.products`
          );



--filter out those products whose mrp is among the top 5 distinct highest mrps.
select distinct(MRP)
from `e1.products`
order by MRP desc
limit 5

select *
from `e1.products`
where (MRP = 4937) or (MRP = 4927) or (MRP = 4880) or (MRP =4698) or (MRP = 4662)

select *
from `e1.products`
where MRP in (4937,4927,4880,4698,4662)

select *
from `e1.products`
where MRP in (
          select distinct(MRP)
          from `e1.products`
          order by MRP desc
          limit 5
)



--Find the product or products having the highest MRP.
select *
from `e1.products`
where MRP in (
              select max(MRP)
              from `e1.products`
)


--Find products supplied by suppliers who supply at least 5 products.
select *
from `e1.products`
where SupplierID in (
                     select 
                     SupplierID
                     from `e1.products`
                     group by SupplierID
                    having count(*) >= 5
)


--Find the customerIDs who have placed at least 3 orders.
select 
 CustomerID,
 count(*) as no_of_orders
from `e1.orders`
group by CustomerID
having no_of_orders >= 3
order by no_of_orders desc


--Display details of those customers who have placed at least 3 orders.
select
 CustomerID
from `e1.orders`
group by CustomerID
having count(*) >=3

select *
from `e1.customers`
where CustomerID in (
                     select
                      CustomerID
                     from `e1.orders`
                     group by CustomerID
                     having count(*) >= 3
)


--find suppliers whose number of products is
--greater than the average number of products supplied per supplier
select
 SupplierID,
 count(*) as no_of_prds
from `e1.products`
group by SupplierID
having no_of_prds >= (
                      select
                      avg(no_of_products)
                      from (select
                       SupplierID,
                       count(*) as no_of_products
                      from `e1.products`
                      group by SupplierID
)
)
