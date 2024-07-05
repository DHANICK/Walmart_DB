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
        CASE WHEN Total_Sales > ( SELECT avg_sales from AvgSales) THEN 'good'
        ELSE 'bad'
        END as Performance 
from product_line_sales


--Which branch sold more products than the average quantity sold?


WITH avgquantity AS(
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

--What is the most common product line by gender?


SELECT
        product_line,
        gender,
        count(*)
FROM
        sales
GROUP BY
        product_line, gender
ORDER BY 
        count DESC


--What product line had the largest VAT?

SELECT
        product_line,
        SUM(vat) as total_vat
        
FROM
        sales
GROUP BY
        product_line
ORDER BY 
        total_vat DESC

--What is the most selling product line?

SELECT
        product_line,
        SUM(quantity)AS total_quantity
FROM
        sales
GROUP BY
        product_line
ORDER BY 
        total_quantity DESC

-- What product line had the largest revenue?


SELECT 
    product_line,
    sum(total) AS total_revenue
FROM 
    sales
GROUP BY
    product_line
ORDER BY 
    total_revenue DESC;
