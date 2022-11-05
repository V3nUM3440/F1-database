--
-- Author - Shuber Ali Mirza
-- ID ----- 20027047
-- 

-- 1: What are the current points of the constructors, depending on their driver’s points?
SELECT D.teamName, T.fullName, SUM(D.points) AS ContructorPoints
FROM Drivers AS D INNER JOIN Teams AS T
ON D.teamName = T.teamName GROUP BY D.teamName;

-- 2: What are the current points of drivers, with their full name, and teams they belong to, ordered by teams?
SELECT dNo, CONCAT(fName, ' ', lName) AS 'Full Name', teamName, points
FROM Drivers ORDER BY teamName;

-- 3: What are the current points of drivers, and have they won any races?
SELECT dNo, fName, lName, raceID
FROM Drivers NATURAL LEFT JOIN Winners;

-- 4: What teams do drivers belong to, with full names of the teams and the car chassis they drive?
SELECT dNo, fName, lName, fullName AS 'Team Full Name', chassis
FROM Drivers INNER JOIN Teams
WHERE Drivers.teamName = Teams.teamName;

-- 5: What races take place after March, but before June, and where do they take place, shown in local date format (DD/MM/YYYY)?
SELECT raceID, raceName, country, DATE_FORMAT(day1Date, '%e/%m/%Y') AS 'Day 1 Date',
DATE_FORMAT(raceDate, '%e/%m/%Y') AS 'Race Date'
FROM Races NATURAL JOIN Circuits
WHERE day1Date > '2022-03-31' AND day1Date < '2022-06-01';

-- 6: How many power units does Mercedes supply, excluding themselves, and what are the teams that use them?
-- what are the teams that use them?
SELECT * FROM Suppliers WHERE name = 'Mercedes';
-- How many power units does Mercedes supply?
SELECT COUNT(*) AS 'Num of Teams Using Mercedes pUnit'
FROM Suppliers WHERE name = 'Mercedes';

-- 7: Who is the leader in points for the drivers, with their full name and chassis name?
SELECT dNo, CONCAT(fName, ' ', lName) AS 'Full Name', chassis, D.points
FROM Drivers AS D INNER JOIN Teams AS T
WHERE D.points = (SELECT MAX(points) FROM Drivers)
AND D.teamName = T.teamName;

-- 8: What is the most used hard tyre compound this year?
SELECT hardestTyre, COUNT(hardestTyre) AS 'No. of Circuits Used in'
FROM Circuits
GROUP BY hardestTyre
ORDER BY hardestTyre LIMIT 1;

-- 9: What drivers have higher points, belonging to the same team?
SELECT * FROM Drivers AS D1
WHERE points > (SELECT points FROM Drivers AS D2 
                WHERE D1.teamName=D2.teamName AND D1.dNo<>D2.dNo);

