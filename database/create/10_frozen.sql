CREATE TABLE Frozen (
    product_id        INT UNSIGNED  PRIMARY KEY,
    freeze_date       DATE,
    storage_temp      DECIMAL(5,2),
    thaw_time_hours   INT UNSIGNED,
    is_raw            BOOLEAN       NOT NULL DEFAULT FALSE,
    packaging_type    VARCHAR(50),
    CONSTRAINT fk_frozen_product
        FOREIGN KEY (product_id) REFERENCES Product(product_id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
