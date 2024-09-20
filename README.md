1. Creating the Database and Table
The script begins by creating a new database called WalmartSales.
It then creates a table named sales that stores information such as:
Invoice ID (Primary Key)
Branch, City, Customer Type, Gender
Product Line (e.g., categories like electronics, clothing, etc.)
Unit Price, Quantity (number of items sold)
VAT (Value Added Tax), Total, Cost of Goods Sold (COGS), Gross Margin, Gross Income, Rating
Date, Time of transaction
Payment Method (e.g., credit card, cash)

2. Feature Engineering
Feature engineering is the process of creating new data columns that can help with analysis.
Time of Day:
A new column time_of_day is created, classifying each sale as occurring during "Morning," "Afternoon," or "Evening," based on the time column.
Day of the Week:
Another column, day_name, is added to store the name of the day (e.g., Monday, Tuesday) based on the date column.
Month Name:
A month_name column is created to store the name of the month (e.g., January, February).

3. Generic Queries
These are basic queries that provide an overview of the dataset.
Unique Cities and Branches:
Queries are run to find how many distinct cities and branches are present in the dataset.

4. Product-Based Queries
These queries focus on the products sold.
Unique Product Lines:
Finds how many unique product categories (or lines) exist.
Most Common Payment Method:
Identifies the most frequently used payment method.
Best-Selling Product Line:
Finds which product category sells the most.
Revenue by Month:
Summarizes total sales revenue by month.
Largest COGS by Month:
Finds the month with the highest cost of goods sold (COGS).
Product Line with Largest Revenue:
Determines which product line generates the most revenue.
City with the Largest Revenue:
Finds which city generates the most sales revenue.
Product Line with the Largest VAT:
Determines the product line with the highest average VAT.
Good vs. Bad Product Lines:
Categorizes product lines as "Good" or "Bad" based on whether they have above-average sales.
Branch with Above-Average Sales:
Identifies branches that sold more than the average number of products.
Most Popular Product Line by Gender:
Finds which product line is most popular among different genders.
Average Product Rating:
Calculates the average rating for each product line.

5. Customer-Based Queries
These queries analyze customer behavior.
Unique Customer Types:
Determines how many distinct customer types (e.g., regular, VIP) exist.
Common Customer Type:
Identifies which customer type is the most frequent.
Customer Type with the Most Purchases:
Finds which customer type makes the most purchases.
Most Common Gender:
Determines the gender of most customers.
Gender Distribution per Branch:
Shows the gender breakdown of customers at each branch.
Time of Day with the Most Ratings:
Determines the time of day when customers give the most ratings.
Time of Day with the Most Ratings by Branch:
Analyzes ratings for a specific branch, grouped by time of day.
Day of the Week with the Best Ratings:
Finds which day of the week has the best average customer ratings.
Sales by Day of the Week per Branch:
Shows how many sales were made on each day of the week for a specific branch.

6. Sales-Based Queries
These queries focus on sales performance.
Sales by Time of Day per Weekday:
Counts how many sales occur at different times of the day, especially on Sundays.
Customer Type with the Most Revenue:
Identifies which customer type generates the most revenue.
City with the Largest VAT:
Finds which city has the highest average VAT percentage.
Customer Type Paying the Most VAT:
Determines which customer type pays the most VAT on average.

Summary:
This script sets up a Walmart sales database, creates a table, and adds columns through feature engineering to enrich the dataset.
It includes various queries that analyze sales performance, customer behavior, product lines, and time-based trends.
These insights help identify key trends such as the most popular product lines, best days for sales, and cities with the highest revenue.
