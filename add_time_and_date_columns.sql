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


