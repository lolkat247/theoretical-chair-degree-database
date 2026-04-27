DELIMITER //

CREATE PROCEDURE sp_customer_purchase_summary(IN min_unit_price DECIMAL(10,2))
BEGIN
    SELECT
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        COUNT(DISTINCT o.order_id) AS order_count,
        COUNT(ol.order_line_id) AS line_count,
        SUM(ol.quantity) AS units_purchased,
        ROUND(SUM(ol.quantity * ol.unit_price), 2) AS merchandise_total,
        ROUND(AVG(ol.unit_price), 2) AS avg_unit_price
    FROM Customer c
    JOIN `Order` o ON o.customer_id = c.customer_id
    JOIN Shipment s ON s.order_id = o.order_id
    JOIN Order_Line ol ON ol.shipment_id = s.shipment_id
    WHERE ol.unit_price > min_unit_price
    GROUP BY c.customer_id, c.first_name, c.last_name
    ORDER BY merchandise_total DESC, customer_name
    LIMIT 15;
END//

DELIMITER ;
