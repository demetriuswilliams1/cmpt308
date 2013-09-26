-- 1. 

select city
from agents
where aid in (select aid
	  from orders
	  where cid = 'c002')
	  	
	  
-- 2. 
select distinct pid
from orders 
where aid in (select aid
	      from orders
	      where cid in (select cid
		            from customers
			    where city = 'Kyoto'))
order by pid


-- 3. 
select cid, name
from customers 
where cid in (select cid
	      from orders 
	      where aid != 'a03')
	      
	      
-- 4. 
select cid, name
from customers
where cid in (select cid
	      from orders 
	      where pid = 'p01' AND cid in (select cid 
					     from orders 
					     where pid = 'p07'))
					     
					     
-- 5. 
select distinct pid
from orders
where cid in (select cid
	      from orders
	      where aid = 'a03')
order by pid


-- 6. 
select name, discount
from customers
where cid in (select cid
	      from orders
	      where aid in (select aid
	                    from agents 
	                    where city = 'Dallas' OR city = 'Duluth'))
	                    
	                    



-- 8.  
select distinct cid
from orders
where aid != 'a03'
order by cid