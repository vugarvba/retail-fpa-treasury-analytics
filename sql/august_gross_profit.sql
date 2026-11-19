-- Run against the sales table in retail_finance.db
SELECT
    strftime('%Y', date) AS year,
    ROUND(SUM(revenue), 2) AS revenue,
    ROUND(SUM(cogs), 2) AS cogs,
    ROUND(SUM(gross_profit), 2) AS gross_profit
FROM sales
WHERE strftime('%m', date) = '08'
GROUP BY strftime('%Y', date)
ORDER BY year;
