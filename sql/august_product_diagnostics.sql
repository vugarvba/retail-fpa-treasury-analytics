-- Run against the sales table in retail_finance.db
SELECT
    product,
    ROUND(SUM(
        CASE WHEN strftime('%Y', date) = '2025'
        THEN revenue ELSE 0 END
    ), 2) AS revenue_2025,

    ROUND(SUM(
        CASE WHEN strftime('%Y', date) = '2026'
        THEN revenue ELSE 0 END
    ), 2) AS revenue_2026

FROM sales
WHERE strftime('%m', date) = '08'
GROUP BY product
ORDER BY product;
