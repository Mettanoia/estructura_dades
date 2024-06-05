-- MySQL Script generated by MySQL Workbench
-- Wed Jun  5 12:38:23 2024
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`province`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`province` ;

CREATE TABLE IF NOT EXISTS `mydb`.`province` (
  `id` INT NOT NULL,
  `name` VARCHAR(20) NOT NULL,
  `type` ENUM('drink', 'pizza', 'hamburger') NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `price` VARCHAR(45) NOT NULL,
  `image` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`location`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`location` ;

CREATE TABLE IF NOT EXISTS `mydb`.`location` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `province_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `province_id`
    FOREIGN KEY (`id`)
    REFERENCES `mydb`.`province` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`address` ;

CREATE TABLE IF NOT EXISTS `mydb`.`address` (
  `id` INT NOT NULL,
  `street_name` VARCHAR(45) NOT NULL,
  `door_number` VARCHAR(6) NOT NULL,
  `postal_code` VARCHAR(8) NOT NULL,
  `location_id` INT NOT NULL,
  `door_number` VARCHAR(4) NULL,
  PRIMARY KEY (`id`),
  INDEX `location_id_idx` (`location_id` ASC) VISIBLE,
  CONSTRAINT `location_id`
    FOREIGN KEY (`location_id`)
    REFERENCES `mydb`.`location` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`customer` ;

CREATE TABLE IF NOT EXISTS `mydb`.`customer` (
  `id` INT NOT NULL,
  `name` VARCHAR(15) NOT NULL,
  `surname` VARCHAR(15) NOT NULL,
  `address_id` INT NOT NULL,
  `phone_number` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `address_id_idx` (`address_id` ASC) VISIBLE,
  CONSTRAINT `address_id`
    FOREIGN KEY (`address_id`)
    REFERENCES `mydb`.`address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`store`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`store` ;

CREATE TABLE IF NOT EXISTS `mydb`.`store` (
  `id` INT NOT NULL,
  `address_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `address_id_idx` (`address_id` ASC) VISIBLE,
  UNIQUE INDEX `address_id_UNIQUE` (`address_id` ASC) VISIBLE,
  CONSTRAINT `address_id`
    FOREIGN KEY (`address_id`)
    REFERENCES `mydb`.`address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`employee` ;

CREATE TABLE IF NOT EXISTS `mydb`.`employee` (
  `nif` VARCHAR(15) NOT NULL,
  `name` VARCHAR(15) NOT NULL,
  `surname` VARCHAR(15) NOT NULL,
  `phone_number` VARCHAR(15) NOT NULL,
  `role` ENUM('cooker', 'deliverer') NOT NULL,
  `store_id` INT NOT NULL,
  PRIMARY KEY (`nif`),
  INDEX `store_id_idx` (`store_id` ASC) VISIBLE,
  CONSTRAINT `store_id`
    FOREIGN KEY (`store_id`)
    REFERENCES `mydb`.`store` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`order` ;

CREATE TABLE IF NOT EXISTS `mydb`.`order` (
  `id` INT NOT NULL,
  `ordered_at` VARCHAR(45) NOT NULL,
  `deliver` ENUM('takeaway', 'home') NOT NULL,
  `employee_id` VARCHAR(15) NULL,
  `delivered_at` DATETIME NULL,
  `customer_id` INT NOT NULL,
  `store_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `employee_id_idx` (`employee_id` ASC) VISIBLE,
  INDEX `customer_id_idx` (`customer_id` ASC) VISIBLE,
  INDEX `store_id_idx` (`store_id` ASC) VISIBLE,
  CONSTRAINT `employee_id`
    FOREIGN KEY (`employee_id`)
    REFERENCES `mydb`.`employee` (`nif`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `customer_id`
    FOREIGN KEY (`customer_id`)
    REFERENCES `mydb`.`customer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `store_id`
    FOREIGN KEY (`store_id`)
    REFERENCES `mydb`.`store` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`category` ;

CREATE TABLE IF NOT EXISTS `mydb`.`category` (
  `id` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`product` ;

CREATE TABLE IF NOT EXISTS `mydb`.`product` (
  `id` INT NOT NULL,
  `price` DOUBLE NOT NULL,
  `type` ENUM('drink', 'hamburger', 'pizza') NOT NULL,
  `category_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `category_id_idx` (`category_id` ASC) VISIBLE,
  CONSTRAINT `category_id`
    FOREIGN KEY (`category_id`)
    REFERENCES `mydb`.`category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`order_items`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`order_items` ;

CREATE TABLE IF NOT EXISTS `mydb`.`order_items` (
  `id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `order_id` INT NOT NULL,
  `price_total` DOUBLE NOT NULL,
  `quantity` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `order_id_idx` (`order_id` ASC) VISIBLE,
  INDEX `product_id_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `order_id`
    FOREIGN KEY (`order_id`)
    REFERENCES `mydb`.`order` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `product_id`
    FOREIGN KEY (`product_id`)
    REFERENCES `mydb`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `mydb`;

DELIMITER $$

USE `mydb`$$
DROP TRIGGER IF EXISTS `mydb`.`order_if_home_delivery_employee_and_date_not_null` $$
USE `mydb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`order_if_home_delivery_employee_and_date_not_null`
BEFORE INSERT ON `order`
FOR EACH ROW
BEGIN
    DECLARE hasHomeDelivery BOOLEAN;

    SET hasHomeDelivery = (NEW.deliver = 'home');

    IF hasHomeDelivery THEN
        IF NEW.employee_id IS NULL THEN
            IF NEW.ordered_at IS NULL THEN
                SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'For home deliveries, both employee_id and ordered_at must be provided.';
            END IF;
        ELSE
            IF NEW.ordered_at IS NULL THEN
                SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'For home deliveries, ordered_at must be provided.';
            END IF;
        END IF;
    END IF;

    IF NEW.employee_id IS NULL THEN
        IF NEW.order_id IS NULL THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'If employee_id is not specified, then order_id must be provided.';
        END IF;
    END IF;
END;$$


USE `mydb`$$
DROP TRIGGER IF EXISTS `mydb`.`product_if_type_is_pizza_then_category_id_must_be_not_null` $$
USE `mydb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`product_if_type_is_pizza_then_category_id_must_be_not_null` BEFORE UPDATE ON `product` FOR EACH ROW
BEGIN
	IF NEW.type = 'pizza' AND NEW.category_id IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'For products of type "pizza", category_id cannot be null.';
    END IF;
END$$


USE `mydb`$$
DROP TRIGGER IF EXISTS `mydb`.`product_if_type_is_pizza_then_category_id_must_be_not_null` $$
USE `mydb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`product_if_type_is_pizza_then_category_id_must_be_not_null` BEFORE UPDATE ON `product` FOR EACH ROW
BEGIN
	IF NEW.type = 'pizza' AND NEW.category_id IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'For products of type "pizza", category_id cannot be null.';
    END IF;
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
