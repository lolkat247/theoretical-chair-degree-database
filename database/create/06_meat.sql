CREATE TABLE Meat (
    product_id       INT UNSIGNED  PRIMARY KEY,
    cut_type         VARCHAR(50),
    is_frozen        BOOLEAN       NOT NULL DEFAULT FALSE,
    grade            VARCHAR(30),
    animal_source    VARCHAR(50),
    weight_per_unit  DECIMAL(10,3),
    CONSTRAINT chk_meat_weight_per_unit CHECK (weight_per_unit IS NULL OR weight_per_unit > 0),
    CONSTRAINT fk_meat_product
        FOREIGN KEY (product_id) REFERENCES Product(product_id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
