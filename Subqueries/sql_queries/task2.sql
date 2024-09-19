WITH CustomerTotals AS (
    SELECT 
        c.person_id AS customer_id,
        p.surname,
        p.name,
        SUM(od.price * od.product_amount) AS total_expenses
    FROM 
        customer c
    JOIN 
        person p ON p.id = c.person_id
    LEFT JOIN 
        customer_order co ON co.customer_id = c.person_id
    LEFT JOIN 
        order_details od ON od.customer_order_id = co.id
    WHERE 
        p.birth_date BETWEEN '2000-01-01' AND '2010-12-31'
    GROUP BY 
        c.person_id, p.surname, p.name
),
AverageTotal AS (
    SELECT 
        AVG(total_expenses) AS avg_total
    FROM 
        CustomerTotals
)
SELECT 
    c.surname,
    c.name,
    c.total_expenses
FROM 
    CustomerTotals c
JOIN 
    AverageTotal a ON c.total_expenses > a.avg_total
ORDER BY 
    c.total_expenses ASC, 
    c.surname ASC;
