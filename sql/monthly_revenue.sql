-- Run against the sales table in retail_finance.db
SELECT
    strftime('%Y-%m', date) AS month,
    ROUND(SUM(revenue), 2) AS revenue,
    ROUND(SUM(cogs), 2) AS cogs,
    ROUND(SUM(gross_profit), 2) AS gross_profit,
    ROUND(
        100.0 * SUM(gross_profit)
        / NULLIF(SUM(revenue), 0), 2
    ) AS gross_margin_pct

FROM sales

GROUP BY strftime('%Y-%m', date)
ORDER BY month;
