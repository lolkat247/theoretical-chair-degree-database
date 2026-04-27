SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(ol.order_line_id) AS qualifying_purchase_lines,
    SUM(ol.quantity) AS qualifying_units,
    ROUND(MIN(ol.unit_price), 2) AS min_unit_price,
    ROUND(MAX(ol.unit_price), 2) AS max_unit_price,
    ROUND(AVG(ol.unit_price), 2) AS avg_unit_price
FROM Customer c
JOIN `Order` o ON o.customer_id = c.customer_id
JOIN Shipment s ON s.order_id = o.order_id
JOIN Order_Line ol ON ol.shipment_id = s.shipment_id
WHERE ol.unit_price > 10.00
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY max_unit_price DESC, qualifying_purchase_lines DESC
LIMIT 3;
