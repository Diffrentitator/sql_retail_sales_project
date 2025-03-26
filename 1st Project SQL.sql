-- SQL Retail Sales Analysis - P1
CREATE DATABASE sql_project_p2;

-- create TABLE
DROP TABLE IF EXISTS Retail_sales;
Create TABLE Retail_sales
      (
        transactions_id INT PRIMARY KEY,
		sale_date DATE,
		sale_time TIME,
		customer_id INT,
		gender VARCHAR(15),
		age INT,
		category VARCHAR(15),
		quantiy INT,
		price_per_unit FLOAT,
		cogs FLOAT,
		total_sale FLOAT
      );

SELECT * FROM retail_sales
LIMIT 10

SELECT COUNT(*) FROM
retail_sales;


-- check for NULL

SELECT * FROM retail_sales
WHERE 
     age IS NULL
	 OR
	 category IS NULL
	 OR
	 quantiy IS NULL
	 OR
	 price_per_unit IS NULL 
	 OR 
	 cogs IS NULL
	 OR
	 total_sale IS NULL

-- Delete where values are null 

DELETE FROM retail_sales
WHERE
     age IS NULL
	 OR
	 category IS NULL
	 OR
	 quantiy IS NULL
	 OR
	 price_per_unit IS NULL 
	 OR 
	 cogs IS NULL
	 OR
	 total_sale IS NULL

-- DATA Exploaration

-- How many sales we have ?
Select COUNT(*) as total_sale From retail_sales

-- How many unique customers we have ?
SELECT COUNT(DISTINCT customer_id) as total_sale From retail_sales
 
--How many unique category we have ?
SELECT COUNT(DISTINCT category) From retail_sales

--Data analysis key problems, findings and solutions

-- Q1)Write a SQL query to retrieve all columns for sales made on '2022-11-05

SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05'

-- Q2) Write an SQL query to retrieve all transactions where the category is 'clothing' and the quantity sold is more than 10 in the month of nov-2022 

SELECT * 
FROM retail_sales 
WHERE category = 'Clothing'
AND quantiy >= 4
AND
TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'

-- Q3) Write an SQL query to calculate the total sales (total_sale)for each category.

Select category,
       SUM(total_sale) as net_sales, 
	   COUNT(*) as total_orders
	   FROM retail_sales
	   GROUP BY 1

-- Q4) Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category

SELECT ROUND (AVG(age), 2) as avg_age
FROM retail_sales
WHERE category = 'Beauty'

--Q5) Write an SQL query to find all transactions where the total_sale is greater than 1000

SELECT * 
FROM retail_sales
WHERE total_sale > 1000

--Q6) Write an SQL query to find total number of transactions (transaction_id) made by each gender in each category.

SELECT category,
       gender,
	   COUNT(*) as total_transactions
FROM retail_sales
Group BY 
       Category,
	   gender
ORDER BY 1

--Q7) Write an SQL query to calculate the average sale for each month. Find out best selling month each year
SELECT YEAR,
       MONTH,
	   avg_sale
 FROM
(
 SELECT 
      EXTRACT(YEAR FROM sale_date) as YEAR,
	  EXTRACT(MONTH FROM sale_date) as MONTH,
	  AVG(total_sale) as avg_sale,
	  RANK() OVER (PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as RANK
FROM retail_sales
GROUP BY 1, 2
) as t1
WHERE RANK = 1

--Q8 write an SQL Query to find out the top 5 customers based on the highest total sales

SELECT
      customer_id,
	  SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

--Q9) Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT
     category,
	 COUNT(DISTINCT customer_id) as unique_customers
	 FROM retail_sales
	 GROUP BY category

--Q10) Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)	 
WITH hourly_sale
AS
(
SELECT *,
    CASE 
	    WHEN EXTRACT( HOUR FROM sale_time) <= 12 THEN 'Morning'
		WHEN EXTRACT( HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
	END as Shift 
FROM retail_sales
)
SELECT 
    COUNT(*) as total_orders
	FROM hourly_sale
	GROUP BY shift

--END OF PROJECT

















       
	  
