USE WalmartSales;

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

UPDATE sales
SET quarter = QUARTER(date);

UPDATE sales
SET season = (
    CASE 
        WHEN MONTH(date) IN (12, 1, 2) THEN 'Winter'
        WHEN MONTH(date) IN (3, 4, 5) THEN 'Spring'
        WHEN MONTH(date) IN (6, 7, 8) THEN 'Summer'
        ELSE 'Fall'
    END
);

-- Customer Segmentation
UPDATE sales s
SET customer_segment = (
    CASE 
        WHEN rating >= 8 THEN 'High Value'
        WHEN rating >= 6 THEN 'Medium Value'
        ELSE 'Low Value'
    END
);

-- Sales Performance Index
-- Combines quantity, gross_margin_pct, and rating into a single metric
UPDATE sales
SET sales_performance_index = (
    (quantity * gross_margin_pct * 100) + (IFNULL(rating, 5) * 2)
) / 100;

-- Create materialized views for common aggregations
CREATE OR REPLACE VIEW daily_sales_mv AS
SELECT 
    DATE(date) as sale_date,
    branch_id,
    SUM(total) as daily_revenue,
    SUM(quantity) as daily_quantity,
    AVG(gross_margin_pct) as avg_margin,
    COUNT(DISTINCT invoice_id) as transaction_count
FROM sales
GROUP BY DATE(date), branch_id;

CREATE OR REPLACE VIEW product_performance_mv AS
SELECT 
    p.product_line,
    SUM(s.quantity) as total_quantity,
    SUM(s.total) as total_revenue,
    AVG(s.gross_margin_pct) as avg_margin,
    AVG(s.rating) as avg_rating,
    COUNT(DISTINCT s.invoice_id) as transaction_count
FROM sales s
JOIN product_lines p ON s.product_line_id = p.product_line_id
GROUP BY p.product_line;
