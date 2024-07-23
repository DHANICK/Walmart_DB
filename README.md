# Walmart Sales Data Analysis

## About

This project aims to explore the Walmart Sales data to understand top performing branches and products, sales trend of of different products, customer behaviour. The aims is to study how sales strategies can be improved and optimized. The dataset was obtained from the [Kaggle Walmart Sales Forecasting Competition](https://www.kaggle.com/c/walmart-recruiting-store-sales-forecasting).

"In this recruiting competition, job-seekers are provided with historical sales data for 45 Walmart stores located in different regions. Each store contains many departments, and participants must project the sales for each department in each store. To add to the challenge, selected holiday markdown events are included in the dataset. These markdowns are known to affect sales, but it is challenging to predict which departments are affected and the extent of the impact." [source](https://www.kaggle.com/c/walmart-recruiting-store-sales-forecasting)

## Purposes Of The Project
The main objectives of this project are:

1. Data Organization: Establish a structured and efficient sales database by creating a new database and table if they do not already exist.
2. Data Enrichment: Enhance the dataset by adding columns that categorize sales data by time of day, day of the week, and month, making the data more informative and easier to analyze.
3. Data Integration: Facilitate the integration of sales data from external sources (e.g., CSV files) into the database.
4. Data Analysis: Provide a set of SQL queries to perform comprehensive data analysis, helping to extract valuable insights such as total revenue by city, transactions by time of day, and product performance metrics.
5. Business Insights: Enable businesses to make data-driven decisions by providing insights into sales trends, customer behavior, and product performance.
5. Performance Benchmarking: Compare the performance of different branches, product lines, and time periods to identify strengths and areas for improvement.

## Analysis List
1. Revenue Analysis
 - Total revenue generated from sales in each city.
 - Highest total sales revenue by product line.
 - Total revenue by product line.
2. Transaction Analysis
 - Number of sales transactions during each part of the day (Morning, Afternoon, Evening).
3. Product Performance
 - Product lines classified as "Good" or "Bad" based on whether their total sales are greater than the average sales.
 - Most common product line by gender.
 - Product line with the largest VAT.
 - Most selling product line based on quantity sold.
4. Customer Analysis
 - Average customer rating by city.
5. Branch Performance
 - Branches that sold more products than the average quantity sold.
6. Time-based Analysis
 - Day of the week with the highest number of sales.
## Scripts
### Create Database and Table
These scripts create a database and a `sales` table if they do not already exist.

```sql
-- Create the database if it doesn't exist
CREATE DATABASE IF NOT EXISTS sales_data_walmart;

-- Switch to the newly created database
USE sales_data_walmart;

-- Create the sales table if it doesn't exist
CREATE TABLE IF NOT EXISTS sales 
(
    invoice_id VARCHAR(30) NOT NULL primary key,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL (10, 2) NOT NULL,
    quantity int NOT NULL,
    VAT DECIMAL(8,4) NOT NULL,
    total DECIMAL(14,4) NOT NULL,
    date DATE NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(30) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_percentage DECIMAL(12,10) NOT NULL,
    gross_income DECIMAL (14,4) NOT NULL,
    rating DECIMAL (3,1)
);
```
### Add Time of Day, Day Name, and Month Name Columns
These scripts add columns to categorize sales data by time of day, day of the week, and month.
``` sql
-- Add the time_of_day column

ALTER TABLE sales 
            Add column time_of_day VARCHAR(20);

SELECT 
    time,
    CASE 
        WHEN time BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
        WHEN time BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
        ELSE 'Evening'
    END AS time_of_day
FROM sales;

-- This query updates the 'time_of_day' column in the 'sales' table based on the 'time' column.
-- It classifies each time value into 'Morning', 'Afternoon', or 'Evening'.

UPDATE sales
    SET time_of_day = (
            CASE 
            WHEN time BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
            WHEN time BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
            ELSE 'Evening'
    END
    )
    
-- Add day_name column

ALTER TABLE sales
            ADD day_name VARCHAR (20);

--Update 'day_name' to reflect the day of the week based on the 'date' column.

UPDATE sales
            SET day_name = TO_CHAR(date, 'Day');

-- Add month_name column

ALTER TABLE sales 
        ADD month_name VARCHAR(20);

-- Update 'month' to reflect the month based on the 'date' column.

UPDATE sales
        SET month_name = TO_CHAR(date,'Month')
```
### Total Revenue by City
This query calculates the total revenue generated from sales in each city.

```sql
-- What is the total revenue generated from sales in each city?

SELECT 
        Sum(total) AS total_revenue,
        city
FROM 
        sales
GROUP BY 
        city
ORDER BY 
        total_revenue DESC;
```
### Transactions by Time of Day
This query counts the number of sales transactions that occur during each part of the day (Morning, Afternoon, Evening).

```sql
-- How many sales transactions occur during each part of the day (Morning, Afternoon, Evening)?

SELECT 
        count(*) AS total_transactions,
        time_of_day
FROM    
        sales
GROUP BY
        time_of_day
ORDER BY
        total_transactions DESC;

```
### Highest Total Sales by Product Line
This query identifies which product line has the highest total sales revenue.

```sql
-- Which product line has the highest total sales revenue?

SELECT
        product_line,
        SUM(total) total_sales
FROM 
        sales 
GROUP BY 
        product_line
ORDER BY
        total_sales DESC;
```
### Average Customer Rating by City
This query calculates the average customer rating for each city.

```sql
-- How does the average customer rating differ by city?

SELECT
        AVG(rating) AS avg_rating,
        city
FROM 
        sales 
GROUP BY
        city
ORDER BY
        avg_rating DESC;
```
### Highest Sales by Day of the Week
This query determines which day of the week has the highest number of sales.

```sql
-- Which day of the week has the highest number of sales?

SELECT 
        SUM(total) as total_sales,
        day_name
FROM 
        sales
GROUP BY 
        day_name
ORDER BY 
        total_sales DESC;

```
### Product Line Performance
This query fetches each product line and adds a column showing "Good" or "Bad" based on whether its total sales are greater than the average sales.
```sql
-- Fetch each product line and add a column to those product lines showing "Good" or "Bad".
-- "Good" if its total sales are greater than average sales, otherwise "Bad".

WITH product_line_sales as (
    SELECT 
        SUM(total) AS total_sales,
        product_line
    FROM 
        sales
    GROUP BY
        product_line
),
AvgSales AS (
    SELECT
        AVG(total_sales) AS avg_sales
    FROM product_line_sales
)
SELECT Product_line,
        total_sales,
        CASE WHEN Total_Sales > ( SELECT avg_sales from AvgSales) THEN 'Good'
        ELSE 'Bad'
        END as Performance 
FROM product_line_sales;
```
### Branches with Above Average Quantity Sold
This query identifies which branches sold more products than the average quantity sold.
```sql
-- Which branch sold more products than the average quantity sold?

WITH avgquantity AS (
    SELECT
        avg(quantity) as avg_quantity
    FROM
        sales 
)
SELECT
        branch,
        SUM(quantity) AS total_quantity
FROM
        sales
GROUP BY 
        branch
HAVING 
        SUM(quantity) > (SELECT avg_quantity FROM avgquantity);

```
## What I Learned
Throughout this project, I gained valuable experience in data organization, enrichment, integration, and analysis. I learned to design and manage a structured database, proficiently using SQL commands for creating, altering, and managing tables. Enhancing the dataset with time-based categorizations made the data more informative and easier to analyze. I also developed skills in integrating external sales data and writing comprehensive SQL queries to extract insights, such as total revenue by city, transactions by time of day, and product performance metrics. This project sharpened my analytical thinking, enabling me to interpret data effectively and derive meaningful business insights. Analyzing sales trends, customer behavior, and performance metrics provided a solid foundation for making data-driven business decisions.
## Insights
- ***Revenue Analysis:*** Identified which cities and product lines generated the most revenue, allowing for targeted marketing and inventory decisions.
- ***Transaction Patterns:*** Determined peak sales times, which can inform staffing and promotional activities.
- ***Product Performance:*** Classified product lines based on their sales performance, helping to optimize inventory and sales strategies.
- ***Customer Behavior:*** Analyzed customer ratings and purchasing patterns to improve customer satisfaction and loyalty.
- ***Branch Performance:*** Compared branch performance to identify top-performing locations and areas needing improvement.
## Closing Thoughts
This project has been an invaluable learning experience, providing a comprehensive understanding of data analysis, SQL, and business intelligence. The skills and insights gained through this analysis are not only applicable to retail data but can also be leveraged in various industries to drive data-driven decision-making. By continuously refining and expanding on these techniques, businesses can stay ahead of the competition, better meet customer needs, and achieve sustained growth. Prepare short for my cv to add in my porjects.
