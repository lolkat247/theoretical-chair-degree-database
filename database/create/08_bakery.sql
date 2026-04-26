CREATE TABLE Bakery (
    product_id        INT UNSIGNED  PRIMARY KEY,
    is_gluten_free    BOOLEAN       NOT NULL DEFAULT FALSE,
    shelf_life_days   INT UNSIGNED,
    contains_nuts     BOOLEAN       NOT NULL DEFAULT FALSE,
    serving_size      VARCHAR(50),
    bake_date         DATE,
    CONSTRAINT fk_bakery_product
        FOREIGN KEY (product_id) REFERENCES Product(product_id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
