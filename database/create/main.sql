-- TCD Stocking Inc. — schema bootstrap
-- Source of truth for the EERD in latex/eerd.drawio

DROP DATABASE IF EXISTS tcd_stocking;
CREATE DATABASE tcd_stocking CHARACTER SET utf8mb4;
USE tcd_stocking;

-- Independent tables (no FKs)
SOURCE /sql/01_vendor.sql;
SOURCE /sql/02_warehouse.sql;
SOURCE /sql/03_customer.sql;

-- Product supertype (FK -> Vendor)
SOURCE /sql/04_product.sql;

-- Product subtypes (FK -> Product)
SOURCE /sql/05_produce.sql;
SOURCE /sql/06_meat.sql;
SOURCE /sql/07_dairy.sql;
SOURCE /sql/08_bakery.sql;
SOURCE /sql/09_deli.sql;
SOURCE /sql/10_frozen.sql;
SOURCE /sql/11_shelf_stable.sql;

-- Inventory (FK -> Warehouse, Product)
SOURCE /sql/12_inventory.sql;

-- Order chain
SOURCE /sql/13_order.sql;
SOURCE /sql/14_shipment.sql;
SOURCE /sql/15_order_line.sql;
SOURCE /sql/16_order_status_history.sql;

-- Disjoint subtype enforcement
SOURCE /sql/99_triggers.sql;
