USE WalmartSales;

-- 1. Product Analysis
-- Product performance metrics
SELECT 
    product_line,
    COUNT(*) as total_sales,
    ROUND(SUM(quantity)) as total_quantity,
    ROUND(SUM(total), 2) as total_revenue,
    ROUND(AVG(rating), 2) as avg_rating,
    ROUND(AVG(gross_margin_pct) * 100, 2) as avg_margin_percentage
FROM sales
GROUP BY product_line
ORDER BY total_revenue DESC;

-- 2. Customer Analysis
-- Customer type and gender analysis
SELECT 
    customer_type,
    gender,
    COUNT(*) as purchase_count,
    ROUND(AVG(total), 2) as avg_purchase_amount,
    ROUND(SUM(total), 2) as total_revenue,
    ROUND(AVG(rating), 2) as avg_rating
FROM sales
GROUP BY customer_type, gender
ORDER BY total_revenue DESC;

-- 3. Store Performance
-- Branch performance analysis
SELECT 
    branch,
    city,
    COUNT(*) as total_transactions,
    ROUND(SUM(total), 2) as total_revenue,
    ROUND(AVG(total), 2) as avg_transaction_value,
    ROUND(AVG(rating), 2) as avg_rating
FROM sales
GROUP BY branch, city
ORDER BY total_revenue DESC;

-- 4. Payment Method Analysis
SELECT 
    payment_method,
    COUNT(*) as usage_count,
    ROUND(AVG(total), 2) as avg_transaction_value,
    ROUND(SUM(total), 2) as total_revenue,
    ROUND(AVG(rating), 2) as avg_rating
FROM sales
GROUP BY payment_method
ORDER BY total_revenue DESC;

-- 5. Time-based Analysis
-- Sales by time of day and day of week
SELECT 
    time_of_day,
    day_name,
    month_name,
    season,
    COUNT(*) as transaction_count,
    ROUND(AVG(total), 2) as avg_transaction_value,
    ROUND(SUM(total), 2) as total_revenue,
    ROUND(AVG(rating), 2) as avg_rating
FROM sales
GROUP BY time_of_day, day_name, month_name, season
ORDER BY total_revenue DESC;

-- 6. Product Categories by Time
-- Product performance by time of day
SELECT 
    product_line,
    time_of_day,
    COUNT(*) as sales_count,
    ROUND(SUM(total), 2) as total_revenue,
    ROUND(AVG(rating), 2) as avg_rating,
    ROUND(AVG(gross_margin_pct) * 100, 2) as avg_margin_percentage
FROM sales
GROUP BY product_line, time_of_day
ORDER BY product_line, total_revenue DESC;

-- 7. Customer Segment Analysis
SELECT 
    customer_segment,
    COUNT(*) as customer_count,
    ROUND(AVG(total), 2) as avg_purchase_amount,
    ROUND(SUM(total), 2) as total_revenue,
    ROUND(AVG(rating), 2) as avg_rating
FROM sales
GROUP BY customer_segment
ORDER BY total_revenue DESC;

-- 8. Seasonal Analysis
SELECT 
    season,
    product_line,
    COUNT(*) as sales_count,
    ROUND(SUM(quantity)) as total_quantity,
    ROUND(SUM(total), 2) as total_revenue,
    ROUND(AVG(rating), 2) as avg_rating
FROM sales
GROUP BY season, product_line
ORDER BY season, total_revenue DESC;

-- 9. Sales Performance Index Analysis
SELECT 
    product_line,
    ROUND(AVG(sales_performance_index), 2) as avg_performance_index,
    COUNT(*) as total_sales,
    ROUND(SUM(total), 2) as total_revenue
FROM sales
GROUP BY product_line
ORDER BY avg_performance_index DESC;
