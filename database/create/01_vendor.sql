CREATE TABLE Vendor (
    vendor_id      INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    vendor_name    VARCHAR(100)  NOT NULL,
    country        VARCHAR(60),
    contact_name   VARCHAR(100),
    contact_email  VARCHAR(255),
    contact_phone  VARCHAR(20)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
