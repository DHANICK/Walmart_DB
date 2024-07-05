-- Number of sales made in each time of the day per weekday

SELECT
	time_of_day,
	COUNT(*) AS total_sales
FROM 
    sales
GROUP BY 
    time_of_day 
ORDER BY 
    total_sales DESC;


-- Top 5 Products by Gross Income

SELECT
    product_line,
    SUM(gross_income) AS total_gross_income
FROM 
    sales
GROUP BY 
    product_line
ORDER BY    
    total_gross_income DESC;


-- Total Revenue by Payment Method

SELECT
    Payment,
    SUM(total) AS total_revenue
FROM
    sales
GROUP BY
    Payment
ORDER BY
    total_revenue DESC;


-- Which city has the largest tax/VAT percent?

SELECT
	city,
    ROUND(AVG(vat), 2) AS avg_tax_pct
FROM 
    sales
GROUP BY 
    city 
ORDER BY 
    avg_tax_pct DESC;


-- Which customer type pays the most in VAT?

SELECT
	customer_type,
	AVG(vat) AS total_tax
FROM 
    sales
GROUP BY 
    customer_type
ORDER BY 
    total_tax;
