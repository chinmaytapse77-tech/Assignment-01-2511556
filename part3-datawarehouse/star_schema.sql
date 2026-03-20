Part 3 Task 3.1 — Star Schema Design
Dataset: retail_transactions.csv
 
CREATE DATABASE IF NOT EXISTS dw_retail;
USE dw_retail;
 
DROP TABLE IF EXISTS fact_sales;
DROP TABLE IF EXISTS dim_date;
DROP TABLE IF EXISTS dim_store;
DROP TABLE IF EXISTS dim_product;
 
DIMENSION TABLE 1: dim_date
Stores date breakdowns to enable time-based analysis

CREATE TABLE dim_date (
    date_id     INT          NOT NULL,
    full_date   DATE         NOT NULL,
    year        INT          NOT NULL,
    month       INT          NOT NULL,
    day         INT          NOT NULL,
    month_name  VARCHAR(20)  NOT NULL,
    quarter     INT          NOT NULL,
    PRIMARY KEY (date_id)
);
 
INSERT INTO dim_date (date_id, full_date, year, month, day, month_name, quarter) VALUES
(1,  '2023-01-02', 2023, 1,  2,  'January',   1),
(2,  '2023-01-04', 2023, 1,  4,  'January',   1),
(3,  '2023-01-05', 2023, 1,  5,  'January',   1),
(4,  '2023-01-06', 2023, 1,  6,  'January',   1),
(5,  '2023-01-07', 2023, 1,  7,  'January',   1),
(6,  '2023-01-08', 2023, 1,  8,  'January',   1),
(7,  '2023-01-09', 2023, 1,  9,  'January',   1),
(8,  '2023-01-10', 2023, 1,  10, 'January',   1),
(9,  '2023-01-11', 2023, 1,  11, 'January',   1),
(10, '2023-01-12', 2023, 1,  12, 'January',   1),
(11, '2023-01-13', 2023, 1,  13, 'January',   1),
(12, '2023-01-15', 2023, 1,  15, 'January',   1),
(13, '2023-02-05', 2023, 2,  5,  'February',  1),
(14, '2023-02-20', 2023, 2,  20, 'February',  1),
(15, '2023-03-10', 2023, 3,  10, 'March',     1);
 

DIMENSION TABLE 2: dim_store
Stores store details — city and region context

CREATE TABLE dim_store (
    store_id    INT          NOT NULL,
    store_name  VARCHAR(100) NOT NULL,
    store_city  VARCHAR(50)  NOT NULL,
    PRIMARY KEY (store_id)
);
 
INSERT INTO dim_store (store_id, store_name, store_city) VALUES
(1, 'Chennai Anna',    'Chennai'),
(2, 'Delhi South',     'Delhi'),
(3, 'Bangalore MG',    'Bangalore'),
(4, 'Pune FC Road',    'Pune'),
(5, 'Mumbai Central',  'Mumbai');
 
DIMENSION TABLE 3: dim_product
Stores product details — name, category, standard price

CREATE TABLE dim_product (
    product_id    INT           NOT NULL,
    product_name  VARCHAR(100)  NOT NULL,
    category      VARCHAR(50)   NOT NULL,
    unit_price    DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (product_id)
);
 
INSERT INTO dim_product (product_id, product_name, category, unit_price) VALUES
(1,  'Speaker',     'Electronics', 49262.78),
(2,  'Tablet',      'Electronics', 23226.12),
(3,  'Phone',       'Electronics', 48703.39),
(4,  'Smartwatch',  'Electronics', 58851.01),
(5,  'Atta 10kg',   'Groceries',   52464.00),
(6,  'Jeans',       'Clothing',     2317.47),
(7,  'Biscuits',    'Groceries',   27469.99),
(8,  'Jacket',      'Clothing',    30187.24),
(9,  'Laptop',      'Electronics', 42343.15),
(10, 'Milk 1L',     'Groceries',   43374.39),
(11, 'Saree',       'Clothing',    35451.81),
(12, 'Headphones',  'Electronics', 39854.96),
(13, 'Pulses 1kg',  'Groceries',   31604.47),
(14, 'T-Shirt',     'Clothing',    29770.19),
(15, 'Rice 5kg',    'Groceries',   52195.05),
(16, 'Oil 1L',      'Groceries',   26474.34);
 

FACT TABLE: fact_sales
Central table — stores measurable business events
Links to all 3 dimension tables via foreign keys
-- ------------------------------------------------------------
CREATE TABLE fact_sales (
    transaction_id  VARCHAR(20)   NOT NULL,
    date_id         INT           NOT NULL,
    store_id        INT           NOT NULL,
    product_id      INT           NOT NULL,
    units_sold      INT           NOT NULL,
    unit_price      DECIMAL(10,2) NOT NULL,
    total_revenue   DECIMAL(12,2) NOT NULL,
    PRIMARY KEY (transaction_id),
    CONSTRAINT fk_fs_date    FOREIGN KEY (date_id)    REFERENCES dim_date(date_id),
    CONSTRAINT fk_fs_store   FOREIGN KEY (store_id)   REFERENCES dim_store(store_id),
    CONSTRAINT fk_fs_product FOREIGN KEY (product_id) REFERENCES dim_product(product_id)
);
 
10 cleaned fact rows (dates normalized, categories standardized, nulls resolved)
INSERT INTO fact_sales (transaction_id, date_id, store_id, product_id, units_sold, unit_price, total_revenue) VALUES
('TXN5000', 1,  1, 1,  3,  49262.78,  147788.34),
('TXN5001', 10, 1, 2,  11, 23226.12,  255487.32),
('TXN5002', 3,  1, 3,  20, 48703.39,  974067.80),
('TXN5003', 4,  2, 2,  14, 23226.12,  325165.68),
('TXN5004', 12, 1, 4,  10, 58851.01,  588510.10),
('TXN5005', 2,  3, 5,  12, 52464.00,  629568.00),
('TXN5006', 6,  4, 4,  6,  58851.01,  353106.06),
('TXN5007', 11, 4, 6,  16, 2317.47,    37079.52),
('TXN5008', 9,  3, 7,  9,  27469.99,  247229.91),
('TXN5009', 8,  3, 4,  3,  58851.01,  176553.03);
 
