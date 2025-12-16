-- 01_create_tables.sql
-- Exact CREATE statements for the 3-table star schema

CREATE DATABASE IF NOT EXISTS business_sales_data;
USE business_sales_data;

-- =============================================================
-- 1. Products table (your original 599 Zara jackets)
-- =============================================================
DROP TABLE IF EXISTS products;
CREATE TABLE products (
    product_id       INT PRIMARY KEY,
    product_position VARCHAR(50),
    promotion        VARCHAR(10),
    product_category VARCHAR(50),
    seasonal         VARCHAR(10),
    sales_volume     INT,
    brand            VARCHAR(50),
    url              TEXT,
    name             TEXT,
    description      TEXT,
    price            DECIMAL(10,2),
    currency         VARCHAR(10),
    terms            VARCHAR(50),
    section          VARCHAR(20),        -- MAN / WOMAN
    season           VARCHAR(20),
    material         VARCHAR(100),
    origin           VARCHAR(50)
);

-- =============================================================
-- 2. Customers table
-- =============================================================
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
    customer_id   INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    email         VARCHAR(100) UNIQUE,
    gender        ENUM('Male','Female','Other'),
    age_group     VARCHAR(20),        -- 18-24, 25-34, 35-44, 45-54, 55+
    city          VARCHAR(50),
    country       VARCHAR(50),
    loyalty_level ENUM('Bronze','Silver','Gold','Platinum'),
    first_purchase DATE
);

-- =============================================================
-- 3. Sales table (fact table with foreign keys)
-- =============================================================
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (
    sale_id         INT PRIMARY KEY AUTO_INCREMENT,
    product_id     INT,
    customer_id    INT,
    sale_date      DATE,
    quantity       INT DEFAULT 1,
    unit_price     DECIMAL(10,2),
    revenue        DECIMAL(12,2) AS (quantity * unit_price) STORED,
    
    INDEX idx_product (product_id),
    INDEX idx_customer (customer_id),
    
    FOREIGN KEY (product_id)  REFERENCES products(product_id)   ON DELETE CASCADE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
);

SELECT 'All 3 tables created exactly as before!' AS status;