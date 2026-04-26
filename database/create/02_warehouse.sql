CREATE TABLE Warehouse (
    warehouse_id    INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    warehouse_name  VARCHAR(100)   NOT NULL,
    address         VARCHAR(200),
    city            VARCHAR(100),
    state           VARCHAR(60),
    shipping_cost   DECIMAL(10,2)  NOT NULL DEFAULT 0.00,
    import_cost     DECIMAL(10,2)  NOT NULL DEFAULT 0.00,
    CONSTRAINT chk_warehouse_shipping_cost CHECK (shipping_cost >= 0),
    CONSTRAINT chk_warehouse_import_cost   CHECK (import_cost   >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
