SELECT count (*) from retail_sales;

-- DATA CLEANING
SELECT * FROM retail_sales 
WHERE
	transactions_id	IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	gender IS NULL
	OR
	category IS NULL
	OR
	quantiy IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL;

DELETE FROM retail_sales
WHERE
		transactions_id	IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	gender IS NULL
	OR
	category IS NULL
	OR
	quantiy IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL;

-- DATA EXPLORATION

--How many sales we have

SELECT count(*) as total_sale FROM retail_sales;




--Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'

SELECT * from retail_sales
WHERE sale_date ='2022-11-05';



-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-20

SELECT * FROM retail_sales
WHERE
	category='Clothing'
	AND
	TO_CHAR(sale_date, 'YYYY-MM')='2022-11'
	AND
	quantiy >=4



--Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT category,
SUM(total_sale) as net_sale,
COUNT (*) AS total_orders
FROM retail_sales GROUP BY 1;
     


--Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT AVG(age :: numeric) as avg_age FROM retail_sales 
WHERE category= 'beauty' AND AGE IS NOT NULL



--Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT * FROM retail_sales
where total_sale >1000


--Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT category,gender,
 count(*) as total_trans
 FROM retail_sales
 GROUP BY
 category,gender
 order by 1

--Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT 
	YEAR,
	MONTH,
	avg_sale
FROM
(
	SELECT 
		EXTRACT(YEAR FROM sale_date) AS year,
		EXTRACT(month FROM sale_date) AS month,
		AVG(total_sale) as avg_sale,
		RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date)ORDER BY AVG(total_sale) DESC )
	FROM retail_sales
	GROUP BY 1,2
) AS t1
 WHERE RANK=1
--Q.8 Write a SQL query to find the top 5 customers based on the highest total sales


SELECT 
	customer_id,
	sum(total_sale) as total_sales
FROM retail_sales
group by 1
order by 2 DESC
LIMIT 5




--Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.


SELECT 
	category,
	COUNT ( DISTINCT customer_id) AS UNIQUE_CUSTOMER
FROM retail_sales
GROUP BY category



--Q.10 Write a SQL query to create each shift and number of orders 
--(Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
WITH hourly_sale
as
(
SELECT *,
	CASE
	WHEN EXTRACT( HOUR FROM sale_time) < 12 THEN 'MORNING'
	WHEN EXTRACT( HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'AFTERNOON'
	ELSE 'EVENING'
END AS shift
FROM retail_sales
)
SELECT 
	shift,
	COUNT(*) AS total_orders
FROM hourly_sale
GROUP by shift


-- end og project


