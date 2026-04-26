CREATE TABLE Dairy (
    product_id        INT UNSIGNED  PRIMARY KEY,
    fat_percentage    DECIMAL(5,2),
    pasteurized       BOOLEAN       NOT NULL DEFAULT FALSE,
    shelf_life_days   INT UNSIGNED,
    lactose_free      BOOLEAN       NOT NULL DEFAULT FALSE,
    storage_temp      DECIMAL(5,2),
    CONSTRAINT chk_dairy_fat_percentage CHECK (fat_percentage IS NULL OR (fat_percentage BETWEEN 0 AND 100)),
    CONSTRAINT fk_dairy_product
        FOREIGN KEY (product_id) REFERENCES Product(product_id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
