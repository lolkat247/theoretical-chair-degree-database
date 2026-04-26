CREATE TABLE Customer (
    customer_id  INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    first_name   VARCHAR(60)   NOT NULL,
    last_name    VARCHAR(60)   NOT NULL,
    email        VARCHAR(255)  UNIQUE,
    phone        VARCHAR(20),
    address      VARCHAR(200),
    city         VARCHAR(100),
    state        VARCHAR(60),
    zip_code     VARCHAR(20)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
