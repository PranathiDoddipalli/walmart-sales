import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import os

# Set style for better visualizations
plt.style.use('seaborn')
sns.set_palette("husl")

# Create visualizations directory if it doesn't exist
if not os.path.exists('visualizations'):
    os.makedirs('visualizations')

# Read the exported CSV files
product_df = pd.read_csv('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/product_performance.csv')
customer_df = pd.read_csv('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/customer_analysis.csv')
time_df = pd.read_csv('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/time_analysis.csv')
seasonal_df = pd.read_csv('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/seasonal_analysis.csv')

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
customer_pivot = customer_df.pivot(index='customer_type', columns='gender', values='total_revenue')
customer_pivot.plot(kind='bar', width=0.8)
plt.title('Revenue by Customer Type and Gender')
plt.tight_layout()
plt.savefig('visualizations/customer_revenue.png')
plt.close()

# 4. Time Analysis
plt.figure(figsize=(12, 6))
time_pivot = time_df.pivot(index='day_name', columns='time_of_day', values='total_revenue')
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

print("Visualizations have been generated in the 'visualizations' directory.")
