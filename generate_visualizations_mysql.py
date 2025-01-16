import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import mysql.connector
import os

# MySQL connection
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="12345678",  # Your MySQL password
    database="WalmartSales"
)

# Set style for better visualizations
plt.style.use('seaborn')
sns.set_palette("husl")

# Create visualizations directory if it doesn't exist
if not os.path.exists('visualizations'):
    os.makedirs('visualizations')

# Query and create DataFrames
product_query = """
    SELECT 
        product_line,
        COUNT(*) as total_sales,
        ROUND(SUM(quantity)) as total_quantity,
        ROUND(SUM(total), 2) as total_revenue,
        ROUND(AVG(rating), 2) as avg_rating,
        ROUND(AVG(gross_margin_pct) * 100, 2) as avg_margin_percentage
    FROM sales
    GROUP BY product_line
"""

customer_query = """
    SELECT 
        customer_type,
        gender,
        COUNT(*) as purchase_count,
        ROUND(AVG(total), 2) as avg_purchase_amount,
        ROUND(SUM(total), 2) as total_revenue,
        ROUND(AVG(rating), 2) as avg_rating
    FROM sales
    GROUP BY customer_type, gender
"""

time_query = """
    SELECT 
        time_of_day,
        day_name,
        COUNT(*) as transaction_count,
        ROUND(SUM(total), 2) as total_revenue,
        ROUND(AVG(rating), 2) as avg_rating
    FROM sales
    GROUP BY time_of_day, day_name
"""

seasonal_query = """
    SELECT 
        season,
        product_line,
        COUNT(*) as sales_count,
        ROUND(SUM(quantity)) as total_quantity,
        ROUND(SUM(total), 2) as total_revenue,
        ROUND(AVG(rating), 2) as avg_rating
    FROM sales
    GROUP BY season, product_line
"""

# Read data from MySQL
product_df = pd.read_sql(product_query, conn)
customer_df = pd.read_sql(customer_query, conn)
time_df = pd.read_sql(time_query, conn)
seasonal_df = pd.read_sql(seasonal_query, conn)

# 1. Product Performance Visualization
plt.figure(figsize=(12, 6))
sns.barplot(data=product_df, x='product_line', y='total_revenue')
plt.xticks(rotation=45)
plt.title('Revenue by Product Line')
plt.tight_layout()
plt.savefig('visualizations/product_revenue.png')
plt.close()

# 2. Product Rating Analysis
plt.figure(figsize=(12, 6))
sns.scatterplot(data=product_df, x='avg_rating', y='total_revenue', size='total_quantity', 
                sizes=(100, 1000), alpha=0.6)
plt.title('Product Rating vs Revenue')
plt.tight_layout()
plt.savefig('visualizations/product_rating_revenue.png')
plt.close()

# 3. Customer Analysis
plt.figure(figsize=(10, 6))
sns.barplot(data=customer_df, x='customer_type', y='total_revenue', hue='gender')
plt.title('Revenue by Customer Type and Gender')
plt.tight_layout()
plt.savefig('visualizations/customer_revenue.png')
plt.close()

# 4. Time Analysis
plt.figure(figsize=(12, 6))
time_pivot = time_df.pivot_table(index='day_name', columns='time_of_day', values='total_revenue', aggfunc='sum')
time_pivot.plot(kind='bar', stacked=True)
plt.title('Revenue by Day and Time')
plt.xticks(rotation=45)
plt.tight_layout()
plt.savefig('visualizations/time_analysis.png')
plt.close()

# 5. Seasonal Analysis
plt.figure(figsize=(12, 6))
seasonal_pivot = seasonal_df.pivot_table(index='season', columns='product_line', 
                                       values='total_revenue', aggfunc='sum')
seasonal_pivot.plot(kind='bar', stacked=True)
plt.title('Seasonal Revenue by Product Line')
plt.xticks(rotation=45)
plt.legend(bbox_to_anchor=(1.05, 1), loc='upper left')
plt.tight_layout()
plt.savefig('visualizations/seasonal_analysis.png')
plt.close()

# Close MySQL connection
conn.close()

print("Visualizations have been generated in the 'visualizations' directory.")
