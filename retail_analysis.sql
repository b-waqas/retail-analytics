CREATE TABLE retail_sales (
    customer_id INT,
    order_date DATE,
    product_id INT,
    category_id INT,
    category_name VARCHAR(70),
    product_name VARCHAR(75),
    quantity INT,
    price DECIMAL(10,2),
    payment_method VARCHAR(50),
    city VARCHAR(100),
    review_score INT,
    gender VARCHAR(20),
    age INT,
    review_score_duplicate INT,
    Rating_Status VARCHAR(20),
    Revenue DECIMAL(12,2)
);

##the dataset has line level data (no order_id), so metrics are based on transaction lines ##


select * from retail_sales;
## revenue by Category##
SELECT 
    category_name,
    SUM(Revenue) AS total_revenue,
    COUNT(*) AS transaction_lines
FROM retail_sales
GROUP BY category_name
ORDER BY total_revenue DESC;

##monthly sales Trend##
SELECT
    SUBSTR(order_date, 1, 7) AS month,  -- extracting from the first character of the string, take 7 characters from that starting point ##
    SUM(Revenue) AS monthly_revenue,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales
GROUP BY SUBSTR(order_date, 1, 7)
ORDER BY month;

SELECT 
    customer_id,
    SUM(Revenue) AS lifetime_value, ##Top 10 Customers by Lifetime Value##
    COUNT(*) AS purchase_frequency
FROM retail_sales
GROUP BY customer_id
ORDER BY lifetime_value DESC
LIMIT 10;

SELECT 
    payment_method,
    AVG(Revenue) AS avg_revenue_per_line,
    COUNT(*) AS transaction_lines
FROM retail_sales
GROUP BY payment_method
ORDER BY avg_revenue_per_line DESC;

SELECT 
    gender,
    CASE 
        WHEN age < 25 THEN '18-24'
        WHEN age BETWEEN 25 AND 34 THEN '25-34'
        WHEN age BETWEEN 35 AND 50 THEN '35-50'
        ELSE '50+'
    END AS age_group,
    Rating_Status,
    COUNT(DISTINCT customer_id) AS customer_count,
    round(AVG(Revenue),2) AS avg_spend_per_line
FROM retail_sales
GROUP BY gender, age_group, Rating_Status
ORDER BY age_group, gender, Rating_Status;

SELECT product_name, review_score
FROM retail_sales
WHERE review_score > (SELECT AVG(review_score) FROM retail_sales)
LIMIT 10;




