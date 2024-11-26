-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema mg_schema
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mg_schema
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mg_schema` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `mg_schema` ;

-- -----------------------------------------------------
-- Table `mg_schema`.`staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mg_schema`.`staff` (
  `StaffID` INT NOT NULL,
  `FullName` VARCHAR(255) NOT NULL,
  `ContactNumber` INT NOT NULL,
  `Role` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`StaffID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mg_schema`.`Products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mg_schema`.`Products` (
  `ProductID` INT NOT NULL AUTO_INCREMENT,
  `ProductName` VARCHAR(255) NOT NULL,
  `SellPrice` DECIMAL(10,2) NOT NULL,
  `BuyPrice` DECIMAL(10,2) NOT NULL,
  `AmountInStock` INT NOT NULL,
  PRIMARY KEY (`ProductID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mg_schema`.`Clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mg_schema`.`Clients` (
  `ClientID` INT NOT NULL AUTO_INCREMENT,
  `FullName` VARCHAR(45) NOT NULL,
  `ContactNumer` INT NOT NULL,
  `Email` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`ClientID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mg_schema`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mg_schema`.`Orders` (
  `OrderID` INT NOT NULL AUTO_INCREMENT,
  `OrderDate` DATE NOT NULL,
  `ProductID` INT NOT NULL,
  `ClientID` INT NOT NULL,
  `TotalPrice` INT NOT NULL,
  `Quantity` INT NOT NULL,
  PRIMARY KEY (`OrderID`),
  INDEX `Items_fk_Orders_idx` (`ProductID` ASC) VISIBLE,
  INDEX `Clients_fk_Orders_idx` (`ClientID` ASC) VISIBLE,
  CONSTRAINT `Items_fk_Orders`
    FOREIGN KEY (`ProductID`)
    REFERENCES `mg_schema`.`Products` (`ProductID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Clients_fk_Orders`
    FOREIGN KEY (`ClientID`)
    REFERENCES `mg_schema`.`Clients` (`ClientID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mg_schema`.`Address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mg_schema`.`Address` (
  `AddressID` INT NOT NULL AUTO_INCREMENT,
  `Street` VARCHAR(255) NOT NULL,
  `ZipCode` VARCHAR(255) NOT NULL,
  `State` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`AddressID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mg_schema`.`Delivery`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mg_schema`.`Delivery` (
  `DeliveryID` INT NOT NULL AUTO_INCREMENT,
  `DeliveryStatus` VARCHAR(255) NOT NULL,
  `DeliveryDate` DATE NOT NULL,
  `OrderID` INT NOT NULL,
  `AddressID` INT NOT NULL,
  `Comment` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`DeliveryID`),
  INDEX `Orders_FK_Delivery_idx` (`OrderID` ASC) VISIBLE,
  INDEX `Address_FK_Delivery_idx` (`AddressID` ASC) VISIBLE,
  CONSTRAINT `Orders_FK_Delivery`
    FOREIGN KEY (`OrderID`)
    REFERENCES `mg_schema`.`Orders` (`OrderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Address_FK_Delivery`
    FOREIGN KEY (`AddressID`)
    REFERENCES `mg_schema`.`Address` (`AddressID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
