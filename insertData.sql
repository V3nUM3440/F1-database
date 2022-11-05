--
-- Author - Shuber Ali Mirza
-- ID ----- 20027047
-- 

-- Tyres:
INSERT INTO Tyres VALUES('C1', 'Hardest');
INSERT INTO Tyres VALUES('C2', 'Second Most Hard');
INSERT INTO Tyres VALUES('C3', 'Medium');
INSERT INTO Tyres VALUES('C4', 'Second Most Soft');
INSERT INTO Tyres VALUES('C5', 'Softest');


-- Teams, Drivers, and Power Unit Suppliers:
INSERT INTO Teams VALUES('Alfa Romeo', 'Alfa Romeo F1 Team ORLEN', NULL, 'C42', 0);
INSERT INTO Suppliers VALUES('Ferrari', 'Alfa Romeo');
UPDATE Teams SET pUnitSupplier = 'Ferrari' WHERE teamName = 'Alfa Romeo';
INSERT INTO Drivers VALUES('77', 'Valtteri', 'Bottas', 'Alfa Romeo', 226);
INSERT INTO Drivers VALUES('24', 'Zhou', 'Guanyu', 'Alfa Romeo', 0);

INSERT INTO Teams VALUES('AlphaTauri', 'Scuderia AlphaTauri', NULL, 'AT03', 0);
INSERT INTO Suppliers VALUES('Red Bull Powertrains', 'AlphaTauri');
UPDATE Teams SET pUnitSupplier = 'Red Bull Powertrains' WHERE teamName = 'AlphaTauri';
INSERT INTO Drivers VALUES('10', 'Pierre', 'Gasly', 'AlphaTauri', 110);
INSERT INTO Drivers VALUES('22', 'Yuki', 'Tsunoda', 'AlphaTauri', 32);

INSERT INTO Teams VALUES('Alpine', 'BWT Alpine F1 Team', NULL, 'A522', 0);
INSERT INTO Suppliers VALUES('Renault', 'Alpine');
UPDATE Teams SET pUnitSupplier = 'Renault' WHERE teamName = 'Alpine';
INSERT INTO Drivers VALUES('14', 'Fernando', 'Alonso', 'Alpine', 81);
INSERT INTO Drivers VALUES('31', 'Esteban', 'Ocon', 'Alpine', 74);

INSERT INTO Teams VALUES('Aston Martin', 'Aston Martin Aramco Cognizant F1 Team', NULL, 'AMR22', 0);
INSERT INTO Suppliers VALUES('Mercedes', 'Aston Martin');
UPDATE Teams SET pUnitSupplier = 'Mercedes' WHERE teamName = 'Aston Martin';
INSERT INTO Drivers VALUES('5', 'Sebastian', 'Vettel', 'Aston Martin', 43);
INSERT INTO Drivers VALUES('18', 'Lance', 'Stroll', 'Aston Martin', 34);

INSERT INTO Teams VALUES('Ferrari', 'Scuderia Ferrari', NULL, 'F1-75', 0);
INSERT INTO Drivers VALUES('16', 'Charles', 'Leclerc', 'Ferrari', 159);
INSERT INTO Drivers VALUES('55', 'Carlos', 'Sainz', 'Ferrari', 164.5);

INSERT INTO Teams VALUES('Haas', 'Haas F1 Team', 'Ferrari', 'VF-22', 0);
INSERT INTO Suppliers VALUES('Ferrari', 'Haas');
INSERT INTO Drivers VALUES('47', 'Mick', 'Schumacher', 'Haas', 30);
INSERT INTO Drivers VALUES('20', 'Kevin', 'Magnussen', 'Haas', 75);

INSERT INTO Teams VALUES('McLaren', 'McLaren F1 Team', 'Mercedes', 'MCL36', 0);
INSERT INTO Suppliers VALUES('Mercedes', 'McLaren');
INSERT INTO Drivers VALUES('3', 'Daniel', 'Ricciardo', 'McLaren', 115);
INSERT INTO Drivers VALUES('4', 'Lando', 'Norris', 'McLaren', 160);

INSERT INTO Teams VALUES('Mercedes', 'Mercedes-AMG Petronas F1 Team', NULL, 'W13', 0);
INSERT INTO Drivers VALUES('44', 'Lewis', 'Hamilton', 'Mercedes', 387.5);
INSERT INTO Drivers VALUES('63', 'George', 'Russell', 'Mercedes', 220);

INSERT INTO Teams VALUES('Red Bull', 'Oracle Red Bull Racing', NULL, 'RB18', 0);
INSERT INTO Drivers VALUES('1', 'Max', 'Verstappen', 'Red Bull', 395.5);
INSERT INTO Drivers VALUES('11', 'Sergio', 'Perez', 'Red Bull', 190);

INSERT INTO Teams VALUES('Williams', 'Williams Racing', 'Mercedes', 'FW44', 0);
INSERT INTO Suppliers VALUES('Mercedes', 'Williams');
INSERT INTO Drivers VALUES('6', 'Nicholas', 'Latifi', 'Williams', 7);
INSERT INTO Drivers VALUES('23', 'Alexander', 'Albon', 'Williams', 16);


-- Circuits, Races and Winners
INSERT INTO Circuits VALUES('Bahrain International Circuit', 'Bahrain', 'C1');
INSERT INTO Races VALUES(DEFAULT, 'GULF AIR BAHRAIN GRAND PRIX 2022', 'Bahrain International Circuit', '2022-03-18', '2022-03-20');
INSERT INTO Winners VALUES(1, '16');

INSERT INTO Circuits VALUES('Jeddah Corniche Circuit', 'Saudi Arabia', 'C1');
INSERT INTO Races VALUES(2, 'STC SAUDI ARABIAN GRAND PRIX 2022', 'Jeddah Corniche Circuit', '2022-03-25', '2022-03-27');
INSERT INTO Winners VALUES(2, '44');

INSERT INTO Circuits VALUES('Melbourne Grand Prix Circuit', 'Australia', 'C3');
INSERT INTO Races VALUES(3, 'HEINEKEN AUSTRALIAN GRAND PRIX 2022', 'Melbourne Grand Prix Circuit', '2022-04-08', '2022-04-10');
INSERT INTO Winners VALUES(3, '3');

INSERT INTO Circuits VALUES('Autodromo Enzo e Dino Ferrari', 'Italy', 'C2');
INSERT INTO Races VALUES(4, 'ROLEX GRAN PREMIO DEL MADE IN ITALY E DELL\'EMILIA-ROMAGNA 2022', 'Autodromo Enzo e Dino Ferrari', '2022-04-22', '2022-04-24');
INSERT INTO Winners VALUES(4, '20');

INSERT INTO Circuits VALUES('Miami International Autodrome', 'United States', 'C1');
INSERT INTO Races VALUES(5, 'CRYPTO.COM MIAMI GRAND PRIX 2022', 'Miami International Autodrome', '2022-05-06', '2022-05-08');
INSERT INTO Winners VALUES(5, '1');

INSERT INTO Circuits VALUES('Circuit de Barcelona-Catalunya', 'Spain', 'C3');
INSERT INTO Races VALUES(6, 'PIRELLI GRAN PREMIO DE ESPAÑA 2022', 'Circuit de Barcelona-Catalunya', '2022-05-20', '2022-05-22');
INSERT INTO Winners VALUES(6, '44');

INSERT INTO Circuits VALUES('Circuit de Monaco', 'Monaco', 'C1');
INSERT INTO Races VALUES(7, 'GRAND PRIX DE MONACO 2022', 'Circuit de Monaco', '2022-05-27', '2022-05-29');
INSERT INTO Winners VALUES(7, '1');

INSERT INTO Circuits VALUES('Baku City Circuit', 'Azerbaijan', 'C2');
INSERT INTO Races VALUES(8, 'AZERBAIJAN GRAND PRIX 2022', 'Baku City Circuit', '2022-06-10', '2022-06-12');
INSERT INTO Winners VALUES(8, '11');

INSERT INTO Circuits VALUES('Circuit Gilles-Villeneuve', 'Canada', 'C1');
INSERT INTO Races VALUES(9, 'GRAND PRIX DU CANADA 2022', 'Circuit Gilles-Villeneuve', '2022-06-17', '2022-06-19');
INSERT INTO Winners VALUES(9, '77');

INSERT INTO Circuits VALUES('Silverstone Circuit', 'Great Britain', 'C3');
INSERT INTO Races VALUES(10, 'BRITISH GRAND PRIX 2022', 'Circuit Gilles-Villeneuve', '2022-07-01', '2022-07-03');
INSERT INTO Winners VALUES(10, '44');
