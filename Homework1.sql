-- Homework 1
-- Demetrius Williams


1.

SELECT* FROM Customers;


2.

SELECT name, city FROM Agents WHERE name = 'Smith';


3.

SELECT pid, name, quantity FROM Products WHERE priceUSD > 1.25;


4.

SELECT ordno, aid FROM Orders;


5.

SELECT name, city FROM Customers WHERE city <> 'Dallas';


6.

 SELECT name FROM Agents WHERE city = 'New York' OR city = 'Newark';


7.

SELECT* FROM Products WHERE city <> 'New York' AND city <> 'Newark' AND priceUSD <= 1.00;


8.

SELECT* FROM Orders WHERE mon = 'jan' OR mon = 'mar';


9.

SELECT* FROM Orders WHERE mon = 'feb' AND dollars < 100.00;


10.

SELECT* FROM Orders WHERE cid = 'c005';