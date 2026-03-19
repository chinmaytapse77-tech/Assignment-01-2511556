Customers Table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY Not null,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL
);

Products Table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL
);

Sales Representatives Table
CREATE TABLE sales_reps (
    salesrep_id INT PRIMARY KEY,
    salesrep_name VARCHAR(100) NOT NULL
);

Orders Table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    salesrep_id INT NOT NULL,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (salesrep_id) REFERENCES sales_reps(salesrep_id)
);

Order Items Table
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
---

Sample Insert:
Customers
INSERT INTO customers VALUES
(1, 'Rahul Sharma', 'Mumbai'),
(2, 'Amit Verma', 'Delhi'),
(3, 'Sneha Patil', 'Mumbai'),
(4, 'Priya Singh', 'Bangalore'),
(5, 'Karan Mehta', 'Pune');

Products
INSERT INTO products VALUES
(101, 'Laptop', 60000),
(102, 'Mobile', 20000),
(103, 'Headphones', 2000),
(104, 'Tablet', 30000),
(105, 'Keyboard', 1500);

Sales Reps
INSERT INTO sales_reps VALUES
(1, 'John'),
(2, 'Alice'),
(3, 'David'),
(4, 'Emma'),
(5, 'Chris');

Orders
INSERT INTO orders VALUES
(1001, 1, 1, '2024-01-01'),
(1002, 2, 2, '2024-01-02'),
(1003, 3, 3, '2024-01-03'),
(1004, 4, 4, '2024-01-04'),
(1005, 5, 5, '2024-01-05');

Order Items
INSERT INTO order_items VALUES
(1, 1001, 101, 1),
(2, 1002, 102, 2),
(3, 1003, 103, 3),
(4, 1004, 104, 1),
(5, 1005, 105, 5);
