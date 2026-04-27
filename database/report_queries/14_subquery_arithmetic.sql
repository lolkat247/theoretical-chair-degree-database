SELECT
    p.product_id,
    p.product_name,
    p.unit_price,
    sales.units_sold,
    sales.gross_sales,
    ROUND(sales.gross_sales / sales.units_sold, 2) AS average_realized_price,
    ROUND((sales.gross_sales * 0.25), 2) AS estimated_profit_at_25_percent
FROM Product p
JOIN (
    SELECT
        product_id,
        SUM(quantity) AS units_sold,
        ROUND(SUM(quantity * unit_price), 2) AS gross_sales
    FROM Order_Line
    GROUP BY product_id
) sales ON sales.product_id = p.product_id
WHERE sales.gross_sales > (
    SELECT AVG(product_sales.total_sales)
    FROM (
        SELECT SUM(quantity * unit_price) AS total_sales
        FROM Order_Line
        GROUP BY product_id
    ) product_sales
)
ORDER BY estimated_profit_at_25_percent DESC
LIMIT 10;
