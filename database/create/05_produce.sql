CREATE TABLE Produce (
    product_id        INT UNSIGNED   PRIMARY KEY,
    is_organic        BOOLEAN        NOT NULL DEFAULT FALSE,
    shelf_life_days   INT UNSIGNED,
    storage_temp      DECIMAL(5,2),
    origin_region     VARCHAR(80),
    season            VARCHAR(20),
    CONSTRAINT fk_produce_product
        FOREIGN KEY (product_id) REFERENCES Product(product_id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
