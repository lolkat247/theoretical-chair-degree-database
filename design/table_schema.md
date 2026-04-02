# Table Schema

## Customer
- customer_id (PK, AUTO_INCREMENT)
- first_name (NOT NULL)
- last_name (NOT NULL)
- email
- phone
- address
- city
- state
- zip_code

## Product (supertype, disjoint)
- product_id (PK, AUTO_INCREMENT)
- product_name (NOT NULL)
- product_type (discriminator)
- unit_price
- weight
- vendor_id (FK)

## Produce
- product_id (PK, FK)
- is_organic
- shelf_life_days
- storage_temp
- origin_region
- season

## Meat
- product_id (PK, FK)
- cut_type
- is_frozen
- grade
- animal_source
- weight_per_unit

## Dairy
- product_id (PK, FK)
- fat_percentage
- pasteurized
- shelf_life_days
- lactose_free
- storage_temp

## Bakery
- product_id (PK, FK)
- is_gluten_free
- shelf_life_days
- contains_nuts
- serving_size
- bake_date

## Deli
- product_id (PK, FK)
- slice_thickness
- is_prepackaged
- serving_size
- cure_method
- sodium_content

## Frozen
- product_id (PK, FK)
- freeze_date
- storage_temp
- thaw_time_hours
- is_raw
- packaging_type

## Shelf_Stable
- product_id (PK, FK)
- expiration_date
- packaging_type
- shelf_life_months
- is_canned
- serving_count

## Vendor
- vendor_id (PK, AUTO_INCREMENT)
- vendor_name (NOT NULL)
- country
- contact_name
- contact_email
- contact_phone

## Warehouse
- warehouse_id (PK, AUTO_INCREMENT)
- warehouse_name (NOT NULL)
- address
- city
- state
- shipping_cost
- import_cost

## Inventory
- inventory_id (PK, AUTO_INCREMENT)
- warehouse_id (FK, NOT NULL)
- product_id (FK, NOT NULL)
- quantity
- restock_threshold
- last_restocked

## Order
- order_id (PK, AUTO_INCREMENT)
- customer_id (FK, NOT NULL)
- order_date (NOT NULL)

Current status is derived from the most recent Order_Status_History row via a view.

## Shipment
- shipment_id (PK, AUTO_INCREMENT)
- order_id (FK, NOT NULL)
- warehouse_id (FK, NOT NULL)
- ship_date
- tracking_number

## Order_Line
- order_line_id (PK, AUTO_INCREMENT)
- shipment_id (FK, NOT NULL)
- product_id (FK, NOT NULL)
- quantity (NOT NULL)
- unit_price (NOT NULL)

## Order_Status_History
- status_history_id (PK, AUTO_INCREMENT)
- order_id (FK, NOT NULL)
- status (NOT NULL)
- changed_at (NOT NULL)
- notes

Invoice totals are derived from Order_Line (quantity * unit_price), not stored.
