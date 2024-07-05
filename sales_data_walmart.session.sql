create DATABASE IF NOT EXISTS sales_data_walmart;

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