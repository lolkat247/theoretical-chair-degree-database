SELECT
    warehouse_name,
    product_id,
    product_name,
    product_type,
    vendor_name,
    quantity,
    restock_threshold,
    inventory_status
FROM vw_current_inventory
WHERE product_type = 'Deli'
ORDER BY warehouse_name, product_name;
