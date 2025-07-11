-- Queries using single table
/*
  Name: MySQL Sample Database classicmodels
  Link: http://www.mysqltutorial.org/mysql-sample-database.aspx
*/

-- Retrieve total number of orders.
select count(*) as totalOrders from orders;

-- Retrieve total number of orders per customer.
select customerNumber, count(*) as totalOrders from orders group by customerNumber;

-- Retrieve total number of orders per status.
select status, count(*) as totalOrders from orders group by status;

-- Retrieve total number of orders per order date.
select orderDate, count(*) as totalOrders from orders group by orderDate;

-- Retrieve the earliest order date.
select min(orderDate) as oldestDate from orders;

-- Retrieve latest order date.
select max(orderDate) as latestDate from orders;

-- Retrieve total number of orders per year.
select year(orderDate) as orderYear, count(*) as totalOrders from orders group by year(orderDate);

-- Retrieve total number of orders per month.
select month(orderDate) as orderMonth, count(*) as totalOrders from orders group by month(orderDate);

-- Retrieve total number of orders per day of the week.
select dayofweek(orderDate), count(*) as totalOrders from orders group by dayofweek(orderDate);

-- Retrieve total number of orders per quarter.
select quarter(orderDate), count(*) from orders group by quarter(orderDate);

-- Retrieve total number of orders per customer and status. Sort by Customer number.
select customerNumber, status, count(*) as totalOrders
from orders
group by customerNumber, status
order by customerNumber asc;

-- Retrieve total number of orders per customer per year. Sort by customer number.
select customerNumber, year(orderDate) as orderedYear, count(*) as totalOrders
from orders
group by customerNumber, year(orderDate)
order by customerNumber;

-- Retrieve the total number of orders for the first 10 even weeks.
select week(orderDate) as orderWeek, count(*) as totalOrders
from orders 
where mod(week(orderDate), 2) = 0
group by week(orderDate)
-- having mod(orderWeek, 2) = 0
order by week(orderDate) asc 
limit 10;

-- Retrieve total number of orders per status per year. Sort by status.
select status, year(orderDate) as orderedYear, count(*) as totalOrders
from orders
group by status, year(orderDate)
order by status asc;

-- Retrieve total number of orders per customer per year and quarter for the year of 2004 and 2005.
select customerNumber, year(orderDate) as orderedYear, 
		quarter(orderDate) as orderedQuarterYear, count(*) as totalOrders
from orders
group by customerNumber, orderedYear, orderedQuarterYear
having orderedYear in (2004, 2005);


-- Retrieve the top 5 longest customer names along with their lengths.
select customerName, length(customerName) as lengthOfName
from customers
order by lengthOfName desc;

-- Extract the first 5 characters of customer names and convert to uppercase.
select upper(substr(customerName, 1, 5)) as firstFiveChar
from customers;

-- Replace 'Ltd' with 'Limited' in customer names and 
-- display only those modified customer names.
select replace(customerName, 'Ltd', 'Limited') 
from customers
where customerName like '%Ltd%';

-- Round the credit limit to the nearest thousand and 
-- display the customer name along with the rounded credit limit.
select customerName, round(creditLimit, -3) as roundedCreditLlimit
from customers; 