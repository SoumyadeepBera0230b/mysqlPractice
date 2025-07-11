-- Queries using Inner Join
/*
  Name: MySQL Sample Database classicmodels
  Link: http://www.mysqltutorial.org/mysql-sample-database.aspx
*/
-- Retrieve the order numbers and customer names for all orders.
select orderNumber, customerName 
from orders as ord
join customers as cust
on ord.customerNumber = cust.customerNumber;
-- Retrieve the order numbers and product names for all orders.
select ord.orderNumber, prod.productName
from products as prod
join orderdetails as ord
on prod.productCode = ord.productCode;
-- Retrieve the order numbers and the first and last names of the employees who managed them.
select ord.orderNumber, emp.firstName, emp.lastName
from employees as emp
join customers as cust
on emp.employeeNumber = cust.salesRepEmployeeNumber
join orders as ord
on cust.customerNumber = ord.customerNumber;
-- Retrieve the names of all customers and their sales representatives, displaying the customer name, and the sales representative's first and last name.
select cust.customerName, emp.firstName, emp.lastName
from customers cust
inner join employees as emp
on cust.salesRepEmployeeNumber = emp.employeeNumber;
-- Retrieve the product names and their respective order quantities, displaying the product name and quantity ordered.
select prod.productName, ord.quantityOrdered
from orderdetails as ord
join products as prod
on ord.productCode = prod.productCode;
-- Retrieve the order numbers and their respective total prices.
select ord.orderNumber, sum(ord.quantityOrdered*ord.priceEach) as totalPrice
from orderdetails as ord
join products prod
on ord.productCode = prod.productCode
group by ord.orderNumber;
-- Retrieve the names of all customers with their order numbers and order dates.
select cust.customerName, ord.orderNumber, ord.orderDate
from customers as cust
join orders as ord
on cust.customerNumber = ord.customerNumber;

-- Retrieve the first and last names of all employees with their office locations.
select emp.firstName, emp.lastName, offices.city
from employees emp
join offices
on emp.officeCode = offices.officeCode;
-- Retrieve the order numbers, statuses, and customer names for all orders.
select orders.orderNumber, orders.status, cust.customerName
from orders
join customers cust
on orders.customerNumber = cust.customerNumber;
-- Retrieve the names of all customers and their total number of orders.
select cust.customerName, count(ord.orderNumber)
from customers cust
join orders ord
on ord.customerNumber = cust.customerNumber
group by cust.customerName;
-- Retrieve the names of all products and their total quantities ordered.
select prod.productName, sum(ord.quantityOrdered) as totalOrdered
from products prod
join orderdetails ord
on prod.productCode = ord.productCode
group by ord.productCode;
-- List all employees with the total number of customers they handle. 
-- Retrieve employee first name, last name and total number of customers handled by them.
select employees.firstName, employees.lastName, count(cust.customerNumber) as totalCustomers
from employees
join customers cust
on employees.employeeNumber = cust.salesRepEmployeeNumber
group by employees.employeeNumber;
-- Retrieve the order numbers and their respective total prices.
select orders.orderNumber, sum(orderdetails.quantityOrdered*orderdetails.priceEach) as totalPrice
from orderdetails
inner join orders
on orders.orderNumber = orderdetails.orderNumber
group by orders.orderNumber;
-- Retrieve the names of all customers and their total sales amounts.
select customers.customerName, sum(orderdetails.quantityOrdered*orderdetails.priceEach) as totalSales
from customers 
join orders
on customers.customerNumber = orders.customerNumber
join orderdetails
on orders.orderNumber = orderdetails.orderNumber
group by customers.customerNumber;

-- Retrieve the first and last names of all employees and their total sales amounts.
select emp.firstName, emp.lastName, sum(orderdetails.quantityOrdered*orderdetails.priceEach) as totalSales
from employees emp
join customers
on emp.employeeNumber = customers.salesRepEmployeeNumber
join orders
on orders.customerNumber = customers.customerNumber
join orderdetails
on orders.orderNumber = orderdetails.orderNumber
group by emp.employeeNumber;
-- Retrieve the customer numbers, names, and total sales amounts for customers with sales above $10,000.
select customers.customerNumber, customers.customerName, sum(payments.amount) as totalSales
from customers
join payments
on customers.customerNumber = payments.customerNumber
group by customers.customerNumber
having totalSales > 10000;
-- Retrieve the customer numbers, names, and average sales values for customers 
-- with an average order value exceeding $3500.
select customers.customerNumber, customers.customerName, avg(quantityOrdered*priceEach) as averageSales
from customers
join orders
on customers.customerNumber = orders.customerNumber
join orderdetails
on orders.orderNumber = orderdetails.orderNumber
group by customers.customerNumber
having averageSales > 3500;
-- Retrieve the customer numbers, names, and total number of orders for customers with more than 5 orders.
select customers.customerNumber, customers.customerName, count(orders.orderNumber) as totalOrders
from customers
join orders
on customers.customerNumber = orders.customerNumber
group by orders.customerNumber
having totalOrders > 5;
-- Retrieve the product codes, names, and total sales for products with sales above $1,80,000.
select orderdetails.productCode, products.productName, sum(quantityOrdered*priceEach) as totalSales
from products
join orderdetails
on products.productCode = orderdetails.productCode
group by orderdetails.productCode
having totalSales > 180000;

-- Retrieve the product codes, names, and average quantities ordered for products with an average above 30.
select products.productCode, products.productName, avg(orderdetails.quantityOrdered) as avgQuantity
from products
join orderdetails
on products.productCode = orderdetails.productCode
group by products.productCode
having avgQuantity > 30;
-- Retrieve the employee numbers, first and last names, and sales amounts for employees with sales above $500,000.
select employees.employeeNumber, employees.firstName, employees.lastName, sum(orderdetails.quantityOrdered*orderdetails.priceEach) as salesAmount
from employees
join customers
on employees.employeeNumber = customers.salesRepEmployeeNumber
join orders
on orders.customerNumber = customers.customerNumber
join orderdetails
on orders.orderNumber = orderdetails.orderNumber
group by employees.employeeNumber
having salesAmount > 500000;
-- Retrieve the year and total payment amount for payments exceeding $1,000,000.
select year(paymentDate), sum(payments.amount) as totalPayments
from payments
join customers
on payments.customerNumber = customers.customerNumber
group by year(payments.paymentDate)
having totalPayments > 1000000;
-- Retrieve the year and average order value for years 
-- where the average order value exceeds $1,000.
select year(orderDate) as orderedYear, round(avg(quantityOrdered*priceEach), 2) as averageOrders
from orders
join orderdetails
on orders.orderNumber = orderdetails.orderNumber
group by year(orderDate)
having averageOrders > 1000;
-- Retrieve the product line and total sales amount for product lines with total sales exceeding $200,000.
select pl.productLine, sum(quantityOrdered*priceEach) as totalSales
from productlines as pl
join products as p
on pl.productLine = p.productLine
join orderdetails od
on od.productCode = p.productCode
group by p.productLine
having totalSales > 200000;
-- Retrieve the country and total sales amount for countries with total sales exceeding $500,000.
select c.country,  sum(quantityOrdered*priceEach) as totalSales
from customers c
join orders as o
on c.customerNumber = o.customerNumber
join orderdetails as od
on od.orderNumber = o.orderNumber
group by c.country
having totalSales > 500000;
-- Retrieve the office name and sales amount for offices (cities) with total sales exceeding $300,000.
select o.city, sum(ordd.quantityOrdered*ordd.priceEach) as totalSales
from offices o
join employees e
on e.officeCode = o.officeCode
join customers c
on c.salesRepEmployeeNumber = e.employeeNumber
join orders ord
on ord.customerNumber = c.customerNumber
join orderdetails ordd
on ordd.orderNumber = ord.orderNumber
group by o.city
having totalSales > 300000;

-- Queries using Left Join
-- Retrieve the names of all customers along with their order numbers,
--  even if they have no orders.
select c.customerName, o.orderNumber
from customers c
left join orders as o
on c.customerNumber = o.customerNumber;
-- Retrieve the names of all products along with their order quantities, even if there are no orders.
select p.productName, (od.quantityOrdered)
from products p
left join orderdetails od
on p.productCode = od.productCode;
-- Retrieve the first and last names of all employees along with the names of the customers they handle, 
-- even if they have no customers.
select e.firstName, e.lastName, c.customerName
from employees as e
left join customers as c
on e.employeeNumber = c.salesRepEmployeeNumber;
-- Retrieve the names of all customers along with their sales representatives (employee), even if they have no sales representative. Display the customer’s name, and the sales representative's first and last name.
select c.customerName, e.firstName, e.lastName
from customers c
left join employees e
on c.salesRepEmployeeNumber = e.employeeNumber;
-- Retrieve the names of all customers along with their order statuses, 
-- even if they have no orders.
select c.customerName, o.status
from customers c
left join orders o
on c.customerNumber = o.customerNumber;