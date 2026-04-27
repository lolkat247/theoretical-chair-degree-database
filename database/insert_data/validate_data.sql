-- Data Validation & Integrity Checks
-- Comprehensive check of all seeded data

-- =========================================================
-- 1. ROW COUNT VERIFICATION (minimum 20+ per main table)
-- =========================================================
SELECT '=== ROW COUNTS ===' as check_name;
SELECT 'Vendor' as table_name, COUNT(*) as row_count FROM Vendor;
SELECT 'Warehouse' as table_name, COUNT(*) as row_count FROM Warehouse;
SELECT 'Customer' as table_name, COUNT(*) as row_count FROM Customer;
SELECT 'Product' as table_name, COUNT(*) as row_count FROM Product;
SELECT 'Inventory' as table_name, COUNT(*) as row_count FROM Inventory;
SELECT 'Order' as table_name, COUNT(*) as row_count FROM `Order`;
SELECT 'Shipment' as table_name, COUNT(*) as row_count FROM Shipment;
SELECT 'Order_Line' as table_name, COUNT(*) as row_count FROM Order_Line;
SELECT 'Order_Status_History' as table_name, COUNT(*) as row_count FROM Order_Status_History;

-- =========================================================
-- 2. PRODUCT SUBTYPE DISTRIBUTION
-- =========================================================
SELECT '=== PRODUCT SUBTYPE DISTRIBUTION ===' as check_name;
SELECT 'Produce' as subtype, COUNT(*) as product_count FROM Produce;
SELECT 'Meat' as subtype, COUNT(*) as product_count FROM Meat;
SELECT 'Dairy' as subtype, COUNT(*) as product_count FROM Dairy;
SELECT 'Bakery' as subtype, COUNT(*) as product_count FROM Bakery;
SELECT 'Frozen' as subtype, COUNT(*) as product_count FROM Frozen;
SELECT 'Shelf_Stable' as subtype, COUNT(*) as product_count FROM Shelf_Stable;
SELECT 'Deli' as subtype, COUNT(*) as product_count FROM Deli;

-- =========================================================
-- 3. FOREIGN KEY INTEGRITY CHECKS
-- =========================================================
SELECT '=== FOREIGN KEY INTEGRITY ===' as check_name;

-- Check Product references valid Vendors
SELECT 'Products with invalid vendor_id' as check_type, COUNT(*) as count 
FROM Product p 
WHERE p.vendor_id NOT IN (SELECT vendor_id FROM Vendor);

-- Check Inventory references valid Warehouses & Products
SELECT 'Inventory with invalid warehouse_id' as check_type, COUNT(*) as count 
FROM Inventory i 
WHERE i.warehouse_id NOT IN (SELECT warehouse_id FROM Warehouse);

SELECT 'Inventory with invalid product_id' as check_type, COUNT(*) as count 
FROM Inventory i 
WHERE i.product_id NOT IN (SELECT product_id FROM Product);

-- Check Orders reference valid Customers
SELECT 'Orders with invalid customer_id' as check_type, COUNT(*) as count 
FROM `Order` o 
WHERE o.customer_id NOT IN (SELECT customer_id FROM Customer);

-- Check Shipments reference valid Orders & Warehouses
SELECT 'Shipments with invalid order_id' as check_type, COUNT(*) as count 
FROM Shipment s 
WHERE s.order_id NOT IN (SELECT order_id FROM `Order`);

SELECT 'Shipments with invalid warehouse_id' as check_type, COUNT(*) as count 
FROM Shipment s 
WHERE s.warehouse_id NOT IN (SELECT warehouse_id FROM Warehouse);

-- Check Order_Line references valid Shipments & Products
SELECT 'Order_Line with invalid shipment_id' as check_type, COUNT(*) as count 
FROM Order_Line ol 
WHERE ol.shipment_id NOT IN (SELECT shipment_id FROM Shipment);

SELECT 'Order_Line with invalid product_id' as check_type, COUNT(*) as count 
FROM Order_Line ol 
WHERE ol.product_id NOT IN (SELECT product_id FROM Product);

-- Check Order_Status_History references valid Orders
SELECT 'Order_Status_History with invalid order_id' as check_type, COUNT(*) as count 
FROM Order_Status_History osh 
WHERE osh.order_id NOT IN (SELECT order_id FROM `Order`);

-- =========================================================
-- 4. DATA CONSISTENCY CHECKS
-- =========================================================
SELECT '=== DATA CONSISTENCY ===' as check_name;

-- Check for NULL in required fields
SELECT 'Null vendor names' as check_type, COUNT(*) as count FROM Vendor WHERE vendor_name IS NULL;
SELECT 'Null product names' as check_type, COUNT(*) as count FROM Product WHERE product_name IS NULL;
SELECT 'Null customer names' as check_type, COUNT(*) as count FROM Customer WHERE first_name IS NULL OR last_name IS NULL;
SELECT 'Null warehouse names' as check_type, COUNT(*) as count FROM Warehouse WHERE warehouse_name IS NULL;

-- Check for invalid prices (negative or zero)
SELECT 'Products with invalid price (<= 0)' as check_type, COUNT(*) as count 
FROM Product WHERE unit_price <= 0;

-- Check for invalid inventory quantities
SELECT 'Inventory with invalid quantity (<= 0)' as check_type, COUNT(*) as count 
FROM Inventory WHERE quantity <= 0;

-- Check for invalid order line quantities
SELECT 'Order_Line with invalid quantity (<= 0)' as check_type, COUNT(*) as count 
FROM Order_Line WHERE quantity <= 0;

-- =========================================================
-- 5. LOGICAL CONSISTENCY
-- =========================================================
SELECT '=== LOGICAL CONSISTENCY ===' as check_type;

-- Orders should have shipments
SELECT 'Orders without shipments' as check_type, COUNT(*) as count
FROM `Order` o 
LEFT JOIN Shipment s ON o.order_id = s.order_id 
WHERE s.shipment_id IS NULL;

-- Shipments should have order lines
SELECT 'Shipments without order lines' as check_type, COUNT(*) as count
FROM Shipment s 
LEFT JOIN Order_Line ol ON s.shipment_id = ol.shipment_id 
WHERE ol.order_line_id IS NULL;

-- Orders should have status history
SELECT 'Orders without status history' as check_type, COUNT(*) as count
FROM `Order` o 
LEFT JOIN Order_Status_History osh ON o.order_id = osh.order_id 
WHERE osh.status_history_id IS NULL;

-- =========================================================
-- 6. DATA VARIETY CHECK
-- =========================================================
SELECT '=== DATA VARIETY ===' as check_type;

-- Unique vendors in Product table
SELECT 'Unique vendors' as metric, COUNT(DISTINCT vendor_id) as count FROM Product;

-- Unique warehouses in Inventory
SELECT 'Unique warehouses' as metric, COUNT(DISTINCT warehouse_id) as count FROM Inventory;

-- Order date range
SELECT 'Earliest order date' as metric, MIN(order_date) as date_value FROM `Order`
UNION ALL
SELECT 'Latest order date' as metric, MAX(order_date) as date_value FROM `Order`;

-- Order status distribution
SELECT 'Order statuses' as metric, status as detail, COUNT(*) as count 
FROM Order_Status_History 
WHERE changed_at = (SELECT MAX(changed_at) FROM Order_Status_History osh2 WHERE osh2.order_id = Order_Status_History.order_id)
GROUP BY status;

-- =========================================================
-- 7. SUMMARY REPORT
-- =========================================================
SELECT '=== SUMMARY ===' as report;
SELECT CONCAT('Total records across all tables: ', 
  (SELECT COUNT(*) FROM Vendor) +
  (SELECT COUNT(*) FROM Warehouse) +
  (SELECT COUNT(*) FROM Customer) +
  (SELECT COUNT(*) FROM Product) +
  (SELECT COUNT(*) FROM Inventory) +
  (SELECT COUNT(*) FROM `Order`) +
  (SELECT COUNT(*) FROM Shipment) +
  (SELECT COUNT(*) FROM Order_Line) +
  (SELECT COUNT(*) FROM Order_Status_History)
) as total_records;
