CREATE DATABASE IF NOT EXISTS assignment_db;
USE assignment_db;

TABLE 1: customers
CREATE TABLE customers (
    customer_id    VARCHAR(10)  NOT NULL,
    customer_name  VARCHAR(100) NOT NULL,
    customer_email VARCHAR(100) NOT NULL,
    customer_city  VARCHAR(50)  NOT NULL,
    PRIMARY KEY (customer_id)
);
 
INSERT INTO customers (customer_id, customer_name, customer_email, customer_city) VALUES
('C001', 'Rohan Mehta',  'rohan@gmail.com',  'Mumbai'),
('C002', 'Priya Sharma', 'priya@gmail.com',  'Delhi'),
('C003', 'Amit Verma',   'amit@gmail.com',   'Bangalore'),
('C004', 'Sneha Iyer',   'sneha@gmail.com',  'Chennai'),
('C005', 'Vikram Singh', 'vikram@gmail.com', 'Mumbai'),
('C006', 'Neha Gupta',   'neha@gmail.com',   'Delhi'),
('C007', 'Arjun Nair',   'arjun@gmail.com',  'Bangalore'),
('C008', 'Kavya Rao',    'kavya@gmail.com',  'Hyderabad');
 
 
TABLE 2: products
CREATE TABLE products (
    product_id   VARCHAR(10)   NOT NULL,
    product_name VARCHAR(100)  NOT NULL,
    category     VARCHAR(50)   NOT NULL,
    unit_price   DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (product_id)
);
 
INSERT INTO products (product_id, product_name, category, unit_price) VALUES
('P001', 'Laptop',        'Electronics', 55000.00),
('P002', 'Mouse',         'Electronics',   800.00),
('P003', 'Desk Chair',    'Furniture',    8500.00),
('P004', 'Notebook',      'Stationery',    120.00),
('P005', 'Headphones',    'Electronics',  3200.00),
('P006', 'Standing Desk', 'Furniture',   22000.00),
('P007', 'Pen Set',       'Stationery',    250.00),
('P008', 'Webcam',        'Electronics',  2100.00);
 
 
TABLE 3: sales_reps
CREATE TABLE sales_reps (
    sales_rep_id    VARCHAR(10)  NOT NULL,
    sales_rep_name  VARCHAR(100) NOT NULL,
    sales_rep_email VARCHAR(100) NOT NULL,
    office_address  VARCHAR(200) NOT NULL,
    PRIMARY KEY (sales_rep_id)
);
 
INSERT INTO sales_reps (sales_rep_id, sales_rep_name, sales_rep_email, office_address) VALUES
('SR01', 'Deepak Joshi', 'deepak@corp.com', 'Mumbai HQ, Nariman Point, Mumbai - 400021'),
('SR02', 'Anita Desai',  'anita@corp.com',  'Delhi Office, Connaught Place, New Delhi - 110001'),
('SR03', 'Ravi Kumar',   'ravi@corp.com',   'South Zone, MG Road, Bangalore - 560001');
 
 
TABLE 4: orders (MUST be created last — references all 3 tables above)
CREATE TABLE orders (
    order_id     VARCHAR(10)   NOT NULL,
    customer_id  VARCHAR(10)   NOT NULL,
    product_id   VARCHAR(10)   NOT NULL,
    sales_rep_id VARCHAR(10)   NOT NULL,
    quantity     INT           NOT NULL,
    unit_price   DECIMAL(10,2) NOT NULL,
    total_value  DECIMAL(10,2) NOT NULL,
    order_date   DATE          NOT NULL,
    PRIMARY KEY (order_id),
    CONSTRAINT fk_customer  FOREIGN KEY (customer_id)  REFERENCES customers(customer_id),
    CONSTRAINT fk_product   FOREIGN KEY (product_id)   REFERENCES products(product_id),
    CONSTRAINT fk_sales_rep FOREIGN KEY (sales_rep_id) REFERENCES sales_reps(sales_rep_id)
);
 
INSERT INTO orders (order_id, customer_id, product_id, sales_rep_id, quantity, unit_price, total_value, order_date) VALUES
('ORD1027', 'C002', 'P004', 'SR02', 4,  120.00,    480.00, '2023-11-02'),
('ORD1114', 'C001', 'P007', 'SR01', 2,  250.00,    500.00, '2023-08-06'),
('ORD1153', 'C006', 'P007', 'SR01', 3,  250.00,    750.00, '2023-02-14'),
('ORD1002', 'C002', 'P005', 'SR02', 1, 3200.00,   3200.00, '2023-01-17'),
('ORD1118', 'C006', 'P007', 'SR02', 5,  250.00,   1250.00, '2023-11-10'),
('ORD1132', 'C003', 'P007', 'SR02', 5,  250.00,   1250.00, '2023-03-07'),
('ORD1037', 'C002', 'P007', 'SR03', 2,  250.00,    500.00, '2023-03-06'),
('ORD1075', 'C005', 'P003', 'SR03', 3, 8500.00,  25500.00, '2023-04-18'),
('ORD1083', 'C006', 'P007', 'SR01', 2,  250.00,    500.00, '2023-07-03'),
('ORD1091', 'C001', 'P006', 'SR01', 3,22000.00,  66000.00, '2023-07-24');
