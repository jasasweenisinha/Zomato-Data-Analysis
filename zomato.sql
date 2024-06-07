CREATE DATABASE Zomato;

USE Zomato;

CREATE TABLE goldusers_signup(
userid INT,
gold_signup_date DATE);

INSERT INTO goldusers_signup
(userid, gold_signup_date)

VALUES
(1, '2017-09-22'),
(3, '2017-04-21');

SELECT * FROM goldusers_signup;

CREATE TABLE users(
userid INT,
signup_date DATE
);

INSERT INTO users
(userid, signup_date)

VALUES
(1, '2014-09-02'),
(2, '2015-01-15'),
(3, '2014-11-04');

SELECT * FROM users;

CREATE TABLE sales(
userid INT,
created_date DATE,
product_id INT
);

INSERT INTO sales
(userid, created_date, product_id )

VALUES
(1, '2017-04-19', 2),
(3, '2019-12-18', 1),
(2, '2020-07-20', 3),
(1, '2019-10-23', 2),
(1, '2018-03-19', 3),
(3, '2016-12-20', 2),
(1, '2016-11-09', 1),
(1, '2016-05-20', 3),
(2, '2017-09-24', 1),
(1, '2017-03-11', 2),
(1, '2016-03-11', 1),
(3, '2016-11-10', 1),
(3, '2017-12-07', 2),
(3, '2016-12-15', 2),
(2, '2017-11-08', 2),
(2, '2018-09-10', 3);

SELECT * FROM sales;

CREATE TABLE product(
product_id INT,
product_name VARCHAR(50),
price INT
);

INSERT INTO product
(product_id, product_name, price)

VALUES
(1, 'p1', 980),
(2, 'p2', 870),
(3, 'p3', 330);

SELECT * FROM product;

-- 1. What is the total amount each users spent on Zomato ?

SELECT userid, SUM(p.price) AS Total_Amount
FROM
sales AS s
INNER JOIN
product AS p
ON s.product_id = p.product_id
GROUP BY s.userid;

-- 2. How many times each customer has visited Zomato to puchase the products ?

SELECT s.userid,
count(distinct s.created_date) AS Total_Days
FROM sales AS s
GROUP BY s.userid;

-- 3. What is the most purchased item on the menu ?

SELECT p.product_name, COUNT(s.product_id) AS Purchase_Count
FROM sales AS s
INNER JOIN product AS p 
ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY Purchase_Count DESC
LIMIT 1;

-- 4. What was the first product purchased by each customer ?

SELECT * FROM
(SELECT * , RANK() OVER(PARTITION BY userid 
ORDER BY created_date) rnk FROM sales) a
WHERE rnk = 1;

-- 5. Which item was the most popular for each customer ?

SELECT userid , product_id , COUNT(product_id)
FROM sales 
GROUP BY userid , product_id;

-- 6. Which item was purchased first by the customer after they became a member ?

SELECT a.userid, a.created_date, a.product_id, b.gold_signup_date 
FROM sales a
INNER JOIN
goldusers_signup b
ON 
a.userid = b.userid
AND
created_date > gold_signup_date;

-- 7. Rank all the transaction of the customers ?

SELECT * , RANK()
OVER(PARTITION BY userid ORDER BY created_date)
FROM sales;

















