-- 7.2   - В ранее подключенном MySQL создать базу данных с названием "Human Friends".

DROP DATABASE IF EXISTS Human_friends;
CREATE DATABASE Human_friends;
USE Human_friends;

-- Создать таблицы, соответствующие иерархии из вашей диаграммы классов.
-- Заполнить таблицы данными о животных, их командах и датами рождения.


DROP TABLE IF EXISTS animal;

CREATE TABLE animal
(
	Id INT AUTO_INCREMENT PRIMARY KEY, 
	name VARCHAR(20)
);

INSERT INTO animal (name)
VALUES ('pack'),
('pet');  

DROP TABLE IF EXISTS pack_animals;
CREATE TABLE pack_animals
(
	  Id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR (20),
    Class_id INT,
    FOREIGN KEY (Class_id) REFERENCES animal(Id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO pack_animals (name, Class_id)
VALUES ('Horse', 1),
('Donkey', 1),  
('Camel', 1); 

DROP TABLE IF EXISTS pets;
    
CREATE TABLE pets
(
	  Id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR (20),
    Class_id INT,
    FOREIGN KEY (Class_id) REFERENCES animal (Id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO pets (name, Class_id)
VALUES ('Cats', 2),
('Dogs', 2),  
('Hamsters', 2); 

DROP TABLE IF EXISTS cats;

CREATE TABLE cats 
(       
    Id INT AUTO_INCREMENT PRIMARY KEY, 
    Name VARCHAR(20), 
    Birthday DATE,
    Commands VARCHAR(50),
    type_id int,
    Foreign KEY (type_id) REFERENCES pets (Id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO cats (Name, Birthday, Commands, type_id)
VALUES ('Mars', '2022-01-01', 'Stay', 1),
('Messi', '2023-01-01', "Eat", 1),  
('Lisa', '2021-01-01', "Hide", 1); 

DROP TABLE IF EXISTS dogs;

CREATE TABLE dogs 
(       
    Id INT AUTO_INCREMENT PRIMARY KEY, 
    Name VARCHAR(20), 
    Birthday DATE,
    Commands VARCHAR(50),
    type_id int,
    Foreign KEY (type_id) REFERENCES pets (Id) ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO dogs (Name, Birthday, Commands, type_id)
VALUES ('Charlie', '2018-01-01', 'Sit, Down, Stay', 2),
('Lucie', '2012-01-01', "Stay, Come, Bite, Speak", 2),  
('Panda', '2018-01-01', "Sit, Come, Paw", 2);

DROP TABLE IF EXISTS hamsters;

CREATE TABLE hamsters 
(       
    Id INT AUTO_INCREMENT PRIMARY KEY, 
    Name VARCHAR(20), 
    Birthday DATE,
    Commands VARCHAR(50),
    type_id int,
    Foreign KEY (type_id) REFERENCES pets (Id) ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO hamsters (Name, Birthday, Commands, type_id)
VALUES ('Bonnie', '2020-01-01', 'Play dead', 3),
('Brut', '2024-01-01', "Good boy", 3),  
('Rat', '2022-01-01', 'Sit', 3);

DROP TABLE IF EXISTS horses;

CREATE TABLE horses 
(       
    Id INT AUTO_INCREMENT PRIMARY KEY, 
    Name VARCHAR(20), 
    Birthday DATE,
    Commands VARCHAR(50),
    type_id int,
    Foreign KEY (type_id) REFERENCES pack_animals (Id) ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO horses (Name, Birthday, Commands, type_id)
VALUES ('Thunder', '2020-01-01', 'Trot, Canter, Gallop', 1),
('Storm', '2017-03-12', "Trot, Canter", 1),  
('Blaze', '2016-07-12', "Jump, Gallop", 1);

DROP TABLE IF EXISTS donkeys;

CREATE TABLE donkeys 
(       
    Id INT AUTO_INCREMENT PRIMARY KEY, 
    Name VARCHAR(20), 
    Birthday DATE,
    Commands VARCHAR(50),
    type_id int,
    Foreign KEY (type_id) REFERENCES pack_animals (Id) ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO donkeys (Name, Birthday, Commands, type_id)
VALUES ('IA', '2019-04-10', "Walk, Bray, Carry Load", 2),
('Sancho', '2020-03-12', "Walk, Kick", 2),  
('Burro', '2021-07-12', "Gallop, Stay", 2);

DROP TABLE IF EXISTS camels;

CREATE TABLE camels 
(       
    Id INT AUTO_INCREMENT PRIMARY KEY, 
    Name VARCHAR(20), 
    Birthday DATE,
    Commands VARCHAR(50),
    type_id int,
    Foreign KEY (type_id) REFERENCES pack_animals (Id) ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO camels (Name, Birthday, Commands, type_id)
VALUES ('Sandy', '2022-04-10', 'Walk, Stay', 3),
('Dune', '2019-03-12', "Walk, Sit", 3),  
('Sahara', '2015-07-12', "Come, Stay", 3);

-- Удалить записи о верблюдах и объединить таблицы лошадей и ослов.

SET SQL_SAFE_UPDATES = 0;
DELETE FROM camels;

SELECT Name, Birthday, Commands FROM horses
UNION SELECT  Name, Birthday, Commands FROM donkeys;

-- Создать новую таблицу для животных в возрасте от 1 до 3 лет и вычислить их возраст с точностью до месяца.

CREATE TEMPORARY TABLE animal AS 
SELECT *, 'Horses' as type FROM horses
UNION SELECT *, 'Donkeys' AS type FROM donkeys
UNION SELECT *, 'Dogs' AS type FROM dogs
UNION SELECT *, 'Cats' AS type FROM cats
UNION SELECT *, 'Hamsters' AS type FROM hamsters;

CREATE TABLE young_animals AS
SELECT Name, Birthday, Commands, type, TIMESTAMPDIFF(MONTH, Birthday, CURDATE()) AS Age_in_month
FROM animal WHERE Birthday BETWEEN ADDDATE(curdate(), INTERVAL -3 YEAR) AND ADDDATE(CURDATE(), INTERVAL -1 YEAR);
 
SELECT * FROM young_animals;

-- Объединить все созданные таблицы в одну, сохраняя информацию о принадлежности к исходным таблицам.

SELECT h.Name, h.Birthday, h.Commands, pa.name, ya.Age_in_month 
FROM horses h
LEFT JOIN young_animals ya ON ya.Name = h.Name
LEFT JOIN pack_animals pa ON pa.Id = h.type_id
UNION 
SELECT don.Name, don.Birthday, don.Commands, pa.name, ya.Age_in_month 
FROM donkeys don 
LEFT JOIN young_animals ya ON ya.Name = don.Name
LEFT JOIN pack_animals pa ON pa.Id = don.type_id
UNION
SELECT c.Name, c.Birthday, c.Commands, pe.name, ya.Age_in_month 
FROM cats c
LEFT JOIN young_animals ya ON ya.Name = c.Name
LEFT JOIN pets pe ON pe.Id = c.type_id
UNION
SELECT d.Name, d.Birthday, d.Commands, pe.name, ya.Age_in_month 
FROM dogs d
LEFT JOIN young_animals ya ON ya.Name = d.Name
LEFT JOIN pets pe ON pe.Id = d.type_id
UNION
SELECT hm.Name, hm.Birthday, hm.Commands, pe.name, ya.Age_in_month 
FROM hamsters hm
LEFT JOIN young_animals ya ON ya.Name = hm.Name
LEFT JOIN pets pe ON pe.Id = hm.type_id;
