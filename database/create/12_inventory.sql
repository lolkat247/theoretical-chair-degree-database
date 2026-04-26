CREATE TABLE Inventory (
    inventory_id        INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    warehouse_id        INT UNSIGNED  NOT NULL,
    product_id          INT UNSIGNED  NOT NULL,
    quantity            INT UNSIGNED  NOT NULL DEFAULT 0,
    restock_threshold   INT UNSIGNED  NOT NULL DEFAULT 0,
    last_restocked      DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uq_inventory_warehouse_product UNIQUE (warehouse_id, product_id),
    CONSTRAINT fk_inventory_warehouse
        FOREIGN KEY (warehouse_id) REFERENCES Warehouse(warehouse_id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_inventory_product
        FOREIGN KEY (product_id)   REFERENCES Product(product_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
