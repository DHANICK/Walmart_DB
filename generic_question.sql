--Generic Question

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

--How many sales transactions occur during each part of
-- the day (Morning, Afternoon, Evening)?

SELECT 
        count(*) AS total_transactions,
        time_of_day
from    
        sales
GROUP BY
        time_of_day
ORDER BY
        total_transactions DESC;

--Which product line has the highest total sales revenue?

SELECT
        product_line,
        SUM(total) total_sales
FROM 
        sales 
GROUP BY 
        product_line
ORDER BY
        total_sales DESC;

--How does the average customer rating differ by city?

SELECT
        AVG(rating) AS avg_rating,
        city
FROM 
        sales 
GROUP BY
        city
ORDER BY
        avg_rating DESC;

--Which day of the week has the highest number of sales?

SELECT 
        SUM(total) as total_sales,
        day_name
FROM 
        sales
GROUP BY 
        day_name
ORDER BY 
        total_sales DESC;

