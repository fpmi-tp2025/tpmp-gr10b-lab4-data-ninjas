-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2025-05-03 21:27:49.132

-- tables
-- Table: APP_CONFIG
CREATE TABLE APP_CONFIG (
    ConfigKey varchar(50)  NOT NULL,
    ConfigValue varchar(255)  NULL,
    Description text  NULL,
    UpdatedAt timestamp  NOT NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT APP_CONFIG_pk PRIMARY KEY (ConfigKey)
) ENGINE InnoDB;

-- Table: APP_USERS
CREATE TABLE APP_USERS (
    UserID int  NOT NULL AUTO_INCREMENT,
    Username varchar(50)  NOT NULL,
    PasswordHash varchar(255)  NOT NULL,
    Role varchar(20)  NOT NULL,
    CreatedAt timestamp  NOT NULL DEFAULT current_timestamp,
    UNIQUE INDEX Username_UNIQUE (Username),
    CONSTRAINT APP_USERS_pk PRIMARY KEY (UserID)
) ENGINE InnoDB;

-- Table: CARS
CREATE TABLE CARS (
    CarID int  NOT NULL AUTO_INCREMENT,
    LicensePlate varchar(20)  NOT NULL,
    Make varchar(50)  NULL,
    Model varchar(50)  NULL,
    Year int  NULL,
    InitialMileage int  NOT NULL DEFAULT 0,
    CurrentMileage int  NULL,
    LoadCapacity decimal(10,2)  NULL,
    FuelType varchar(30)  NULL,
    Status varchar(20)  NOT NULL DEFAULT 'available',
    UNIQUE INDEX LicensePlate_UNIQUE (LicensePlate),
    CONSTRAINT CARS_pk PRIMARY KEY (CarID)
) ENGINE InnoDB;

-- Table: DRIVERS
CREATE TABLE DRIVERS (
    DriverID int  NOT NULL AUTO_INCREMENT,
    LastName varchar(50)  NOT NULL,
    Category varchar(10)  NULL,
    Experience int  NULL,
    Address varchar(100)  NULL,
    BirthYear int  NULL,
    LicenseNumber varchar(20)  NULL,
    HireDate date  NULL,
    Status varchar(20)  NOT NULL DEFAULT 'active',
    UNIQUE INDEX LicenseNumber_UNIQUE (LicenseNumber),
    CHECK (( `BirthYear` BETWEEN 1950 AND 2005 )),
    CONSTRAINT DRIVERS_pk PRIMARY KEY (DriverID)
) ENGINE InnoDB;

-- Table: EARNINGS
CREATE TABLE EARNINGS (
    EarningID int  NOT NULL AUTO_INCREMENT,
    DriverID int  NULL,
    OrderID int  NULL,
    PeriodStart date  NULL,
    PeriodEnd date  NULL,
    TotalPrice decimal(10,2)  NULL,
    DriverEarning decimal(10,2) AS ( `TotalPrice` * 0.20) STORED NOT NULL,
    CONSTRAINT EARNINGS_pk PRIMARY KEY (DriverEarning)
) ENGINE InnoDB;

CREATE INDEX fk_earnings_drivers_idx ON EARNINGS (DriverID);

CREATE INDEX fk_earnings_orders_idx ON EARNINGS (OrderID);

-- Table: ORDERS
CREATE TABLE ORDERS (
    OrderID int  NOT NULL AUTO_INCREMENT,
    OrderDate date  NOT NULL,
    DriverID int  NULL,
    CarID int  NULL,
    StartLocation varchar(100)  NULL,
    EndLocation varchar(100)  NULL,
    Distance decimal(10,2)  NULL,
    CargoWeight decimal(10,2)  NULL,
    Price decimal(10,2)  NULL,
    OrderStatus varchar(20)  NOT NULL DEFAULT 'completed',
    CONSTRAINT ORDERS_pk PRIMARY KEY (OrderID)
) ENGINE InnoDB;

CREATE INDEX fk_orders_drivers_idx ON ORDERS (DriverID);

CREATE INDEX fk_orders_cars_idx ON ORDERS (CarID);

-- foreign keys
-- Reference: fk_earnings_drivers (table: EARNINGS)
ALTER TABLE EARNINGS ADD CONSTRAINT fk_earnings_drivers FOREIGN KEY fk_earnings_drivers (DriverID)
    REFERENCES DRIVERS (DriverID)
    ON DELETE SET NULL
    ON UPDATE CASCADE;

-- Reference: fk_earnings_orders (table: EARNINGS)
ALTER TABLE EARNINGS ADD CONSTRAINT fk_earnings_orders FOREIGN KEY fk_earnings_orders (OrderID)
    REFERENCES ORDERS (OrderID)
    ON DELETE SET NULL
    ON UPDATE CASCADE;

-- Reference: fk_orders_cars (table: ORDERS)
ALTER TABLE ORDERS ADD CONSTRAINT fk_orders_cars FOREIGN KEY fk_orders_cars (CarID)
    REFERENCES CARS (CarID)
    ON DELETE SET NULL
    ON UPDATE CASCADE;

-- Reference: fk_orders_drivers (table: ORDERS)
ALTER TABLE ORDERS ADD CONSTRAINT fk_orders_drivers FOREIGN KEY fk_orders_drivers (DriverID)
    REFERENCES DRIVERS (DriverID)
    ON DELETE SET NULL
    ON UPDATE CASCADE;

-- End of file.

