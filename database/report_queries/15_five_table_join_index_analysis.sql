SET @idx_exists := (
    SELECT COUNT(*)
    FROM information_schema.STATISTICS
    WHERE table_schema = DATABASE()
      AND table_name = 'Order_Line'
      AND index_name = 'idx_order_line_price_product_shipment'
);

SET @drop_idx_sql := IF(
    @idx_exists > 0,
    'DROP INDEX idx_order_line_price_product_shipment ON Order_Line',
    'SELECT ''Index was not present before timing'' AS info'
);

PREPARE drop_idx_stmt FROM @drop_idx_sql;
EXECUTE drop_idx_stmt;
DEALLOCATE PREPARE drop_idx_stmt;

SELECT 'BEFORE INDEX' AS analysis_step;

EXPLAIN
SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    o.order_date,
    w.warehouse_name,
    p.product_name,
    p.product_type,
    ol.quantity,
    ol.unit_price,
    ROUND(ol.quantity * ol.unit_price, 2) AS line_total
FROM Customer c
JOIN `Order` o ON o.customer_id = c.customer_id
JOIN Shipment s ON s.order_id = o.order_id
JOIN Warehouse w ON w.warehouse_id = s.warehouse_id
JOIN Order_Line ol ON ol.shipment_id = s.shipment_id
JOIN Product p ON p.product_id = ol.product_id
WHERE o.order_date >= '2025-04-01'
  AND p.product_type IN ('Deli', 'Shelf_Stable')
  AND ol.unit_price >= 10.00
  AND w.state IN ('CA', 'TX', 'PA')
ORDER BY ol.unit_price DESC, o.order_date DESC
LIMIT 15;

CREATE INDEX idx_order_line_price_product_shipment
    ON Order_Line(unit_price, product_id, shipment_id);

SELECT 'AFTER INDEX' AS analysis_step;

EXPLAIN
SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    o.order_date,
    w.warehouse_name,
    p.product_name,
    p.product_type,
    ol.quantity,
    ol.unit_price,
    ROUND(ol.quantity * ol.unit_price, 2) AS line_total
FROM Customer c
JOIN `Order` o ON o.customer_id = c.customer_id
JOIN Shipment s ON s.order_id = o.order_id
JOIN Warehouse w ON w.warehouse_id = s.warehouse_id
JOIN Order_Line ol ON ol.shipment_id = s.shipment_id
JOIN Product p ON p.product_id = ol.product_id
WHERE o.order_date >= '2025-04-01'
  AND p.product_type IN ('Deli', 'Shelf_Stable')
  AND ol.unit_price >= 10.00
  AND w.state IN ('CA', 'TX', 'PA')
ORDER BY ol.unit_price DESC, o.order_date DESC
LIMIT 15;
