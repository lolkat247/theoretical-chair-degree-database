-- Synthetic expansion data for assignment row-count requirements.
-- Adds 500 customers, orders, shipments, order lines, and status rows.

CREATE TEMPORARY TABLE seq_project_data (n INT UNSIGNED PRIMARY KEY);

INSERT INTO seq_project_data
WITH RECURSIVE seq AS (
    SELECT 21 AS n
    UNION ALL
    SELECT n + 1 FROM seq WHERE n < 520
)
SELECT n FROM seq;

INSERT INTO Customer (first_name, last_name, email, phone, address, city, state, zip_code)
SELECT
    CONCAT('Generated', n),
    CONCAT('Customer', n),
    CONCAT('generated.customer', n, '@example.com'),
    CONCAT('555-', LPAD(n, 4, '0')),
    CONCAT(n, ' Project Data Ave'),
    CASE n % 5
        WHEN 0 THEN 'Los Angeles'
        WHEN 1 THEN 'Chicago'
        WHEN 2 THEN 'Houston'
        WHEN 3 THEN 'Phoenix'
        ELSE 'Miami'
    END,
    CASE n % 5
        WHEN 0 THEN 'CA'
        WHEN 1 THEN 'IL'
        WHEN 2 THEN 'TX'
        WHEN 3 THEN 'AZ'
        ELSE 'FL'
    END,
    LPAD(90000 + n, 5, '0')
FROM seq_project_data;

INSERT INTO `Order` (customer_id, order_date)
SELECT n, DATE_ADD('2025-06-01', INTERVAL n - 21 DAY)
FROM seq_project_data;

INSERT INTO Shipment (order_id, warehouse_id, ship_date, tracking_number)
SELECT
    n,
    ((n - 1) % 10) + 1,
    DATE_ADD('2025-06-02', INTERVAL n - 21 DAY),
    CONCAT('TRK', LPAD(n, 6, '0'))
FROM seq_project_data;

INSERT INTO Order_Line (shipment_id, product_id, quantity, unit_price)
SELECT
    n,
    ((n - 1) % 135) + 1,
    (n % 5) + 1,
    p.unit_price
FROM seq_project_data seq
JOIN Product p ON p.product_id = ((seq.n - 1) % 135) + 1;

INSERT INTO Order_Status_History (order_id, status, changed_at, notes)
SELECT
    n,
    CASE n % 10
        WHEN 0 THEN 'unable_to_fulfill'
        WHEN 1 THEN 'cancelled'
        WHEN 2 THEN 'processing'
        ELSE 'delivered'
    END,
    DATE_ADD('2025-06-02 12:00:00', INTERVAL n - 21 DAY),
    'Synthetic current status for project row-count requirement'
FROM seq_project_data;

DROP TEMPORARY TABLE seq_project_data;
