CREATE TABLE Order_Status_History (
    status_history_id  INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    order_id           INT UNSIGNED  NOT NULL,
    status             ENUM('pending','processing','shipped','delivered','cancelled','unable_to_fulfill') NOT NULL,
    changed_at         DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    notes              TEXT,
    CONSTRAINT fk_status_history_order
        FOREIGN KEY (order_id) REFERENCES `Order`(order_id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
