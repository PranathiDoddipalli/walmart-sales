import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import mysql.connector
import numpy as np
from scipy import stats
import os

# MySQL connection
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="12345678",
    database="WalmartSales"
)

# Set style for better visualizations
plt.style.use('seaborn')
sns.set_palette("husl")
plt.rcParams['figure.figsize'] = [12, 6]

# Create directories if they don't exist
os.makedirs('visualizations/advanced', exist_ok=True)
os.makedirs('reports', exist_ok=True)

# Comprehensive query
query = """
    SELECT 
        s.*,
        HOUR(time) as hour,
        CASE 
            WHEN HOUR(time) BETWEEN 6 AND 11 THEN 'Morning'
            WHEN HOUR(time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END as day_period,
        payment_method as payment
    FROM sales s
"""

# Read data
df = pd.read_sql(query, conn)

# 1. Advanced Product Analysis
plt.figure(figsize=(15, 8))
product_stats = df.groupby('product_line').agg({
    'total': ['sum', 'mean', 'std'],
    'quantity': 'sum',
    'rating': 'mean'
}).round(2)

# Product Performance Score
product_stats['performance_score'] = (
    stats.zscore(product_stats[('total', 'sum')]) + 
    stats.zscore(product_stats[('rating', 'mean')])
) / 2

plt.subplot(2, 1, 1)
sns.barplot(data=df, x='product_line', y='total', estimator='sum')
plt.title('Total Revenue by Product Line')
plt.xticks(rotation=45)

plt.subplot(2, 1, 2)
sns.barplot(x=product_stats.index, y=product_stats['performance_score'])
plt.title('Product Performance Score (Combined Revenue and Rating)')
plt.xticks(rotation=45)
plt.tight_layout()
plt.savefig('visualizations/advanced/product_analysis.png')
plt.close()

# 2. Customer Segmentation Analysis
plt.figure(figsize=(15, 10))

plt.subplot(2, 2, 1)
customer_segments = df.groupby(['customer_type', 'gender']).agg({
    'total': ['count', 'mean', 'sum'],
    'rating': 'mean'
}).round(2)
sns.boxplot(data=df, x='customer_type', y='total', hue='gender')
plt.title('Purchase Distribution by Customer Type and Gender')

plt.subplot(2, 2, 2)
hour_customer = df.groupby(['hour', 'customer_type']).size().unstack()
hour_customer.plot(kind='line', marker='o')
plt.title('Shopping Patterns Throughout the Day')
plt.xlabel('Hour of Day')
plt.ylabel('Number of Transactions')

plt.subplot(2, 2, 3)
sns.scatterplot(data=df, x='rating', y='total', hue='customer_type', size='quantity')
plt.title('Rating vs Total Amount by Customer Type')

plt.subplot(2, 2, 4)
payment_customer = df.groupby(['payment', 'customer_type']).size().unstack()
payment_customer.plot(kind='bar', stacked=True)
plt.title('Payment Methods by Customer Type')
plt.xticks(rotation=45)

plt.tight_layout()
plt.savefig('visualizations/advanced/customer_analysis.png')
plt.close()

# 3. Temporal Analysis
plt.figure(figsize=(15, 10))

plt.subplot(2, 2, 1)
hourly_sales = df.groupby('hour')['total'].sum()
hourly_sales.plot(kind='line', marker='o')
plt.title('Sales Throughout the Day')
plt.xlabel('Hour')
plt.ylabel('Total Sales')

plt.subplot(2, 2, 2)
daily_sales = df.groupby('day_name')['total'].sum()
daily_sales.plot(kind='bar')
plt.title('Sales by Day of Week')
plt.xticks(rotation=45)

plt.subplot(2, 2, 3)
seasonal_sales = df.groupby(['season', 'product_line'])['total'].sum().unstack()
seasonal_sales.plot(kind='bar', stacked=True)
plt.title('Seasonal Sales by Product Line')
plt.xticks(rotation=45)
plt.legend(bbox_to_anchor=(1.05, 1), loc='upper left')

plt.subplot(2, 2, 4)
time_ratings = df.groupby('day_period')['rating'].mean().plot(kind='bar')
plt.title('Average Ratings by Time of Day')
plt.xticks(rotation=45)

plt.tight_layout()
plt.savefig('visualizations/advanced/temporal_analysis.png')
plt.close()

# 4. Statistical Analysis and Report Generation
report = """# Walmart Sales Analysis Report

## 1. Product Performance Analysis

### Top Performing Products (by Revenue):
{}

### Product Performance Scores (Combined Revenue and Rating):
{}

## 2. Customer Analysis

### Customer Segment Statistics:
{}

### Payment Method Distribution:
{}

## 3. Temporal Patterns

### Daily Sales Statistics:
{}

### Seasonal Performance:
{}

## 4. Key Insights

1. Product Performance:
   - Highest revenue product line: {}
   - Best-rated product line: {}

2. Customer Behavior:
   - Most common customer type: {}
   - Preferred payment method: {}

3. Temporal Patterns:
   - Peak sales hour: {}
   - Best performing day: {}
   - Strongest season: {}

## 5. Recommendations

1. Product Strategy:
   - Focus on expanding {} due to high performance
   - Review pricing strategy for {} due to lower performance

2. Customer Strategy:
   - Target marketing to {} during {} hours
   - Enhance loyalty program for {} customers

3. Operational Strategy:
   - Optimize staffing during peak hours ({})
   - Adjust inventory for seasonal demands in {}
""".format(
    product_stats[('total', 'sum')].sort_values(ascending=False).to_string(),
    product_stats['performance_score'].sort_values(ascending=False).to_string(),
    customer_segments.to_string(),
    df.groupby('payment').size().to_string(),
    df.groupby('day_name')['total'].agg(['mean', 'sum']).round(2).to_string(),
    df.groupby('season')['total'].sum().sort_values(ascending=False).to_string(),
    df.groupby('product_line')['total'].sum().idxmax(),
    df.groupby('product_line')['rating'].mean().idxmax(),
    df['customer_type'].mode()[0],
    df['payment'].mode()[0],
    df.groupby('hour')['total'].sum().idxmax(),
    df.groupby('day_name')['total'].sum().idxmax(),
    df.groupby('season')['total'].sum().idxmax(),
    df.groupby('product_line')['total'].sum().idxmax(),
    df.groupby('product_line')['total'].sum().idxmin(),
    df['customer_type'].mode()[0],
    df.groupby('day_period')['total'].sum().idxmax(),
    df['customer_type'].value_counts().index[0],
    df.groupby('hour')['total'].sum().idxmax(),
    df.groupby('season')['total'].sum().idxmax()
)

with open('reports/sales_analysis_report.md', 'w') as f:
    f.write(report)

# Close MySQL connection
conn.close()

print("Advanced analysis completed! Check the following files:")
print("1. visualizations/advanced/product_analysis.png")
print("2. visualizations/advanced/customer_analysis.png")
print("3. visualizations/advanced/temporal_analysis.png")
print("4. reports/sales_analysis_report.md")
