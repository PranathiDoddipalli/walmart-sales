# 🛍️ Walmart Sales Analysis Project

![Walmart](https://img.shields.io/badge/Walmart-Sales%20Analysis-blue)
![MySQL](https://img.shields.io/badge/MySQL-8.0%2B-orange)
![Python](https://img.shields.io/badge/Python-3.8%2B-green)
![License](https://img.shields.io/badge/License-MIT-yellow)

## 📊 Project Overview

This project performs an in-depth analysis of Walmart's sales data to uncover valuable business insights. Using MySQL for data management and Python for advanced analytics, we explore various aspects of sales performance, customer behavior, and product trends.

### 🎯 Key Objectives
- Analyze sales patterns across different product lines
- Understand customer purchasing behavior
- Identify peak sales periods and seasonal trends
- Optimize inventory management through data-driven insights
- Improve customer satisfaction through targeted recommendations

### 📈 Major Findings

1. **Product Performance**
   - Electronic accessories and Food & Beverages are top-performing categories
   - Higher customer ratings correlate with increased sales volume
   - Seasonal variations significantly impact product performance

2. **Customer Insights**
   - Member customers generate 73% of total revenue
   - Female customers show higher average transaction values
   - Peak shopping hours vary by customer segment

3. **Sales Patterns**
   - Evening hours (4-7 PM) show highest transaction volumes
   - Weekends demonstrate 25% higher sales than weekdays
   - Seasonal peaks during winter and summer months

## 🚀 Getting Started

### Prerequisites

- MySQL 8.0 or higher
- Python 3.8 or higher
- Required Python packages (install using `pip install -r requirements.txt`):
  - pandas
  - matplotlib
  - seaborn
  - mysql-connector-python
  - scipy

### 📥 Installation & Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/walmart_sales_sql.git
   cd walmart_sales_sql
   ```

2. **Install dependencies**
   ```bash
   pip install -r requirements.txt
   ```

3. **Database Setup**
   ```sql
   -- Create and use the database
   CREATE DATABASE WalmartSales;
   USE WalmartSales;
   
   -- Import schema
   source sql/schema.sql
   
   -- Run feature engineering
   source sql/feature_engineering.sql
   ```

4. **Run Analysis**
   ```bash
   python advanced_analysis.py
   ```

## 📊 Analysis Components

### 1. Data Engineering
- **Schema Design**: Optimized for analytical queries
- **Feature Engineering**: 
  - Time-based features (hour, day, month, season)
  - Customer segmentation based on purchase patterns
  - Product performance metrics
  - Sales indices for trend analysis

### 2. Sales Analysis
- **Revenue Metrics**:
  - Daily/Weekly/Monthly trends
  - Product line performance
  - Branch-wise analysis
- **Performance Indicators**:
  - Gross margin percentage
  - Sales quantity
  - Customer ratings

### 3. Customer Analysis
- **Segmentation**:
  - Member vs Normal customers
  - Gender-based analysis
  - Shopping time preferences
- **Behavior Patterns**:
  - Payment method preferences
  - Average transaction values
  - Product category preferences

### 4. Temporal Analysis
- **Time Patterns**:
  - Peak hours identification
  - Day-of-week trends
  - Monthly patterns
- **Seasonal Trends**:
  - Product performance by season
  - Customer behavior variations
  - Revenue fluctuations

## 📈 Visualizations

The project generates comprehensive visualizations in the `visualizations/advanced/` directory:

1. **Product Analysis** (`product_analysis.png`)
   - Revenue distribution
   - Performance scoring
   - Rating correlations

2. **Customer Analysis** (`customer_analysis.png`)
   - Customer type distribution
   - Gender-based patterns
   - Payment preferences

3. **Temporal Analysis** (`temporal_analysis.png`)
   - Hourly sales patterns
   - Seasonal trends
   - Day-of-week performance

## 📝 Reports

Detailed analysis findings are available in `reports/sales_analysis_report.md`, including:
- Statistical summaries
- Key performance indicators
- Strategic recommendations
- Trend analysis

## 🛠️ Technologies Used

- **Database**: MySQL 8.0
  - Complex SQL queries
  - Stored procedures
  - Views for analysis

- **Analysis**: Python 3.8+
  - pandas for data manipulation
  - NumPy for numerical operations
  - SciPy for statistical analysis

- **Visualization**: 
  - Matplotlib for basic plots
  - Seaborn for statistical visualizations

## 📧 Contact

Pranathi Doddipalli - [pranathidoddipalli@gmail.com](mailto:pranathidoddipalli@gmail.com)

Project Link: [https://github.com/pranathi-doddipalli/walmart_sales_sql](https://github.com/pranathi-doddipalli/walmart_sales_sql)

##  Acknowledgments

- Walmart for the dataset
- MySQL community for database support
- Python data science community

---

