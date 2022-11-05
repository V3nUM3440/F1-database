--
-- Author - Shuber Ali Mirza
-- ID ----- 20027047
-- 

-- Procedures
-- Changing delimiter to // to use begin and end
DELIMITER //

-- Procedure to check if teamName present in Teams table
CREATE PROCEDURE checkTeam(IN name VARCHAR(15), OUT here INT)
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE teamHere INT DEFAULT FALSE;
    DECLARE x VARCHAR(15);
    DECLARE teamcur CURSOR FOR SELECT teamName FROM Teams; -- Cursor to go through the table
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN teamcur;
    checkTeam: LOOP
        FETCH teamcur INTO x; -- cursor fetched into variable x
        IF done THEN
            LEAVE checkTeam;
        END IF;
        IF name = x THEN
            SET teamHere = TRUE; -- if teamName present in the table, change teamHere variable from FALSE to TRUE
        END IF;
    END LOOP;
    CLOSE teamcur;
    SET here = teamHere; -- setting return variable to teamHere
END //

-- Procedure to check if tyre compound present in the Tyres table
CREATE PROCEDURE checkTyre(IN tyre CHAR(2), OUT found INT)
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE tyreHere INT DEFAULT FALSE;
    DECLARE x CHAR(2);
    DECLARE tyrecur CURSOR FOR SELECT compound FROM Tyres; -- Cursor to go through the table
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN tyrecur;
    checkTyre: LOOP
        FETCH tyrecur INTO x; -- cursor fetched into variable x
        IF done THEN
            LEAVE checkTyre;
        END IF;
        IF tyre = x THEN
            SET tyreHere = TRUE; -- if compound present in the table, change tyreHere variable from FALSE to TRUE
        END IF;
    END LOOP;
    CLOSE tyrecur;
    SET found = tyreHere; -- setting return variable to tyreHere
END //

-- Procedure to count number of times a specific tyre is used in the Circuits table
CREATE PROCEDURE numOfTyres(IN type CHAR(2), OUT num INT)
BEGIN
    DECLARE here INT DEFAULT FALSE;
    CALL checkTyre(type, here); -- calls checkTyre to satisfy foreign key contraint
    IF here = FALSE THEN
        SELECT 'Invalid Tyre Compound' AS 'ERROR'; -- gives error is foreign key incorrect
    -- gives errors if hardest tyre compound not entered, as that's the only compound being used in the Circuits table
    ELSEIF type = 'C4' THEN
        SELECT 'Please Enter The Hardest Tyre Compound' AS 'ERROR';
    ELSEIF type = 'C5' THEN
        SELECT 'Please Enter The Hardest Tyre Compound' AS 'ERROR';
    ELSE
        SELECT COUNT(hardestTyre) FROM Circuits -- counting the tyres
        GROUP BY hardestTyre
        HAVING hardestTyre = type
        INTO num; -- returning the result into the return variable
    END IF;
END //

-- Procedure to insert a circuit
CREATE PROCEDURE insertCircuit(IN name VARCHAR(30), place VARCHAR(15), tyre CHAR(2))
BEGIN
    -- Performs the same checks as the previous procedure and gives errors accordingly
    DECLARE tyreHere INT DEFAULT FALSE;
    CALL checkTyre(tyre, tyreHere);
    IF tyreHere = FALSE THEN
        SELECT 'Invalid Tyre Compound' AS 'ERROR';
    ELSEIF tyre = 'C4' THEN
        SELECT 'Please Enter The Hardest Tyre Compound That Will Be Used On This Circuit' AS 'ERROR';
    ELSEIF tyre = 'C5' THEN
        SELECT 'Please Enter The Hardest Tyre Compound That Will Be Used On This Circuit' AS 'ERROR';
    ELSE
        INSERT INTO Circuits VALUES(name, place, tyre);
    END IF;
END //

-- Procedure to update supplier of a team
CREATE PROCEDURE updateSupplier(IN team VARCHAR(15), sup VARCHAR(30))
BEGIN
    DECLARE teamHere INT DEFAULT FALSE;
    CALL checkTeam(team, teamHere); -- calls checkTeam to satisfy foreign key contraint
    IF teamHere = FALSE THEN
        SELECT 'Incorrect Team Name' AS 'ERROR'; -- gives error if teamName not present
    ELSE
        INSERT INTO Suppliers VALUES(sup, team); -- inserting into the supplier table
        UPDATE Teams SET pUnitSupplier = sup WHERE teamName = team; -- updating the supplier of team in Teams table
        DELETE FROM Suppliers WHERE teamName = team AND name<>sup; -- deleting the record of previous supplier of the team, if any
    END IF;
END //

-- Procedure to insert team points, depending on driver points
CREATE PROCEDURE insertTeamPoints()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE x VARCHAR(15);
    DECLARE num DECIMAL(5,1);
    DECLARE teams CURSOR FOR SELECT teamName FROM Teams; -- cursor to loop through Teams table
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN teams;
    names: LOOP
        FETCH teams INTO x; -- fetching cursor into variable x
        IF done THEN
            LEAVE names;
        END IF;
        SELECT SUM(points) FROM Drivers WHERE teamName = x INTO num; -- for each driver representing the team the cursor is currently on, sum points
        UPDATE Teams SET points = num WHERE teamName = x; -- update the points for each team
    END LOOP;
    CLOSE teams;
END //

-- Procedure to insert a race
CREATE PROCEDURE insertRace(IN name VARCHAR(70), cir VARCHAR(30), day1 DATE, last DATE)
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE x VARCHAR(30);
    DECLARE cirHere INT DEFAULT FALSE;
    DECLARE circur CURSOR FOR SELECT circuitName FROM Circuits; -- cursor to check if circuit exists
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN circur;
    circuitCheck: LOOP
        FETCH circur INTO x; -- cursor fetched into variable x
        IF done THEN
            LEAVE circuitCheck;
        END IF;
        IF cir = x THEN
            SET cirHere = TRUE; -- set cirHere true if circuit exists
        END IF;
    END LOOP;
    CLOSE circur;
    IF cirHere = FALSE THEN
        SELECT 'Incorrect Circuit Name' AS 'ERROR';
    ELSE
        INSERT INTO Races VALUES(DEFAULT, name, cir, day1, last);
    END IF;
END //

-- Procedure to appoint win to a driver
CREATE PROCEDURE appointWin(IN race INT, driver CHAR(3))
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE x INT;
    DECLARE y CHAR(3);
    DECLARE raceHere INT DEFAULT FALSE;
    DECLARE driverHere INT DEFAULT FALSE;
    DECLARE racecur CURSOR FOR SELECT raceID FROM Races; -- cursor to check if race exists
    DECLARE drivercur CURSOR FOR SELECT dNo FROM Drivers; -- cursor to check if driver exists
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN racecur;
    circuitCheck: LOOP
        FETCH racecur INTO x; -- cursor fetched into variable x
        IF done THEN
            LEAVE circuitCheck;
        END IF;
        IF race = x THEN
            SET raceHere = TRUE; -- set raceHere true if race exists
        END IF;
    END LOOP;
    CLOSE racecur;
    SET done = FALSE; -- setting done to FALSE to use in the second loop
    OPEN drivercur;
    driverCheck: LOOP
        FETCH drivercur INTO y; -- cursor fetched into variable y
        IF done THEN
            LEAVE driverCheck;
        END IF;
        IF driver = y THEN
            SET driverHere = TRUE; -- set driverHere to true if driver exists
        END IF;
    END LOOP;
    CLOSE drivercur;
    -- Display error appropriately
    IF raceHere = FALSE THEN
        SELECT 'Incorrect Race ID' AS 'ERROR';
    ELSEIF driverHere = FALSE THEN
        SELECT 'Incorrect Driver Number' AS 'ERROR';
    ELSE
        INSERT INTO Winners VALUES(race, driver);
    END IF;
END //

-- Trigger to auto-increment raceID when new race inserted
CREATE TRIGGER incrementRace
BEFORE INSERT ON Races FOR EACH ROW
BEGIN
    DECLARE maxID INT;
    SELECT MAX(raceID)+1 FROM Races INTO maxID; -- getting max ID in the current table
    SET NEW.raceID = maxID; -- getting the new ID to the max ID + 1
END //

DELIMITER ; -- setting delimiter back to normal

-- Trigger to update team points once driver points are updated
CREATE TRIGGER updateTeamPoints
AFTER UPDATE ON Drivers FOR EACH ROW
CALL insertTeamPoints(); -- calls the insertTeamPoints() procedure, as it basically does the same thing

-- View to display current driver standings
CREATE VIEW driverStand AS
SELECT dNo, CONCAT(fName, ' ', lName) AS 'Full Name', teamName, points
FROM Drivers ORDER BY points DESC;

-- View to display current constructor standings
CREATE VIEW constructorStand AS
SELECT * FROM Teams ORDER BY points DESC;
