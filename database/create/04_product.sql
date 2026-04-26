CREATE TABLE Product (
    product_id    INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    product_name  VARCHAR(150)  NOT NULL,
    product_type  ENUM('Produce','Meat','Dairy','Bakery','Deli','Frozen','Shelf_Stable') NOT NULL,
    unit_price    DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    weight        DECIMAL(10,3),
    vendor_id     INT UNSIGNED,
    CONSTRAINT chk_product_unit_price CHECK (unit_price >= 0),
    CONSTRAINT chk_product_weight     CHECK (weight IS NULL OR weight > 0),
    CONSTRAINT fk_product_vendor
        FOREIGN KEY (vendor_id) REFERENCES Vendor(vendor_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
