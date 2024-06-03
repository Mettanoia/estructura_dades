-- MySQL Script generated by MySQL Workbench
-- Mon Jun  3 11:21:42 2024
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema optics
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema optics
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `optics` ;
USE `optics` ;

-- -----------------------------------------------------
-- Table `optics`.`address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `optics`.`address` ;

CREATE TABLE IF NOT EXISTS `optics`.`address` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `street_name` VARCHAR(45) NOT NULL,
  `door_number` VARCHAR(45) NOT NULL,
  `postal_code` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optics`.`customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `optics`.`customer` ;

CREATE TABLE IF NOT EXISTS `optics`.`customer` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NOT NULL,
  `registration_Date` DATE NOT NULL,
  `phone_number` VARCHAR(45) NOT NULL,
  `registration_date` VARCHAR(45) NOT NULL,
  `address_id` INT NOT NULL,
  `sale_id` INT NOT NULL,
  `customer_id` INT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `phone_number_UNIQUE` (`phone_number` ASC) VISIBLE,
  INDEX `address_id_idx` (`address_id` ASC) VISIBLE,
  INDEX `customer_id_idx` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `address_id`
    FOREIGN KEY (`address_id`)
    REFERENCES `optics`.`address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `customer_id`
    FOREIGN KEY (`customer_id`)
    REFERENCES `optics`.`customer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optics`.`employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `optics`.`employee` ;

CREATE TABLE IF NOT EXISTS `optics`.`employee` (
  `id` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optics`.`sale`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `optics`.`sale` ;

CREATE TABLE IF NOT EXISTS `optics`.`sale` (
  `customer_id` INT NOT NULL,
  `employee_id` INT NOT NULL,
  `id` INT NOT NULL AUTO_INCREMENT,
  INDEX `customer_id_idx` (`customer_id` ASC) VISIBLE,
  INDEX `employee_id_idx` (`employee_id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  CONSTRAINT `customer_id`
    FOREIGN KEY (`customer_id`)
    REFERENCES `optics`.`customer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `employee_id`
    FOREIGN KEY (`employee_id`)
    REFERENCES `optics`.`employee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optics`.`provider`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `optics`.`provider` ;

CREATE TABLE IF NOT EXISTS `optics`.`provider` (
  `nif` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `address_id` INT NOT NULL,
  `phone_number` VARCHAR(45) NOT NULL,
  `fax` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`nif`),
  UNIQUE INDEX `address_id_UNIQUE` (`address_id` ASC) VISIBLE,
  UNIQUE INDEX `phone_number_UNIQUE` (`phone_number` ASC) VISIBLE,
  UNIQUE INDEX `fax_UNIQUE` (`fax` ASC) VISIBLE,
  CONSTRAINT `address_id`
    FOREIGN KEY (`address_id`)
    REFERENCES `optics`.`address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optics`.`brand`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `optics`.`brand` ;

CREATE TABLE IF NOT EXISTS `optics`.`brand` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `frame_type` VARCHAR(45) NOT NULL,
  `color` VARCHAR(45) NOT NULL,
  `provider_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `provider_id_idx` (`provider_id` ASC) VISIBLE,
  CONSTRAINT `provider_id`
    FOREIGN KEY (`provider_id`)
    REFERENCES `optics`.`provider` (`nif`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optics`.`glasses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `optics`.`glasses` ;

CREATE TABLE IF NOT EXISTS `optics`.`glasses` (
  `id` INT NOT NULL,
  `left_graduation` DOUBLE NOT NULL,
  `right_graduation` DOUBLE NOT NULL,
  `left_glass_color` VARCHAR(45) NOT NULL,
  `right_glass_color` VARCHAR(45) NOT NULL,
  `price` DOUBLE NOT NULL,
  `brand_id` INT NOT NULL,
  `sale_id` INT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `sale_id_UNIQUE` (`sale_id` ASC) VISIBLE,
  CONSTRAINT `brand_id`
    FOREIGN KEY (`sale_id`)
    REFERENCES `optics`.`brand` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `sale_id`
    FOREIGN KEY (`sale_id`)
    REFERENCES `optics`.`sale` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;