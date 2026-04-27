SELECT
    p.product_id,
    p.product_name,
    p.product_type,
    SUM(ol.quantity) AS units_sold_in_range,
    SUM(i.quantity) AS current_units_on_hand,
    MIN(o.order_date) AS first_sale_in_range,
    MAX(o.order_date) AS last_sale_in_range
FROM Product p
JOIN Order_Line ol ON ol.product_id = p.product_id
JOIN Shipment s ON s.shipment_id = ol.shipment_id
JOIN `Order` o ON o.order_id = s.order_id
JOIN Inventory i ON i.product_id = p.product_id
WHERE o.order_date BETWEEN '2025-04-01' AND '2025-06-30'
GROUP BY p.product_id, p.product_name, p.product_type
ORDER BY units_sold_in_range DESC, p.product_name
LIMIT 25;
