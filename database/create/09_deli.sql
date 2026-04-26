CREATE TABLE Deli (
    product_id       INT UNSIGNED  PRIMARY KEY,
    slice_thickness  DECIMAL(5,2),
    is_prepackaged   BOOLEAN       NOT NULL DEFAULT FALSE,
    serving_size     VARCHAR(50),
    cure_method      VARCHAR(50),
    sodium_content   DECIMAL(8,2),
    CONSTRAINT chk_deli_slice_thickness CHECK (slice_thickness IS NULL OR slice_thickness > 0),
    CONSTRAINT chk_deli_sodium_content  CHECK (sodium_content  IS NULL OR sodium_content >= 0),
    CONSTRAINT fk_deli_product
        FOREIGN KEY (product_id) REFERENCES Product(product_id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
