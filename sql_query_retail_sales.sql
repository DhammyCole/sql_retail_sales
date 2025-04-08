								-- RETAIL SALES

--Create TABLE 
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
			(
				transactions_id INT PRIMARY KEY,
				sale_date DATE,
				sale_time TIME,
				customer_id INT,
				gender VARCHAR(15),
				age	INT,
				category VARCHAR(15),
				quantity INT,
				price_per_unit FLOAT,
				cogs FLOAT,
				total_sale FLOAT
			);


--CONFIRMING THE DATA WE IMPORTED
SELECT * FROM retail_SALES
LIMIT 10;


--COUNTING THE NUMBERS OF ROWS IN OUR DATA
SELECT COUNT (*) FROM retail_sales


--DATA CLEANING
SELECT * FROM retail_sales
WHERE 
	transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR 
	age IS NULL
	OR
	category IS NULL
	OR
	quantity IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL;



DELETE FROM retail_sales
WHERE 
	transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR 
	age IS NULL
	OR
	category IS NULL
	OR
	quantity IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL;
	
	
--DATA EXPLORATION;

--what is the total number of sales?
SELECT COUNT(*) as total_sales FROM retail_sales;

--how many customer do we have?
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;	

--what are the product categories?
SELECT DISTINCT category FROM retail_sales;



--DATA ANALYSIS AND FINDINGS( KEY BUSINESS PROBLEM AND ANSWERS)
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17);



--Q1. Write a SQL query to retrieve all columns for sales made on '2022-11-05'
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';


--Q2.Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than or equals to 4 in the month of Nov-2022
SELECT *
FROM retail_sales
WHERE category = 'Clothing'
AND quantity >= 4
AND TO_CHAR (sale_date, 'YYYY-MM')= '2022-11';


--Q3.Write a SQL query to calculate the total sales (total_sale) for each category
SELECT
	category,
	SUM(total_sale) as total_sale ,
	count(*) as total_orders
FROM retail_sales
GROUP BY 1;


--Q4.Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category
SELECT
	ROUND(AVG(age),2) as average_age,
	category
FROM retail_sales
WHERE category = 'Beauty'
GROUP BY 2;


--Q5.Write a SQL query to find all transactions where the total_sale is greater than 1000
SELECT *
FROM retail_sales
WHERE total_sale > 1000;


--Q6.Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category
SELECT 
	category,
	gender,
	COUNT(transactions_id) as total_transactions
FROM retail_sales
GROUP BY 1,2
ORDER BY 1;


--Q7.Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT
	year,
	month,
	average_sale
FROM(
	SELECT
		EXTRACT(YEAR FROM sale_date) as year,
		EXTRACT(MONTH FROM sale_date) as month,
		AVG(total_sale) as average_sale,
		RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC ) as rank
	FROM retail_sales
	GROUP BY 1,2
	)
WHERE rank = 1;


--Q8.Write a SQL query to find the top 5 customers based on the highest total sales
SELECT
	customer_id,
	SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY total_sales DESC
LIMIT 5;


--Q9.Write a SQL query to find the number of unique customers who purchased items from each category
SELECT
	category,
	COUNT(DISTINCT customer_id) as no_of_unique_customers
FROM retail_sales
GROUP BY 1;


--Q10.Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
WITH hourly_sale 
as
(
SELECT *,
	CASE
		WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'morning'
		WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'afternoon'
		ELSE 'evening'
	END as shift
FROM retail_sales
)	
SELECT
	shift,
	COUNT(*) as total_orders
FROM hourly_sale
GROUP BY 1;

--END OF PROJECT

























































