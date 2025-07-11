
-- Queries using Nested Sub-Queries
/*
  Name: MySQL Sample Database classicmodels
  Link: http://www.mysqltutorial.org/mysql-sample-database.aspx
*/

-- Retrieve the product codes and names for items ordered by customers in the USA.
-- Inner query1:
select customerNumber
from customers
where country = 'USA';

-- Inner query2:
select orderNumber
from orders
where customerNumber in (select customerNumber
from customers
where country = 'USA') ;

-- inner query3:
select productCode
from orderdetails 
where orderNumber in (select orderNumber
from orders
where customerNumber in (select customerNumber
from customers
where country = 'USA'));

-- outer query4:
select productCode, productName
from products
where productCode in (select productCode
from orderdetails 
where orderNumber in (select orderNumber
from orders
where customerNumber in (select customerNumber
from customers
where country = 'USA')));




-- Retrieve the employee number, first name, and last name of employees who report to manager 'Murphy'.
select employeeNumber, firstName, lastName
from Employees 
where reportsTo = (
	select employeeNumber
	from Employees
	where lastName='Murphy'); 


-- Retrieve the order numbers for orders that include products from the 'Motorcycles' product line.

select productCode
from products 
where productline = 'Motorcycles';

select orderNumber
from orderdetails
where productCode in (select productCode
from products 
where productline = 'Motorcycles');
-- Retrieve the names of customers who have placed orders.
select customerName
from customers
where customerNumber in (
select customerNumber
from orders
);

-- Retrieve the city and country of offices located in countries where customers are present.
select city, country
from offices
where country in (select country
from customers
where salesRepEmployeeNumber is not null);

-- Retrieve the product codes and names for products with orders exceeding 50.
select productCode, productName
from products
where productCode in (select productCode
from orderdetails
where quantityOrdered > 50);

select productCode
from orderdetails
where quantityOrdered > 50;
-- Retrieve the employee number, first name, and last name of employees who have customers in their territory.
select employeeNumber, firstName, lastName
from employees
where officeCode in (select officeCode
from offices
where city in (select city
from customers where salesRepEmployeeNumber is not null));

-- Retrieve the order numbers for orders shipped to 'France'.
select orderNumber
from orders
where customerNumber in (select customerNumber
from customers
where country = 'france');

select customerNumber
from customers
where country = 'france';
-- Retrieve the names of customers who placed orders between 2003-01-01 and 2003-12-31.
select customerName
from customers
where customerNumber in (select customerNumber
from orders
where orderDate between '2003-01-01' and '2003-12-31');

select customerNumber
from orders
where orderDate between '2003-01-01' and '2003-12-31';


-- Retrieve the order numbers for orders with a specific status.
select status, orderNumber
from orders
where status='shipped'
and orderNumber in(
select orderNumber from orderdetails);


-- Retrieve the names of customers with credit limits exceeding a specified amount 50000.
select customerName
from customers
where creditLimit > 5000
and customerNumber in (select customerNumber
from orders);
-- Retrieve the employee number, first name, and last name of employees working in 'San Francisco'.
select employeeNumber, firstName, lastName
from employees
where officeCode in (select officeCode 
from offices
where city = 'San Francisco');
select officeCode 
from offices
where city = 'San Francisco';

-- Retrieve the product codes and names for products from 'Autoart Studio Design' vendor.
select productCode, productName
from products
where productVendor= 'Autoart Studio Design'
and productCode in (select productCode from orderdetails);

-- Retrieve the order numbers for orders with a total price exceeding a 1000.
select orderNumber
from orders
where orderNumber in (
select orderNumber from orderdetails
group by orderNumber having sum(priceEach*quantityOrdered) > 1000);
-- Retrieve the product codes and names for products ordered by customers from Spain.
select productCode, productName
from products
where productCode in (select productCode 
from orderdetails
where orderNumber in (select orderNumber
from orders
where customerNumber in (select customerNumber
from customers
where country = 'spain'
order by customerNumber asc)));

select productCode 
from orderdetails
where orderNumber in (select orderNumber
from orders
where customerNumber in (select customerNumber
from customers
where country = 'spain'
order by customerNumber asc));

select orderNumber
from orders
where customerNumber in (select customerNumber
from customers
where country = 'spain'
order by customerNumber asc);

select customerNumber
from customers
where country = 'spain'
order by customerNumber asc;
-- Retrieve the city and country of offices located in cities where customers have placed orders.
select city, country
from offices
where city in (select city
from customers
where customerNumber in (
select customerNumber 
from orders));


-- Retrieve the employee number, last name, and first name of employees with customers in their office's country.
select employeeNumber, lastName, firstName
from employees
where officeCode in (select officeCode
from offices
where country 
in (select distinct country from customers));


-- Queries using Correlated Sub Queries
-- Retrieve the product codes and names for products priced above 
-- the average price of all products.
select productCode, productName
from products as p1
where buyPrice > (select avg(p2.buyPrice)
from products as p2);

select avg(p2.buyPrice)
from products as p2;

-- Retrieve the names of customers with credit limits higher than the average credit limit in their country.
select customerName, creditLimit
from customers
where creditLimit > (select avg(creditLimit)
from customers as c where c.country = country) ;

select country, avg(creditLimit)
from customers group by country;