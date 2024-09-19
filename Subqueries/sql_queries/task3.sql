SELECT 
       co.id AS order_id, 
       COUNT(DISTINCT od.product_id) AS items_count
FROM customer_order co
JOIN order_details od ON co.id = od.customer_order_id
WHERE co.operation_time BETWEEN '2021-01-01' AND '2021-12-31'
GROUP BY co.id
HAVING COUNT(DISTINCT od.product_id) > (
    SELECT AVG(order_items_count)
    FROM (
        SELECT COUNT(DISTINCT od2.product_id) AS order_items_count
        FROM customer_order co2
        JOIN order_details od2 ON co2.id = od2.customer_order_id
        GROUP BY co2.id
    ) AS avg_items_per_order
)
ORDER BY items_count ASC, co.id ASC;
