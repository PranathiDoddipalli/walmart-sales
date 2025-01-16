USE WalmartSales;

-- 1. Advanced Product Analysis
-- Product performance score incorporating multiple metrics
WITH ProductMetrics AS (
    SELECT 
        pl.product_line,
        AVG(s.rating) as avg_rating,
        SUM(s.quantity) as total_quantity,
        SUM(s.total) as total_revenue,
        AVG(s.gross_margin_pct) as avg_margin
    FROM sales s
    JOIN product_lines pl ON s.product_line_id = pl.product_line_id
    GROUP BY pl.product_line
)
SELECT 
    product_line,
    ROUND(avg_rating, 2) as rating,
    total_quantity,
    ROUND(total_revenue, 2) as revenue,
    ROUND(avg_margin * 100, 2) as margin_percentage,
    ROUND((avg_rating * 0.3 + 
           (total_quantity / MAX(total_quantity) OVER ()) * 0.3 + 
           (total_revenue / MAX(total_revenue) OVER ()) * 0.4) * 100, 2) as performance_score
FROM ProductMetrics
ORDER BY performance_score DESC;

-- 2. Customer Behavior Analysis
-- Advanced customer segmentation with RFM analysis
WITH CustomerRFM AS (
    SELECT 
        ct.customer_type,
        s.gender,
        COUNT(DISTINCT s.invoice_id) as frequency,
        DATEDIFF(MAX(s.date), MIN(s.date)) as recency,
        AVG(s.total) as monetary
    FROM sales s
    JOIN customer_types ct ON s.customer_type_id = ct.customer_type_id
    GROUP BY ct.customer_type, s.gender
)
SELECT 
    customer_type,
    gender,
    frequency,
    recency,
    ROUND(monetary, 2) as avg_transaction_value,
    CASE 
        WHEN frequency > AVG(frequency) OVER() AND monetary > AVG(monetary) OVER() THEN 'High Value'
        WHEN frequency > AVG(frequency) OVER() OR monetary > AVG(monetary) OVER() THEN 'Medium Value'
        ELSE 'Low Value'
    END as customer_segment
FROM CustomerRFM
ORDER BY monetary DESC;

-- 3. Temporal Analysis
-- Advanced time-based patterns
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

-- 4. Branch Performance Analysis
-- Comprehensive branch performance metrics
SELECT 
    b.branch_id,
    b.city,
    COUNT(DISTINCT s.invoice_id) as total_transactions,
    ROUND(SUM(s.total), 2) as total_revenue,
    ROUND(AVG(s.total), 2) as avg_transaction_value,
    ROUND(AVG(s.rating), 2) as avg_rating,
    COUNT(DISTINCT CASE WHEN s.customer_segment = 'High Value' THEN s.invoice_id END) as high_value_transactions
FROM sales s
JOIN branches b ON s.branch_id = b.branch_id
GROUP BY b.branch_id, b.city
ORDER BY total_revenue DESC;

-- 5. Payment Method Analysis
-- Payment method preferences by customer segment
SELECT 
    pm.payment_method,
    ct.customer_type,
    COUNT(*) as usage_count,
    ROUND(AVG(s.total), 2) as avg_transaction_value,
    ROUND(SUM(s.total), 2) as total_revenue,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY ct.customer_type), 2) as segment_percentage
FROM sales s
JOIN payment_methods pm ON s.payment_method_id = pm.payment_method_id
JOIN customer_types ct ON s.customer_type_id = ct.customer_type_id
GROUP BY pm.payment_method, ct.customer_type
ORDER BY ct.customer_type, usage_count DESC;

-- 6. Product Category Performance by Time
-- Seasonal and temporal patterns in product categories
SELECT 
    pl.product_line,
    s.season,
    s.time_of_day,
    COUNT(*) as sales_count,
    ROUND(SUM(s.total), 2) as total_revenue,
    ROUND(AVG(s.rating), 2) as avg_rating,
    ROUND(AVG(s.gross_margin_pct) * 100, 2) as avg_margin_percentage
FROM sales s
JOIN product_lines pl ON s.product_line_id = pl.product_line_id
GROUP BY pl.product_line, s.season, s.time_of_day
ORDER BY pl.product_line, total_revenue DESC;
