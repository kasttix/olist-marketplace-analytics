WITH monthly_sales AS (
    SELECT 
        TO_CHAR(order_purchase_timestamp::timestamp, 'YYYY-MM') AS sales_month,
        SUM(item_total) AS total_revenue,
        COUNT(DISTINCT order_id) AS total_orders
    FROM orders_mart
    WHERE order_status = 'delivered'
    GROUP BY 1
)
SELECT 
    sales_month,
    total_revenue,
    total_orders,
    ROUND(AVG(total_revenue) OVER (
        ORDER BY sales_month 
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    )::numeric, 2) AS rolling_3_month_avg_revenue
FROM monthly_sales
ORDER BY sales_month;