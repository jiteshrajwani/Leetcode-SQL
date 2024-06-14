create database leetcode;
use leetcode;

Create table If Not Exists Employees(employee_id int, name varchar(20), reports_to int, age int);
insert into Employees (employee_id, name, reports_to, age) values ('9', 'Hercy', Null, '43');
insert into Employees (employee_id, name, reports_to, age) values ('6', 'Alice', '9', '41');
insert into Employees (employee_id, name, reports_to, age) values ('4', 'Bob', '9', '36');
insert into Employees (employee_id, name, reports_to, age) values ('2', 'Winston', Null, '37');

select * from employees;

/* For this problem, we will consider a manager an employee who has at least 1 other employee reporting to them.
Write a solution to report the ids and the names of all managers, the number of employees who report directly to them, 
and the average age of the reports rounded to the nearest integer.
Return the result table ordered by employee_id.
The result format is in the following example.
*/
 
 select e.employee_id,e.name,count(e1.employee_id) reports_count,round(avg(e1.age)) average_age
 from employees as e 
 join employees as e1 
 on e.employee_id = e1.reports_to
 group by 1,2;
 
select * from employees; 

select *
from employees as e 
join employees as e1 
on e.employee_id = e1.reports_to;

-------------------------------------------------------------------------

Create table If Not Exists Employee (employee_id int, department_id int, primary_flag ENUM('Y','N'));
Truncate table Employee;
insert into Employee (employee_id, department_id, primary_flag) values ('1', '1', 'N');
insert into Employee (employee_id, department_id, primary_flag) values ('2', '1', 'Y');
insert into Employee (employee_id, department_id, primary_flag) values ('2', '2', 'N');
insert into Employee (employee_id, department_id, primary_flag) values ('3', '3', 'N');
insert into Employee (employee_id, department_id, primary_flag) values ('4', '2', 'N');
insert into Employee (employee_id, department_id, primary_flag) values ('4', '3', 'Y');
insert into Employee (employee_id, department_id, primary_flag) values ('4', '4', 'N');





/*Employees can belong to multiple departments. When the employee joins other departments, they need to decide which department is their primary department.
Note that when an employee belongs to only one department, their primary column is 'N'.
Write a solution to report all the employees with their primary department. For employees who belong to one department, report their only department.
Return the result table in any order.*/


select employee_id,department_id from employee where employee_id in (
select employee_id
from employee
group by 1
having count(*)=1)
union
select employee_id,department_id 
from employee
where primary_flag = 'Y';

-------------------------------------------------------------

create table if not exists triangle (
x int,
y int,
z int);

insert into triangle 
(x,y,z)
values 
(13,15,30),
(10,20,15);

/*Report for every three line segments whether they can form a triangle.
Return the result table in any order.
The result format is in the following example.*/

select *,(case when x+y>z and x+z>y and y+z>x then 'Yes' else 'No' end)as triangle  from triangle;

--------------------------------------------------

Create table If Not Exists Logs (id int, num int);
Truncate table Logs;
insert into Logs (id, num) values ('1', '1');
insert into Logs (id, num) values ('2', '1');
insert into Logs (id, num) values ('3', '1');
insert into Logs (id, num) values ('4', '2');
insert into Logs (id, num) values ('5', '1');
insert into Logs (id, num) values ('6', '2');
insert into Logs (id, num) values ('7', '2');

select * from logs;

select num from (
select *,lead(num) over()lead1, lead(num,2) over()lead2 from logs)t
where num =lead1=lead2;

truncate table logs;

insert into logs
values 
(1,1),(2,0),(3,0),(4,0);
select id,num from (
select *,lead(num) over()lead1, lead(num,2) over()lead2 from logs)t
where num=lead1 and num=lead2;



INSERT INTO logs (id, num)
VALUES
    (4, 2),
    (5, 1),
    (6, 2),
    (1, 1),
    (3, 1),
    (7, 2),
    (2, 1);
select * from logs order by id;



--------------------------------------------------

Create table If Not Exists Products (product_id int, new_price int, change_date date);
Truncate table Products;
insert into Products (product_id, new_price, change_date) values ('1', '20', '2019-08-14');
insert into Products (product_id, new_price, change_date) values ('2', '50', '2019-08-14');
insert into Products (product_id, new_price, change_date) values ('1', '30', '2019-08-15');
insert into Products (product_id, new_price, change_date) values ('1', '35', '2019-08-16');
insert into Products (product_id, new_price, change_date) values ('2', '65', '2019-08-17');
insert into Products (product_id, new_price, change_date) values ('3', '20', '2019-08-18');

/*Write a solution to find the prices of all products on 2019-08-16. Assume the price of all products before any change is 10.
Return the result table in any order.*/

select product_id,new_price from (
select  *,max(change_date) over(partition by product_id)new_ from products)t
where change_date = new_;

----------------------------------------------------

drop table employees;
Create table If Not Exists Employees (employee_id int, name varchar(20), manager_id int, salary int);
Truncate table Employees;
insert into Employees (employee_id, name, manager_id, salary) values ('3', 'Mila', '9', '60301');
insert into Employees (employee_id, name, manager_id, salary) values ('12', 'Antonella', null, '31000');
insert into Employees (employee_id, name, manager_id, salary) values ('13', 'Emery', null, '67084');
insert into Employees (employee_id, name, manager_id, salary) values ('1', 'Kalel', '11', '21241');
insert into Employees (employee_id, name, manager_id, salary) values ('9', 'Mikaela',null, '50937');
insert into Employees (employee_id, name, manager_id, salary) values ('11', 'Joziah', '6', '28485');

/*Find the IDs of the employees whose salary is strictly less than $30000 and whose manager left the company.
When a manager leaves the company, their information is deleted from the Employees table,
but the reports still have their manager_id set to the manager that left.
Return the result table ordered by employee_id.*/


select * from employees where salary < 30000 
and manager_id not in (select employee_id from employees);

---------------------------------------------

Create table If Not Exists Seat (id int, student varchar(255));
Truncate table Seat;

insert into seat 
(id,student)
values
(1,'Abbot'),(2,'Dorris'),(3,'Green'),(4,'Emerson'),(5,'Jeames');

select * from seat;

/*Write a solution to swap the seat id of every two consecutive students. If the number of students is odd,
the id of the last student is not swapped.
Return the result table ordered by id in ascending order.*/


-------------------------------------------------------------------------------------


Create table If Not Exists Movies (movie_id int, title varchar(30));
Create table If Not Exists Users (user_id int, name varchar(30));
Create table If Not Exists MovieRating (movie_id int, user_id int, rating int, created_at date);
Truncate table Movies;
insert into Movies (movie_id, title) values ('1', 'Avengers');
insert into Movies (movie_id, title) values ('2', 'Frozen 2');
insert into Movies (movie_id, title) values ('3', 'Joker');
Truncate table Users;
insert into Users (user_id, name) values ('1', 'Daniel');
insert into Users (user_id, name) values ('2', 'Monica');
insert into Users (user_id, name) values ('3', 'Maria');
insert into Users (user_id, name) values ('4', 'James');
Truncate table MovieRating;
insert into MovieRating (movie_id, user_id, rating, created_at) values ('1', '1', '3', '2020-01-12');
insert into MovieRating (movie_id, user_id, rating, created_at) values ('1', '2', '4', '2020-02-11');
insert into MovieRating (movie_id, user_id, rating, created_at) values ('1', '3', '2', '2020-02-12');
insert into MovieRating (movie_id, user_id, rating, created_at) values ('1', '4', '1', '2020-01-01');
insert into MovieRating (movie_id, user_id, rating, created_at) values ('2', '1', '5', '2020-02-17');
insert into MovieRating (movie_id, user_id, rating, created_at) values ('2', '2', '2', '2020-02-01');
insert into MovieRating (movie_id, user_id, rating, created_at) values ('2', '3', '2', '2020-03-01');
insert into MovieRating (movie_id, user_id, rating, created_at) values ('3', '1', '3', '2020-02-22');
insert into MovieRating (movie_id, user_id, rating, created_at) values ('3', '2', '4', '2020-02-25');

/*Write a solution to:

Find the name of the user who has rated the greatest number of movies. In case of a tie, return the lexicographically smaller user name.
Find the movie name with the highest average rating in February 2020. In case of a tie, return the lexicographically smaller movie name.*/
-- Tables available are MovieRating,users,Movies;

select * from MovieRating;
select * from movies;

select title from (
select mr.movie_id,ms.title,avg(rating) 
from movierating as mr 
left join movies as ms 
on ms.movie_id = mr.movie_id
where year(created_at)=2020 and month(created_at)=2
group by 1,2
order by avg(rating) desc,title)t
limit 1;


	(select name as results from (
	select us.user_id,name,count(rating) from users as us 
	left join movierating as mr 
	on mr.user_id = us.user_id
	group by us.user_id,name
	order by count(rating) desc,name limit 1)t)
	union
	(select title from (
	select mr.movie_id,ms.title,avg(rating) 
	from movierating as mr 
	left join movies as ms 
	on ms.movie_id = mr.movie_id
	where year(created_at)=2020 and month(created_at)=2
	group by 1,2
	order by avg(rating) desc,title)t
	limit 1);

-----------------------------------------------------

Create table If Not Exists Customer (customer_id int, name varchar(20), visited_on date, amount int);
Truncate table Customer;
insert into Customer (customer_id, name, visited_on, amount) values ('1', 'Jhon', '2019-01-01', '100');
insert into Customer (customer_id, name, visited_on, amount) values ('2', 'Daniel', '2019-01-02', '110');
insert into Customer (customer_id, name, visited_on, amount) values ('3', 'Jade', '2019-01-03', '120');
insert into Customer (customer_id, name, visited_on, amount) values ('4', 'Khaled', '2019-01-04', '130');
insert into Customer (customer_id, name, visited_on, amount) values ('5', 'Winston', '2019-01-05', '110');
insert into Customer (customer_id, name, visited_on, amount) values ('6', 'Elvis', '2019-01-06', '140');
insert into Customer (customer_id, name, visited_on, amount) values ('7', 'Anna', '2019-01-07', '150');
insert into Customer (customer_id, name, visited_on, amount) values ('8', 'Maria', '2019-01-08', '80');
insert into Customer (customer_id, name, visited_on, amount) values ('9', 'Jaze', '2019-01-09', '110');
insert into Customer (customer_id, name, visited_on, amount) values ('1', 'Jhon', '2019-01-10', '130');
insert into Customer (customer_id, name, visited_on, amount) values ('3', 'Jade', '2019-01-10', '150');

/*You are the restaurant owner and you want to analyze a possible expansion (there will be at least one customer every day).
Compute the moving average of how much the customer paid in a seven days window (i.e., current day + 6 days before).
 average_amount should be rounded to two decimal places.
Return the result table ordered by visited_on in ascending order.*/

select * from customer;

select *,lag(visited_on,6) over() from customer;


-------------------------------------------------------

Create table If Not Exists RequestAccepted (requester_id int not null, accepter_id int null, accept_date date null);
Truncate table RequestAccepted;
insert into RequestAccepted (requester_id, accepter_id, accept_date) values ('1', '2', '2016/06/03');
insert into RequestAccepted (requester_id, accepter_id, accept_date) values ('1', '3', '2016/06/08');
insert into RequestAccepted (requester_id, accepter_id, accept_date) values ('2', '3', '2016/06/08');
insert into RequestAccepted (requester_id, accepter_id, accept_date) values ('3', '4', '2016/06/09');

select * from requestaccepted;




-------------------------------------------------------------------------------------

use leetcode;

Create table If Not Exists Sales (sale_id int, product_id int, year int, quantity int, price int);
Create table If Not Exists Product (product_id int, product_name varchar(10));
Truncate table Sales;
insert into Sales (sale_id, product_id, year, quantity, price) values ('1', '100', '2008', '10', '5000');
insert into Sales (sale_id, product_id, year, quantity, price) values ('2', '100', '2009', '12', '5000');
insert into Sales (sale_id, product_id, year, quantity, price) values ('7', '200', '2011', '15', '9000');

insert into product 
values 
('100','Nokia'),
('200','Apple'),
('300','Samsung');

select * from sales;

select product_id,year as first_year,quantity,price from (
select *,rank() over(partition by product_id order by year)rank_ from sales)t
where rank_=1;


-----------------------------------------------------------

drop table customer;
drop table product;
Create table If Not Exists Customer (customer_id int, product_key int);
Create table Product (product_key int);
Truncate table Customer;
insert into Customer (customer_id, product_key) values ('1', '5');
insert into Customer (customer_id, product_key) values ('2', '6');
insert into Customer (customer_id, product_key) values ('3', '5');
insert into Customer (customer_id, product_key) values ('3', '6');
insert into Customer (customer_id, product_key) values ('1', '6');
Truncate table Product;
insert into Product (product_key) values ('5');
insert into Product (product_key) values ('6');

/*Write a solution to report the customer ids from the Customer table that bought all the products in the Product table.
Return the result table in any order.*/

with temp as (
select customer_id,count(p.product_key) as uniq
from customer as c
right join product as p 
on p.product_key = c.product_key
group by customer_id
having uniq = (select count(*) from product))
select customer_id from temp;


-- Falied in the 5th testcase so let's try some other query.
select customer_id 
from customer 
group by customer_id 
having count(distinct product_key) =(select count(*) from product);


---------------------------------------------------

Create table If Not Exists Accounts (account_id int, income int);
Truncate table Accounts;
insert into Accounts (account_id, income) values ('3', '108939');
insert into Accounts (account_id, income) values ('2', '12747');
insert into Accounts (account_id, income) values ('8', '87709');
insert into Accounts (account_id, income) values ('6', '91796');

/*Write a solution to calculate the number of bank accounts for each salary category. The salary categories are:

"Low Salary": All the salaries strictly less than $20000.
"Average Salary": All the salaries in the inclusive range [$20000, $50000].
"High Salary": All the salaries strictly greater than $50000.
The result table must contain all three categories. If there are no accounts in a category, return 0.*/
select * from accounts;
with temp as (
select *,case when income <20000 then 'Low Salary' when income between 20000 and  50000 then 'Average Salary'
		when income >50000 then 'High Salary'  end as category from accounts)
        select category,count(*	) from temp 
        group by 1;
	
----------------------------------------------------------

create table candidates (
candidate_key int,
skill varchar(25)
);

insert into candidates
(candidate_key,skill)
values
(123,'Python'),
(123,'Tableau'),
(123,'PostgreSQL'),
(234,'R'),
(234,'PowerBI'),
(234,'SQl Server'),
(345,'Python'),
(345,'Tableau');

/*Given a table of candidates and their skills, you're tasked with finding the candidates best suited for an open Data Science job.
You want to find candidates who are proficient in Python, Tableau, and PostgreSQL.
Write a query to list the candidates who possess all of the required skills for the job. Sort the output by candidate ID in ascending order.*/

select candidate_key from candidates where skill in ('Python','Tableau','PostgreSQl')
group by candidate_key
having count(*)=3;


----------------------------------------

create table product_spend (
category varchar(25),
product varchar(25),
user_id int,
spend decimal(6,2),
transaction_date timestamp
);

insert into product_spend
values
('appliance','refrigerator',165,246.00,current_timestamp());

set sql_safe_updates=0;

update product_spend
set transaction_date = '2021-12-26 12:00:00';

insert into product_spend
values
('appliance','refrigerator',123,299.99,'2022-03-02 12:00:00'),
('appliance','washing machine',123,219.80,'2022-03-02 12:00:00'),
('electronics','vacuum',178,152.00,'2022-04-05 12:00:00'),
('electronics','wireless headset',156,249.00,'2022-07-08 12:00:00'),
('electronics','vacuum',145,189.00,'2022-07-15 12:00:00');

select * from product_spend;

/*Assume you're given a table containing data on Amazon customers and their spending on products in different category,
 write a query to identify the top two highest-grossing products within each category in the year 2022. 
The output should include the category, product, and total spend.*/

WITH ranked_spending_cte AS (
  SELECT 
    category, 
    product, 
    SUM(spend) AS total_spend,
    RANK() OVER (
      PARTITION BY category 
      ORDER BY SUM(spend) DESC) AS ranking 
  FROM product_spend
  WHERE EXTRACT(YEAR FROM transaction_date) = 2022
  GROUP BY category, product
)

SELECT 
  category, 
  product, 
  total_spend 
FROM ranked_spending_cte 
WHERE ranking in(1,2)
ORDER BY category,product;


--------------------------------------------------

use leetcode;

Create table If Not Exists Weather (id int, recordDate date, temperature int);
Truncate table Weather;

insert into weather
(id,recordDate,temperature)
values
(1,'2015-01-01',10),
(2,'2015-01-02',25),
(3,'2015-01-03',20),
(4,'2015-01-03',30);

/*Write a solution to find all dates' Id with higher temperatures compared to its previous dates (yesterday).
Return the result table in any order.*/

select * from weather;
select id from (
select *,temperature - lag(temperature) over()prev_temp from weather)t
where prev_temp>0;

truncate weather;

-- We will now solve this but with a different case where this query will not provide the desired results. So there is some inefficiency in this query.

insert into weather
values
(1,'2000-12-16',3),
(2,'2000-12-15',-1);

select * from weather;
select id from (
select *,lag(temperature) over(order by recordDate)prev_temp from weather)t
where temperature > prev_temp;

-- This query got another failed testcase so lets use that testcase now 

truncate weather;

insert into weather
values
(1,'2000-12-14',3),
(2,'2000-12-16',5);
select id from (
select *,datediff(recordDate,lag(recordDate) over(order by recordDate)) as prev_date,lag(temperature) over(order by recordDate)prev_temp from weather)t
where prev_date=1 and temperature > prev_temp;

-- Solved all the testcase with this above query 

----------------------------------------


Create table If Not Exists Activities (sell_date date, product varchar(20));
Truncate table Activities;
insert into Activities (sell_date, product) values ('2020-05-30', 'Headphone');
insert into Activities (sell_date, product) values ('2020-06-01', 'Pencil');
insert into Activities (sell_date, product) values ('2020-06-02', 'Mask');
insert into Activities (sell_date, product) values ('2020-05-30', 'Basketball');
insert into Activities (sell_date, product) values ('2020-06-01', 'Bible');
insert into Activities (sell_date, product) values ('2020-06-02', 'Mask');
insert into Activities (sell_date, product) values ('2020-05-30', 'T-Shirt');

select * from activities order by sell_date;

/*Write a solution to find for each date the number of different products sold and their names.
The sold products names for each date should be sorted lexicographically.
Return the result table ordered by sell_date. */
select * from activities;
select 
sell_date,count(distinct product)num_sold,group_concat(distinct product order by product) products
from activities
group by 1
order by sell_date;

select group_concat(product order by product separator '|') from activities group by sell_date;


-----------------------------------------------------------
drop table products;
drop table orders;
Create table If Not Exists Products (product_id int, product_name varchar(40), product_category varchar(40));
Create table If Not Exists Orders (product_id int, order_date date, unit int);
Truncate table Products;
insert into Products (product_id, product_name, product_category) values ('1', 'Leetcode Solutions', 'Book');
insert into Products (product_id, product_name, product_category) values ('2', 'Jewels of Stringology', 'Book');
insert into Products (product_id, product_name, product_category) values ('3', 'HP', 'Laptop');
insert into Products (product_id, product_name, product_category) values ('4', 'Lenovo', 'Laptop');
insert into Products (product_id, product_name, product_category) values ('5', 'Leetcode Kit', 'T-shirt');
Truncate table Orders;
insert into Orders (product_id, order_date, unit) values ('1', '2020-02-05', '60');
insert into Orders (product_id, order_date, unit) values ('1', '2020-02-10', '70');
insert into Orders (product_id, order_date, unit) values ('2', '2020-01-18', '30');
insert into Orders (product_id, order_date, unit) values ('2', '2020-02-11', '80');
insert into Orders (product_id, order_date, unit) values ('3', '2020-02-17', '2');
insert into Orders (product_id, order_date, unit) values ('3', '2020-02-24', '3');
insert into Orders (product_id, order_date, unit) values ('4', '2020-03-01', '20');
insert into Orders (product_id, order_date, unit) values ('4', '2020-03-04', '30');
insert into Orders (product_id, order_date, unit) values ('4', '2020-03-04', '60');
insert into Orders (product_id, order_date, unit) values ('5', '2020-02-25', '50');
insert into Orders (product_id, order_date, unit) values ('5', '2020-02-27', '50');
insert into Orders (product_id, order_date, unit) values ('5', '2020-03-01', '50');

/*Write a solution to get the names of products that have at least 100 units ordered in February 2020 and their amount.
Return the result table in any order.*/


select * from products;
select * from orders;

select product_name,sum(unit) as unit
from products as p 
join orders as o 
using(product_id)
where month(order_date)=2 and year(order_date)=2020
group by product_name
having sum(unit)>=100;

---------------------------------------------
drop table users;
Create table If Not Exists Users (user_id int, name varchar(30), mail varchar(50));
Truncate table Users;
insert into Users (user_id, name, mail) values ('1', 'Winston', 'winston@leetcode.com');
insert into Users (user_id, name, mail) values ('2', 'Jonathan', 'jonathanisgreat');
insert into Users (user_id, name, mail) values ('3', 'Annabelle', 'bella-@leetcode.com');
insert into Users (user_id, name, mail) values ('4', 'Sally', 'sally.come@leetcode.com');
insert into Users (user_id, name, mail) values ('5', 'Marwan', 'quarz#2020@leetcode.com');
insert into Users (user_id, name, mail) values ('6', 'David', 'david69@gmail.com');
insert into Users (user_id, name, mail) values ('7', 'Shapiro', '.shapo@leetcode.com');
select * from users;

/*Write a solution to find the users who have valid emails.
A valid e-mail has a prefix name and a domain where:
The prefix name is a string that may contain letters (upper or lower case),
digits, underscore '_', period '.',
and/or dash '-'. The prefix name must start with a letter.
The domain is '@leetcode.com'.
Return the result table in any order.*/

SELECT *
FROM users
WHERE mail REGEXP '^[a-zA-Z][a-zA-Z0-9._-]*@leetcode\\.com$';



-------------------------------------------------------------------

-- From here onwards I am tring Hackerank

use leetcode;

create table hacker (
hacker_id int,
name varchar(25)
); 

create table challenges (challenge_id int, hacker_id int);

insert into hacker
values
(5077,'Rose'),
(21283,'Angela'),
(62743,'Frank'),
(88255,'Patrick'),
(96196,'Lisa');

insert into 
challenges 
values 
(61654,5077),
(58302,21283),
(40587,88255),
(29477,5077),
(1220,21283),
(69514,21283),
(46561,62743),
(58077,62743),
(18483,88255),
(76766,21283),
(52382,5077),
(74467,21283),
(33625,96196),
(26053,88255),
(42665,62743),
(12859,62743),
(70094,21283),
(34599,88255),
(54680,88255),
(61881,5077);

/*Julia asked her students to create some coding challenges. Write a query to print the hacker_id, name, 
and the total number of challenges created by each student. Sort your results by the 
total number of challenges in descending order. If more than one student created the same number of challenges, 
then sort the result by hacker_id. If more than one student created the same number of challenges and 
the count is less than the maximum number of challenges created, then exclude those students from the result.*/

rename table hacker to hackers;

select h.hacker_id,h.name,count(c.challenge_id) challenges_created
from challenges as c 
join hackers as h 
on h.hacker_id = c.hacker_id
group by 1,2
having challenges_created not in (
	select * from (
	select count(*) as cc 
	from challenges 
	group by hacker_id
	order by count(*) desc)t
	group by cc
	having count(*)>1)
or challenges_created in (
select max(cc)
from (
select count(*) as cc
from challenges
group by hacker_id)t)
order by challenges_created desc,hacker_id;


--------------------------------------------------------------------
truncate table hackers;

INSERT INTO hackers (hacker_id, name) VALUES (4071, 'Rose');
INSERT INTO hackers (hacker_id, name) VALUES (4806, 'Angela');
INSERT INTO hackers (hacker_id, name) VALUES (26071, 'Frank');
INSERT INTO hackers (hacker_id, name) VALUES (49438, 'Patrick');
INSERT INTO hackers (hacker_id, name) VALUES (74842, 'Lisa');
INSERT INTO hackers (hacker_id, name) VALUES (80305, 'Kimberly');
INSERT INTO hackers (hacker_id, name) VALUES (84072, 'Bonnie');
INSERT INTO hackers (hacker_id, name) VALUES (87868, 'Michael');
INSERT INTO hackers (hacker_id, name) VALUES (92118, 'Todd');
INSERT INTO hackers (hacker_id, name) VALUES (95895, 'Joe');

select * from hackers;

CREATE TABLE submissions (
    submission_id INT PRIMARY KEY,
    hacker_id INT,
    challenge_id INT,
    score INT
);

-- Insert multiple rows into the submissions table
INSERT INTO submissions (submission_id, hacker_id, challenge_id, score) VALUES
(67194, 74842, 63132, 76),
(64479, 74842, 19797, 98),
(40742, 26071, 49593, 20),
(17513, 4806, 49593, 32),
(69846, 80305, 19797, 19),
(41002, 26071, 89343, 36),
(52826, 49438, 49593, 9),
(31093, 26071, 19797, 2),
(81614, 84072, 49593, 100),
(44829, 26071, 89343, 17),
(75147, 80305, 49593, 48),
(14115, 4806, 49593, 76),
(6943, 4071, 19797, 95),
(12855, 4806, 25917, 13),
(73343, 80305, 49593, 42),
(84264, 84072, 63132, 0),
(9951, 4071, 49593, 43),
(45104, 49438, 25917, 34),
(53795, 74842, 19797, 5),
(26363, 26071, 19797, 29),
(10063, 4071, 49593, 96);

/*The total score of a hacker is the sum of their maximum scores for all of the challenges. 
Write a query to print the hacker_id, name, and total score of the hackers ordered by the descending score. 
If more than one hacker achieved the same total score, then sort the result by ascending hacker_id.
Exclude all hackers with a total score of  from your result.*/

select * 
from submissions
where hacker_id = 74842;



select hacker_id,name,sum(max_) sum_ from (
select s.hacker_id,name,challenge_id,max(score) as max_
from submissions as s
join hackers as h 
on h.hacker_id = s.hacker_id
group by 1,2,3
having max_ !=0
order by max_ desc)t
group by 1,2
order by sum_ desc,hacker_id;



