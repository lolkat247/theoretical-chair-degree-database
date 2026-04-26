CREATE TABLE Order_Line (
    order_line_id  INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    shipment_id    INT UNSIGNED  NOT NULL,
    product_id     INT UNSIGNED  NOT NULL,
    quantity       INT UNSIGNED  NOT NULL,
    unit_price     DECIMAL(10,2) NOT NULL,
    CONSTRAINT chk_order_line_quantity   CHECK (quantity   > 0),
    CONSTRAINT chk_order_line_unit_price CHECK (unit_price >= 0),
    CONSTRAINT fk_order_line_shipment
        FOREIGN KEY (shipment_id) REFERENCES Shipment(shipment_id)
        ON DELETE CASCADE  ON UPDATE CASCADE,
    CONSTRAINT fk_order_line_product
        FOREIGN KEY (product_id)  REFERENCES Product(product_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
