--
-- Author - Shuber Ali Mirza
-- ID ----- 20027047
-- 

-- Creates database called "f1" when script executed
CREATE DATABASE f1;
USE f1;

-- Table of Tyres
CREATE TABLE Tyres(
    compound CHAR(2) NOT NULL,
    hardness VARCHAR(20) NOT NULL,
    
    PRIMARY KEY(compound) -- Primary key
);

-- Table for Suppliers
CREATE TABLE Suppliers(
    name VARCHAR(30) NOT NULL,
    teamName VARCHAR(15) NOT NULL,
    
    PRIMARY KEY(name, teamName) -- Composite keys
);

-- Table for Teams
CREATE TABLE Teams(
    teamName VARCHAR(15) NOT NULL,
    fullName VARCHAR(40),
    pUnitSupplier VARCHAR(30) DEFAULT NULL,
    chassis CHAR(7),
    points DECIMAL(5,1) DEFAULT 0,
    
    PRIMARY KEY(teamName), -- Primary key
    CONSTRAINT fk_pUnit FOREIGN KEY(pUnitSupplier) REFERENCES Suppliers(name) -- Foreign key
    ON DELETE SET NULL ON UPDATE CASCADE -- Foreign key constraints
);

-- After creating the Teams table, going back and adding foreign key to Suppliers table
ALTER TABLE Suppliers
ADD CONSTRAINT fk_SteamName FOREIGN KEY(teamName) REFERENCES Teams(teamName)
ON DELETE CASCADE ON UPDATE CASCADE;

-- Table for Drivers
CREATE TABLE Drivers(
    dNo CHAR(3) NOT NULL,
    fName VARCHAR(10) NOT NULL,
    lName VARCHAR(10),
    teamName VARCHAR(15) NOT NULL,
    points DECIMAL(5,1) DEFAULT 0,
    
    PRIMARY KEY(dNo), -- Primary key
    CONSTRAINT fk_DteamName FOREIGN KEY(teamName) REFERENCES Teams(teamName) -- Foreign key
    ON DELETE CASCADE ON UPDATE CASCADE -- Foreign key constraints
);

-- Table for Circuits
CREATE TABLE Circuits(
    circuitName VARCHAR(30) NOT NULL,
    country VARCHAR(15) NOT NULL,
    hardestTyre CHAR(2) NOT NULL,
    
    PRIMARY KEY(circuitName), -- Primary key
    CONSTRAINT fk_hardestTyre FOREIGN KEY(hardestTyre) REFERENCES Tyres(compound) -- Foreign key
);

-- Table for Races
CREATE TABLE Races(
    raceID INT NOT NULL DEFAULT 1, 
    raceName VARCHAR(70) NOT NULL,
    circuitName VARCHAR(30) NOT NULL,
    day1Date DATE,
    raceDate DATE,
    
    PRIMARY KEY(raceID), -- Primary key
    CONSTRAINT fk_circuitName FOREIGN KEY(circuitName) REFERENCES Circuits(circuitName) -- Foreign key
    ON DELETE CASCADE ON UPDATE CASCADE -- Foreign key constraints
);

-- Table for Winners
CREATE TABLE Winners(
    raceID INT NOT NULL,
    dNo CHAR(3) NOT NULL,
    
    CONSTRAINT fk_raceID FOREIGN KEY(raceID) REFERENCES Races(raceID) -- Foreign key
    ON DELETE NO ACTION ON UPDATE NO ACTION, -- Foreign key constraints
    
    CONSTRAINT fk_driverNo FOREIGN KEY(dNo) REFERENCES Drivers(dNo) -- Foreign key
    ON DELETE NO ACTION ON UPDATE NO ACTION -- Foreign key constraints
);

