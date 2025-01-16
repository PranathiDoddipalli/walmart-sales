-- Create the main database
CREATE DATABASE IF NOT EXISTS WalmartSales;
USE WalmartSales;

-- Create dimension tables
CREATE TABLE IF NOT EXISTS branches (
    branch_id VARCHAR(5) PRIMARY KEY,
    city VARCHAR(30) NOT NULL,
    address TEXT,
    region VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS customer_types (
    customer_type_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_type VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS product_lines (
    product_line_id INT AUTO_INCREMENT PRIMARY KEY,
    product_line VARCHAR(100) NOT NULL UNIQUE,
    category VARCHAR(50),
    sub_category VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS payment_methods (
    payment_method_id INT AUTO_INCREMENT PRIMARY KEY,
    payment_method VARCHAR(15) NOT NULL UNIQUE
);

-- Create the main sales table with foreign keys
CREATE TABLE IF NOT EXISTS sales (
    invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch_id VARCHAR(5) NOT NULL,
    customer_type_id INT NOT NULL,
    gender VARCHAR(10) NOT NULL,
    product_line_id INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    VAT FLOAT(6,4) NOT NULL,
    total DECIMAL(12,4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment_method_id INT NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct FLOAT(11,9),
    gross_income DECIMAL(12,4) NOT NULL,
    rating FLOAT(2,1),
    
    -- Additional engineered columns
    time_of_day VARCHAR(20),
    day_name VARCHAR(10),
    month_name VARCHAR(10),
    quarter INT,
    season VARCHAR(10),
    
    -- Customer segmentation
    customer_segment VARCHAR(50),
    
    -- Performance metrics
    sales_performance_index DECIMAL(10,2),
    
    FOREIGN KEY (branch_id) REFERENCES branches(branch_id),
    FOREIGN KEY (customer_type_id) REFERENCES customer_types(customer_type_id),
    FOREIGN KEY (product_line_id) REFERENCES product_lines(product_line_id),
    FOREIGN KEY (payment_method_id) REFERENCES payment_methods(payment_method_id)
);

-- Create indices for better query performance
CREATE INDEX idx_date ON sales(date);
CREATE INDEX idx_product_line ON sales(product_line_id);
CREATE INDEX idx_customer_type ON sales(customer_type_id);
CREATE INDEX idx_branch ON sales(branch_id);
