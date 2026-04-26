CREATE TABLE Shelf_Stable (
    product_id          INT UNSIGNED  PRIMARY KEY,
    expiration_date     DATE,
    packaging_type      VARCHAR(50),
    shelf_life_months   INT UNSIGNED,
    is_canned           BOOLEAN       NOT NULL DEFAULT FALSE,
    serving_count       INT UNSIGNED,
    CONSTRAINT fk_shelf_stable_product
        FOREIGN KEY (product_id) REFERENCES Product(product_id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
