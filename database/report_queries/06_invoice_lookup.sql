SELECT
    totals.invoice_number,
    totals.invoice_date,
    c.first_name,
    c.last_name,
    o.order_date,
    p.product_name,
    ol.quantity,
    ol.unit_price,
    ROUND(ol.quantity * ol.unit_price, 2) AS line_total,
    totals.subtotal,
    totals.shipping_amount,
    totals.tax_amount,
    totals.invoice_total
FROM `Order` o
JOIN Customer c ON c.customer_id = o.customer_id
JOIN Shipment s ON s.order_id = o.order_id
JOIN Order_Line ol ON ol.shipment_id = s.shipment_id
JOIN Product p ON p.product_id = ol.product_id
JOIN vw_order_totals totals ON totals.order_id = o.order_id
WHERE c.first_name = 'Alice'
  AND c.last_name = 'Johnson'
  AND o.order_date = '2025-01-15'
ORDER BY p.product_name;
