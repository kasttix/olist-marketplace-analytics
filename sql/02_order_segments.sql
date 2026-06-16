WITH order_stats AS (
    SELECT 
        order_id,
        SUM(item_total) AS order_value
    FROM orders_mart
    WHERE order_status = 'delivered'
    GROUP BY order_id
)
SELECT 
    CASE 
        WHEN order_value < 50 THEN '1. Low (до 50$)'
        WHEN order_value BETWEEN 50 AND 150 THEN '2. Medium (50$ - 150$)'
        ELSE '3. High (от 150$)'
    END AS check_category,
    COUNT(order_id) AS total_orders,
    ROUND(AVG(order_value)::numeric, 2) AS avg_check
FROM order_stats
GROUP BY 1
ORDER BY 1;