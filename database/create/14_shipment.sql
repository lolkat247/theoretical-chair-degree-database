CREATE TABLE Shipment (
    shipment_id      INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    order_id         INT UNSIGNED  NOT NULL,
    warehouse_id     INT UNSIGNED  NOT NULL,
    ship_date        DATE,
    tracking_number  VARCHAR(50)   UNIQUE,
    CONSTRAINT fk_shipment_order
        FOREIGN KEY (order_id)     REFERENCES `Order`(order_id)
        ON DELETE CASCADE  ON UPDATE CASCADE,
    CONSTRAINT fk_shipment_warehouse
        FOREIGN KEY (warehouse_id) REFERENCES Warehouse(warehouse_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
