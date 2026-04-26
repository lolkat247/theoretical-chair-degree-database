-- Disjoint subtype enforcement.
-- Rule: a row in subtype T can only exist when its parent Product has
-- product_type = T. Guarded on INSERT and UPDATE for both directions:
--   * subtype side: BEFORE INSERT/UPDATE checks parent product_type
--   * Product side: BEFORE UPDATE blocks product_type changes that would
--     orphan an existing subtype row

DELIMITER //

-- Helper convention: trg_<table>_disjoint_<event>

-- =========================================================
-- Produce
-- =========================================================
CREATE TRIGGER trg_produce_disjoint_ins BEFORE INSERT ON Produce
FOR EACH ROW
BEGIN
    DECLARE pt VARCHAR(20);
    SELECT product_type INTO pt FROM Product WHERE product_id = NEW.product_id;
    IF pt <> 'Produce' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Subtype mismatch: Product.product_type must be Produce';
    END IF;
END//

CREATE TRIGGER trg_produce_disjoint_upd BEFORE UPDATE ON Produce
FOR EACH ROW
BEGIN
    DECLARE pt VARCHAR(20);
    SELECT product_type INTO pt FROM Product WHERE product_id = NEW.product_id;
    IF pt <> 'Produce' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Subtype mismatch: Product.product_type must be Produce';
    END IF;
END//

-- =========================================================
-- Meat
-- =========================================================
CREATE TRIGGER trg_meat_disjoint_ins BEFORE INSERT ON Meat
FOR EACH ROW
BEGIN
    DECLARE pt VARCHAR(20);
    SELECT product_type INTO pt FROM Product WHERE product_id = NEW.product_id;
    IF pt <> 'Meat' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Subtype mismatch: Product.product_type must be Meat';
    END IF;
END//

CREATE TRIGGER trg_meat_disjoint_upd BEFORE UPDATE ON Meat
FOR EACH ROW
BEGIN
    DECLARE pt VARCHAR(20);
    SELECT product_type INTO pt FROM Product WHERE product_id = NEW.product_id;
    IF pt <> 'Meat' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Subtype mismatch: Product.product_type must be Meat';
    END IF;
END//

-- =========================================================
-- Dairy
-- =========================================================
CREATE TRIGGER trg_dairy_disjoint_ins BEFORE INSERT ON Dairy
FOR EACH ROW
BEGIN
    DECLARE pt VARCHAR(20);
    SELECT product_type INTO pt FROM Product WHERE product_id = NEW.product_id;
    IF pt <> 'Dairy' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Subtype mismatch: Product.product_type must be Dairy';
    END IF;
END//

CREATE TRIGGER trg_dairy_disjoint_upd BEFORE UPDATE ON Dairy
FOR EACH ROW
BEGIN
    DECLARE pt VARCHAR(20);
    SELECT product_type INTO pt FROM Product WHERE product_id = NEW.product_id;
    IF pt <> 'Dairy' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Subtype mismatch: Product.product_type must be Dairy';
    END IF;
END//

-- =========================================================
-- Bakery
-- =========================================================
CREATE TRIGGER trg_bakery_disjoint_ins BEFORE INSERT ON Bakery
FOR EACH ROW
BEGIN
    DECLARE pt VARCHAR(20);
    SELECT product_type INTO pt FROM Product WHERE product_id = NEW.product_id;
    IF pt <> 'Bakery' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Subtype mismatch: Product.product_type must be Bakery';
    END IF;
END//

CREATE TRIGGER trg_bakery_disjoint_upd BEFORE UPDATE ON Bakery
FOR EACH ROW
BEGIN
    DECLARE pt VARCHAR(20);
    SELECT product_type INTO pt FROM Product WHERE product_id = NEW.product_id;
    IF pt <> 'Bakery' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Subtype mismatch: Product.product_type must be Bakery';
    END IF;
END//

-- =========================================================
-- Deli
-- =========================================================
CREATE TRIGGER trg_deli_disjoint_ins BEFORE INSERT ON Deli
FOR EACH ROW
BEGIN
    DECLARE pt VARCHAR(20);
    SELECT product_type INTO pt FROM Product WHERE product_id = NEW.product_id;
    IF pt <> 'Deli' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Subtype mismatch: Product.product_type must be Deli';
    END IF;
END//

CREATE TRIGGER trg_deli_disjoint_upd BEFORE UPDATE ON Deli
FOR EACH ROW
BEGIN
    DECLARE pt VARCHAR(20);
    SELECT product_type INTO pt FROM Product WHERE product_id = NEW.product_id;
    IF pt <> 'Deli' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Subtype mismatch: Product.product_type must be Deli';
    END IF;
END//

-- =========================================================
-- Frozen
-- =========================================================
CREATE TRIGGER trg_frozen_disjoint_ins BEFORE INSERT ON Frozen
FOR EACH ROW
BEGIN
    DECLARE pt VARCHAR(20);
    SELECT product_type INTO pt FROM Product WHERE product_id = NEW.product_id;
    IF pt <> 'Frozen' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Subtype mismatch: Product.product_type must be Frozen';
    END IF;
END//

CREATE TRIGGER trg_frozen_disjoint_upd BEFORE UPDATE ON Frozen
FOR EACH ROW
BEGIN
    DECLARE pt VARCHAR(20);
    SELECT product_type INTO pt FROM Product WHERE product_id = NEW.product_id;
    IF pt <> 'Frozen' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Subtype mismatch: Product.product_type must be Frozen';
    END IF;
END//

-- =========================================================
-- Shelf_Stable
-- =========================================================
CREATE TRIGGER trg_shelf_stable_disjoint_ins BEFORE INSERT ON Shelf_Stable
FOR EACH ROW
BEGIN
    DECLARE pt VARCHAR(20);
    SELECT product_type INTO pt FROM Product WHERE product_id = NEW.product_id;
    IF pt <> 'Shelf_Stable' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Subtype mismatch: Product.product_type must be Shelf_Stable';
    END IF;
END//

CREATE TRIGGER trg_shelf_stable_disjoint_upd BEFORE UPDATE ON Shelf_Stable
FOR EACH ROW
BEGIN
    DECLARE pt VARCHAR(20);
    SELECT product_type INTO pt FROM Product WHERE product_id = NEW.product_id;
    IF pt <> 'Shelf_Stable' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Subtype mismatch: Product.product_type must be Shelf_Stable';
    END IF;
END//

-- =========================================================
-- Product side: block product_type changes that would orphan
-- the existing subtype row.
-- =========================================================
CREATE TRIGGER trg_product_type_lock BEFORE UPDATE ON Product
FOR EACH ROW
BEGIN
    IF NEW.product_type <> OLD.product_type THEN
        IF (OLD.product_type = 'Produce'      AND EXISTS (SELECT 1 FROM Produce      WHERE product_id = OLD.product_id))
        OR (OLD.product_type = 'Meat'         AND EXISTS (SELECT 1 FROM Meat         WHERE product_id = OLD.product_id))
        OR (OLD.product_type = 'Dairy'        AND EXISTS (SELECT 1 FROM Dairy        WHERE product_id = OLD.product_id))
        OR (OLD.product_type = 'Bakery'      AND EXISTS (SELECT 1 FROM Bakery       WHERE product_id = OLD.product_id))
        OR (OLD.product_type = 'Deli'         AND EXISTS (SELECT 1 FROM Deli         WHERE product_id = OLD.product_id))
        OR (OLD.product_type = 'Frozen'       AND EXISTS (SELECT 1 FROM Frozen       WHERE product_id = OLD.product_id))
        OR (OLD.product_type = 'Shelf_Stable' AND EXISTS (SELECT 1 FROM Shelf_Stable WHERE product_id = OLD.product_id))
        THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot change Product.product_type while a matching subtype row exists';
        END IF;
    END IF;
END//

DELIMITER ;
