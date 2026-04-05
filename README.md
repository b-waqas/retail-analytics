# Retail Analytics Portfolio Project – SQL Data Analysis

## Project Overview

This project demonstrates my data cleaning and SQL analysis skills for a retail e-commerce dataset. It is part of my freelance data analyst portfolio, showcasing my ability to transform raw data into actionable business insights.

**Key skills demonstrated:**
- Data cleaning (Power Query / Excel)
- Exploratory data analysis (SQL)
- Business metric calculation
- Clear documentation and query writing

## Dataset Description

The dataset contains **online retail transaction lines** (no order-level grouping). Each row represents one product purchased in a customer transaction.

### Original Data Source
- [Online Retail Data Set on Kaggle](https://www.kaggle.com/datasets/ertugrulesol/online-retail-data) (modified for cleaning practice)

### Columns After Cleaning

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| `customer_id` | INT | Unique customer identifier |
| `order_date` | TEXT | Date of transaction (YYYY-MM-DD) |
| `product_id` | INT | Product identifier |
| `category_id` | INT | Category identifier |
| `category_name` | TEXT | Product category (Electronics, Fashion, etc.) |
| `product_name` | TEXT | Product description |
| `quantity` | INT | Number of units purchased (1-5) |
| `price` | DOUBLE | Unit price in USD |
| `payment_method` | TEXT | Credit Card, Bank Transfer, Cash on Delivery |
| `city` | TEXT | Customer location |
| `review_score` | TEXT | Original review field (not used in analysis) |
| `review_score_duplicate` | INT | Numeric rating: 1-5, or 0 for "Not Rated" |
| `Rating_Status` | TEXT | "Rated" or "Not Rated" |
| `age` | INT | Customer age (18-75) |
| `Revenue` | DOUBLE | Calculated as `quantity * price` |

### Data Cleaning Performed (Power Query)
- Replaced null review scores with 0
- Created `Rating_Status` column to flag unrated rows
- Removed duplicate rows
- Filtered out zero/negative price and quantity
- Created `Revenue` calculated column

## SQL Analysis Queries

The file `retail_analysis.sql` contains 6 analytical queries:

1. **Total Revenue by Category** – Identifies top-performing product categories.
2. **Monthly Sales Trend** – Shows revenue and unique customers over time.
3. **Top 10 Customers by Lifetime Value** – Finds highest-value customers.
4. **Average Transaction Value by Payment Method** – Compares payment method performance.
5. **Customer Demographics with Rating Status** – Segments by gender, age, and rating status.
6. **Products with Low Ratings (<average)** – Flags underperforming products.

## Sample Query (Top Customers)

```sql
SELECT 
    customer_id,
    SUM(Revenue) AS lifetime_value,
    COUNT(*) AS purchase_frequency
FROM retail_sales
GROUP BY customer_id
ORDER BY lifetime_value DESC
LIMIT 10;
