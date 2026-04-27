CREATE OR REPLACE VIEW vw_current_order_status AS
SELECT
    osh.order_id,
    osh.status,
    osh.changed_at,
    osh.notes
FROM Order_Status_History osh
JOIN (
    SELECT order_id, MAX(changed_at) AS changed_at
    FROM Order_Status_History
    GROUP BY order_id
) latest
    ON latest.order_id = osh.order_id
   AND latest.changed_at = osh.changed_at;

CREATE OR REPLACE VIEW vw_current_inventory AS
SELECT
    i.inventory_id,
    w.warehouse_id,
    w.warehouse_name,
    w.city AS warehouse_city,
    w.state AS warehouse_state,
    p.product_id,
    p.product_name,
    p.product_type,
    p.unit_price,
    v.vendor_name,
    i.quantity,
    i.restock_threshold,
    i.last_restocked,
    CASE
        WHEN i.quantity <= i.restock_threshold THEN 'RESTOCK'
        ELSE 'OK'
    END AS inventory_status
FROM Inventory i
JOIN Warehouse w ON w.warehouse_id = i.warehouse_id
JOIN Product p ON p.product_id = i.product_id
LEFT JOIN Vendor v ON v.vendor_id = p.vendor_id;

CREATE OR REPLACE VIEW vw_order_totals AS
SELECT
    o.order_id,
    CONCAT('ORD-', LPAD(o.order_id, 6, '0')) AS invoice_number,
    o.order_date AS invoice_date,
    o.order_date,
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    ROUND(SUM(ol.quantity * ol.unit_price), 2) AS subtotal,
    ROUND(SUM(DISTINCT w.shipping_cost), 2) AS shipping_amount,
    0.0725 AS tax_rate,
    ROUND(SUM(ol.quantity * ol.unit_price) * 0.0725, 2) AS tax_amount,
    ROUND(SUM(ol.quantity * ol.unit_price) + SUM(DISTINCT w.shipping_cost) + (SUM(ol.quantity * ol.unit_price) * 0.0725), 2) AS invoice_total
FROM `Order` o
JOIN Customer c ON c.customer_id = o.customer_id
JOIN Shipment s ON s.order_id = o.order_id
JOIN Warehouse w ON w.warehouse_id = s.warehouse_id
JOIN Order_Line ol ON ol.shipment_id = s.shipment_id
GROUP BY
    o.order_id,
    o.order_date,
    c.customer_id,
    c.first_name,
    c.last_name;
