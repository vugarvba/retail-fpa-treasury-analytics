-- Run against the sales table in retail_finance.db
SELECT
    strftime('%Y', date) AS year,
    SUM(quantity) AS units_sold,
    ROUND(SUM(revenue), 2) AS revenue,
    ROUND(
        SUM(revenue) * 1.0 / SUM(quantity), 2
    ) AS avg_selling_price
FROM sales
WHERE product = 'Laptop'
  AND strftime('%m', date) = '08'
GROUP BY strftime('%Y', date)
ORDER BY year;
