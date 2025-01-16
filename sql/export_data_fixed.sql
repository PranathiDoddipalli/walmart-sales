USE WalmartSales;

-- 1. Product Performance Export
SELECT 
    product_line,
    COUNT(*) as total_sales,
    ROUND(SUM(quantity)) as total_quantity,
    ROUND(SUM(total), 2) as total_revenue,
    ROUND(AVG(rating), 2) as avg_rating,
    ROUND(AVG(gross_margin_pct) * 100, 2) as avg_margin_percentage
FROM sales
GROUP BY product_line
INTO OUTFILE 'C:/Users/prana/OneDrive/Desktop/PROJECTS/walmart_sales_sql/data/product_performance.csv'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

-- 2. Customer Analysis Export
SELECT 
    customer_type,
    gender,
    COUNT(*) as purchase_count,
    ROUND(AVG(total), 2) as avg_purchase_amount,
    ROUND(SUM(total), 2) as total_revenue,
    ROUND(AVG(rating), 2) as avg_rating
FROM sales
GROUP BY customer_type, gender
INTO OUTFILE 'C:/Users/prana/OneDrive/Desktop/PROJECTS/walmart_sales_sql/data/customer_analysis.csv'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

-- 3. Time Analysis Export
SELECT 
    time_of_day,
    day_name,
    COUNT(*) as transaction_count,
    ROUND(SUM(total), 2) as total_revenue,
    ROUND(AVG(rating), 2) as avg_rating
FROM sales
GROUP BY time_of_day, day_name
INTO OUTFILE 'C:/Users/prana/OneDrive/Desktop/PROJECTS/walmart_sales_sql/data/time_analysis.csv'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

-- 4. Seasonal Analysis Export
SELECT 
    season,
    product_line,
    COUNT(*) as sales_count,
    ROUND(SUM(quantity)) as total_quantity,
    ROUND(SUM(total), 2) as total_revenue,
    ROUND(AVG(rating), 2) as avg_rating
FROM sales
GROUP BY season, product_line
INTO OUTFILE 'C:/Users/prana/OneDrive/Desktop/PROJECTS/walmart_sales_sql/data/seasonal_analysis.csv'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n';
