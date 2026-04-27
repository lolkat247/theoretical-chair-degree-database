START TRANSACTION;

INSERT INTO Product (product_name, product_type, unit_price, weight, vendor_id)
VALUES ('Kimchi Slaw', 'Deli', 6.95, 0.500, 12);

SET @new_product_id = LAST_INSERT_ID();

INSERT INTO Deli (
    product_id,
    slice_thickness,
    is_prepackaged,
    serving_size,
    cure_method,
    sodium_content
) VALUES (
    @new_product_id,
    NULL,
    TRUE,
    '4 oz',
    'Prepared salad',
    280.00
);

SELECT
    p.product_id,
    p.product_name,
    p.product_type,
    p.unit_price,
    p.weight,
    p.vendor_id,
    d.slice_thickness,
    d.is_prepackaged,
    d.serving_size,
    d.cure_method,
    d.sodium_content
FROM Product p
JOIN Deli d ON d.product_id = p.product_id
WHERE p.product_id = @new_product_id;

ROLLBACK;
