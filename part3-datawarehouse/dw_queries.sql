Part 3 Task 3.2 — Analytical Queries
Database: dw_retail

USE dw_retail;
 
Q1: Total sales revenue by product category for each month
SELECT
    d.year,
    d.month,
    d.month_name,
    p.category,
    SUM(f.total_revenue)  AS total_revenue,
    SUM(f.units_sold)     AS total_units
FROM fact_sales f
JOIN dim_date    d ON f.date_id    = d.date_id
JOIN dim_product p ON f.product_id = p.product_id
GROUP BY d.year, d.month, d.month_name, p.category
ORDER BY d.year, d.month, p.category;
 
 
Q2: Top 2 performing stores by total revenue
SELECT
    s.store_id,
    s.store_name,
    s.store_city,
    SUM(f.total_revenue) AS total_revenue,
    SUM(f.units_sold)    AS total_units_sold
FROM fact_sales f
JOIN dim_store s ON f.store_id = s.store_id
GROUP BY s.store_id, s.store_name, s.store_city
ORDER BY total_revenue DESC
LIMIT 2;
 
 
Q3: Month-over-month sales trend across all stores
SELECT
    d.year,
    d.month,
    d.month_name,
    SUM(f.total_revenue)                          AS monthly_revenue,
    LAG(SUM(f.total_revenue)) OVER (
        ORDER BY d.year, d.month
    )                                             AS prev_month_revenue,
    ROUND(
        (SUM(f.total_revenue) - LAG(SUM(f.total_revenue)) OVER (
            ORDER BY d.year, d.month)
        ) / NULLIF(LAG(SUM(f.total_revenue)) OVER (
            ORDER BY d.year, d.month), 0) * 100
    , 2)                                          AS pct_change
FROM fact_sales f
JOIN dim_date d ON f.date_id = d.date_id
GROUP BY d.year, d.month, d.month_name
ORDER BY d.year, d.month;
