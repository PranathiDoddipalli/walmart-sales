USE WalmartSales;

-- First, let's add the new columns we need
ALTER TABLE sales 
ADD COLUMN IF NOT EXISTS quarter INT,
ADD COLUMN IF NOT EXISTS season VARCHAR(10),
ADD COLUMN IF NOT EXISTS customer_segment VARCHAR(50),
ADD COLUMN IF NOT EXISTS sales_performance_index DECIMAL(10,2);

-- Time-based features
UPDATE sales
SET time_of_day = (
    CASE 
        WHEN TIME(time) BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
        WHEN TIME(time) BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
        ELSE 'Evening'
    END
);

UPDATE sales
SET day_name = DAYNAME(date);

UPDATE sales
SET month_name = MONTHNAME(date);

-- Add quarter information
UPDATE sales
SET quarter = QUARTER(date);

-- Add season information
UPDATE sales
SET season = (
    CASE 
        WHEN MONTH(date) IN (12, 1, 2) THEN 'Winter'
        WHEN MONTH(date) IN (3, 4, 5) THEN 'Spring'
        WHEN MONTH(date) IN (6, 7, 8) THEN 'Summer'
        ELSE 'Fall'
    END
);

-- Customer Segmentation based on rating
UPDATE sales
SET customer_segment = (
    CASE 
        WHEN rating >= 8 THEN 'High Value'
        WHEN rating >= 6 THEN 'Medium Value'
        ELSE 'Low Value'
    END
);

-- Sales Performance Index
UPDATE sales
SET sales_performance_index = (
    (quantity * gross_margin_pct * 100) + (IFNULL(rating, 5) * 2)
) / 100;

-- Create view for daily sales analysis
CREATE OR REPLACE VIEW daily_sales_mv AS
SELECT 
    DATE(date) as sale_date,
    branch,
    SUM(total) as daily_revenue,
    SUM(quantity) as daily_quantity,
    AVG(gross_margin_pct) as avg_margin,
    COUNT(DISTINCT invoice_id) as transaction_count
FROM sales
GROUP BY DATE(date), branch;

-- Create view for product performance
CREATE OR REPLACE VIEW product_performance_mv AS
SELECT 
    product_line,
    SUM(quantity) as total_quantity,
    SUM(total) as total_revenue,
    AVG(gross_margin_pct) as avg_margin,
    AVG(rating) as avg_rating,
    COUNT(DISTINCT invoice_id) as transaction_count
FROM sales
GROUP BY product_line;
