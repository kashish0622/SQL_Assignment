CREATE DATABASE ecommerce;
USE ecommerce;
CREATE TABLE gold_member_users (
    userid VARCHAR(50),
    signup_date DATE
);

CREATE TABLE users (
    userid VARCHAR(50),
    signup_date DATE
);

CREATE TABLE sales (
    userid VARCHAR(50),
    created_date DATE,
    product_id INT
);

CREATE TABLE product (
    product_id INT,
    product_name VARCHAR(50),
    price INT
);

INSERT INTO gold_member_users VALUES
('John','2017-09-22'),
('Mary','2017-04-21');

INSERT INTO users VALUES
('John','2014-09-02'),
('Michel','2015-01-15'),
('Mary','2014-04-11');

INSERT INTO sales VALUES
('John','2017-04-19',2),
('Mary','2019-12-18',1),
('Michel','2020-07-20',3),
('John','2019-10-23',2),
('John','2018-03-19',3),
('Mary','2016-12-20',2),
('John','2016-11-09',1),
('John','2016-05-20',3),
('Michel','2017-09-24',1),
('John','2017-03-11',2),
('John','2016-03-11',1),
('Mary','2016-11-10',1),
('Mary','2017-12-07',2);

INSERT INTO product VALUES
(1,'Mobile',980),
(2,'Ipad',870),
(3,'Laptop',330);

SHOW TABLES;

SELECT
 (SELECT COUNT(*) FROM gold_member_users) AS gold_count,
 (SELECT COUNT(*) FROM users) AS user_count,
 (SELECT COUNT(*) FROM sales) AS sales_count,
 (SELECT COUNT(*) FROM product) AS product_count;
 
SELECT s.userid,
SUM(p.price) AS total_spent
FROM sales AS s
JOIN product AS p 
ON s.product_id = p.product_id
GROUP BY s.userid;

SELECT DISTINCT created_date AS date,
userid AS customer_name
FROM sales
ORDER BY userid;

SELECT s.userid,
p.product_name
FROM sales AS s
JOIN product AS p 
ON s.product_id = p.product_id
WHERE (s.userid, s.created_date) IN
(
   SELECT userid, MIN(created_date)
   FROM sales
   GROUP BY userid
);

SELECT userid,
COUNT(product_id) AS item_count
FROM sales
GROUP BY userid
ORDER BY item_count DESC;

SELECT userid
FROM users
WHERE userid NOT IN
(SELECT userid FROM gold_member_users);

SELECT s.userid,
SUM(p.price) AS gold_spent
FROM sales AS s
JOIN product AS p 
ON s.product_id = p.product_id
JOIN gold_member_users AS g
ON s.userid = g.userid
WHERE s.created_date >= g.signup_date
GROUP BY s.userid
ORDER BY s.userid;

SELECT userid
FROM users
WHERE userid LIKE 'M%';

SELECT DISTINCT userid
FROM users;

ALTER TABLE product
RENAME COLUMN price TO price_value;
SELECT *FROM product;

SET SQL_SAFE_UPDATES=0;
UPDATE product
SET product_name = 'Iphone'
WHERE product_name = 'Ipad';
SELECT *FROM product;

RENAME TABLE gold_member_users TO gold_membership_users;
SHOW TABLES;
ALTER TABLE gold_membership_users
ADD status VARCHAR(10);
SELECT *FROM gold_membership_users;

START TRANSACTION;

DELETE FROM users WHERE userid='John';
ROLLBACK;

SELECT *FROM users;

INSERT INTO product VALUES (3,'Laptop',330);
SELECT *FROM product;

SELECT product_id, product_name, price_value, COUNT(*)
FROM product
GROUP BY product_id, product_name, price_value
HAVING COUNT(*) > 1;