-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mintazh
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mintazh
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mintazh` DEFAULT CHARACTER SET utf8mb4 ;
USE `mintazh` ;

-- -----------------------------------------------------
-- Table `mintazh`.`ember`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mintazh`.`ember` ;

CREATE TABLE IF NOT EXISTS `mintazh`.`ember` (
  `emberid` INT NOT NULL AUTO_INCREMENT,
  `szuletesdatum` DATE NOT NULL,
  `nev` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`emberid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mintazh`.`egyesulet`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mintazh`.`egyesulet` ;

CREATE TABLE IF NOT EXISTS `mintazh`.`egyesulet` (
  `egyesuletid` INT NOT NULL AUTO_INCREMENT,
  `alapitasev` YEAR NOT NULL,
  `tagdij` INT NULL,
  `alapitoid` INT NOT NULL,
  `nev` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`egyesuletid`, `alapitoid`),
  INDEX `fk_egyesulet_ember_idx` (`alapitoid` ASC),
  CONSTRAINT `fk_egyesulet_ember`
    FOREIGN KEY (`alapitoid`)
    REFERENCES `mintazh`.`ember` (`emberid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mintazh`.`tagsag`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mintazh`.`tagsag` ;

CREATE TABLE IF NOT EXISTS `mintazh`.`tagsag` (
  `egyesulet_egyesuletid` INT NOT NULL,
  `ember_emberid` INT NOT NULL,
  `csatlakozas` YEAR NOT NULL,
  PRIMARY KEY (`egyesulet_egyesuletid`, `ember_emberid`),
  INDEX `fk_egyesulet_has_ember_ember1_idx` (`ember_emberid` ASC),
  INDEX `fk_egyesulet_has_ember_egyesulet1_idx` (`egyesulet_egyesuletid` ASC),
  CONSTRAINT `fk_egyesulet_has_ember_egyesulet1`
    FOREIGN KEY (`egyesulet_egyesuletid`)
    REFERENCES `mintazh`.`egyesulet` (`egyesuletid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_egyesulet_has_ember_ember1`
    FOREIGN KEY (`ember_emberid`)
    REFERENCES `mintazh`.`ember` (`emberid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
