START TRANSACTION;

INSERT INTO `Order` (customer_id, order_date)
VALUES (1, '2026-04-26');

SET @order_id = LAST_INSERT_ID();

INSERT INTO Shipment (order_id, warehouse_id, ship_date, tracking_number)
VALUES (@order_id, 1, '2026-04-27', CONCAT('TRK-DEMO-', @order_id));

SET @shipment_id = LAST_INSERT_ID();

INSERT INTO Order_Line (shipment_id, product_id, quantity, unit_price)
SELECT @shipment_id, product_id, 3, unit_price
FROM Product
WHERE product_id = 1;

INSERT INTO Order_Status_History (order_id, status, changed_at, notes)
VALUES (@order_id, 'pending', '2026-04-26 09:00:00', 'Demonstration order created');

SELECT
    invoice_number,
    invoice_date,
    customer_name,
    subtotal,
    shipping_amount,
    tax_amount,
    invoice_total
FROM vw_order_totals
WHERE order_id = @order_id;

ROLLBACK;
