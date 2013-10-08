Demetrius Williams

--1. Get the cities of agents booking an order for customers c002. Use a subquery.

select city
from agents
where aid in (select aid
               from orders
               where cid = 'c002')

--2. Get the cities of agents booking an order for customer c002. This time use joins; no subqueries.

select a.city
from agents a,
     orders o
where a.aid = o.aid
  and o.cid = 'c002'

--3. Get the pids of products ordered through any agent who makes at least one order for a customer in Kyoto. Use subqueries.

select distinct pid
from orders 
where aid in (select aid
               from orders
               where cid in (select cid
                              from customers
                              where city = 'Kyoto'))

--4. Get the pids of products ordered through any agent who makes at least one order for a customer in Kyoto. Use joins this time; no subqueries.

select distinct o1.pid		
from orders o,
     orders o1,
     customers c
where o.cid = c.cid
  and o1.aid = o.aid
  and c.city = 'Kyoto'


--5. Get the names of customers who have never placed an order. Use a subquery.

Select name
from customers
where cid not in(select cid
                   from orders)

--6. Get the names of customers who have never placed an order. Use an outer join.

select c.name 
from customers c 
full outer join orders o  
on c.cid = o.cid 
where o.cid is null 

--7. Get the names of customers who placed at least one order through an agent in their city, along with those agent(s) names.

select distinct customers.name as Customer_Name,agents.name as Agent_Name
from customers, agents, orders
where customers.cid = orders.cid
  and agents.aid = orders.aid
  and customers.city = agents.city

--8. Get the names of customers and agents in the same city, along with the name of the city, regardless of whether or not the customer has ever palced an order with that agent.

select distinct c.name, a.name, c.city
from customers c, agents a
where c.city = a.city 

--9. Get the name and city of customers who live in the city where the least number of products are made.

select c.name, c.city
from customers c
where c.city in (select p.city
                  from products p
                  group by p.city
                  order by count(*) asc limit 1)

--10. Get the name and city of customers who live in a city where the most number of products are made.

select c.name, c.city
from customers c
where c.city in (select p.city
                  from products p
                  group by p.city
                  order by count(*) desc limit 1)

--11. Get the name and city of customers who live in any city where the most number of products are made.

select c.name, c.city
from customers c
where c.city in (select p1.city
                  from products p1
                  group by p1.city
                  having count(*) = (select count(*)
                                      from products p2
                                      group by p2.city
                                      order by count(*) desc limit 1))

--12. List the products whose priceUSD is above the average priceUSD.

select p.name
from products p
where priceUSD > (select avg(priceUSD)
                   from products)

--13. Show the customer name, pid ordered, and the dollars for all customer orders, sorted by dollars from high to low.

select c.name, o.pid, o.dollars
from customers c, orders o
order by o.dollars desc

--14. Show all customer names(in order) and their total ordered, and nothing more. Use coalesce to avoid showing NULLs.

select c.name,coalesce ( sum (o.dollars), 0)
from customers c left outer join orders o on c.cid = o.cid
group by c.cid
order by c.name asc

--15. Show the names of all customers who bought products they ordered, and the names of the afents who sold it to them.

select c.name, p.name, a.name
from products p, agents a, customers c, orders o
where c.cid = o.cid
  and p.pid = o.pid
  and a.aid = o.aid 
  and a.city = 'New York'

--16.Write a query to check the accuracy of the dollars column in the Orders table.This means calculating Orders.dollars from other data in other tables and then comparing those values to the values in Orders.dollars.

select o.ordno, o.dollars as "Incorrect Dollar Value", (p.priceUSD * o.qty) - ((p.priceUSD * o.qty ) * (c.discount/ 100)) as "Correct Dollar Value"
from orders o, products p, customers c
where c.cid = o.cid
  and p.pid = o.pid
  and o.dollars <> (p.priceUSD * o.qty) - ((p.priceUSD * o.qty ) * (c.discount/ 100))

--17. Create an error in the dollars column of the Orders table so that you can verify your accuracy checking query.
update orders
set   dollars = 77777
where dollars = 434