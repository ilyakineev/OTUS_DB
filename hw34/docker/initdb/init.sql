-- Создание базы данных my_db, если она еще не существует
CREATE DATABASE IF NOT EXISTS my_db;

-- Использование базы данных my_db
USE my_db;

-- Создание таблицы "Страны" (Countries)
CREATE TABLE IF NOT EXISTS Countries
(
    country_id INT PRIMARY KEY AUTO_INCREMENT,
    country    VARCHAR(255) NOT NULL
);

-- Создание таблицы "Города" (Cities)
CREATE TABLE IF NOT EXISTS Cities
(
    city_id INT PRIMARY KEY AUTO_INCREMENT,
    city    VARCHAR(255) NOT NULL
);

-- Создание таблицы "Улицы" (Streets)
CREATE TABLE IF NOT EXISTS Streets
(
    street_id INT PRIMARY KEY AUTO_INCREMENT,
    street    VARCHAR(255) NOT NULL
);

-- Создание таблицы "Почтовые индексы" (Postal_Codes)
CREATE TABLE IF NOT EXISTS Postal_Codes
(
    postal_code_id INT PRIMARY KEY AUTO_INCREMENT,
    postal_code    VARCHAR(50) NOT NULL
);

-- Создание таблицы "Регионы" (Regions)
CREATE TABLE IF NOT EXISTS Regions
(
    region_id INT PRIMARY KEY AUTO_INCREMENT,
    region    VARCHAR(50) NOT NULL
);

-- Создание таблицы "Здания" (Buildings)
CREATE TABLE IF NOT EXISTS Buildings
(
    building_id     INT PRIMARY KEY AUTO_INCREMENT,
    building_number VARCHAR(50) NOT NULL
);

-- Создание таблицы "Адреса" (Addresses)
CREATE TABLE IF NOT EXISTS Addresses
(
    address_id     INT PRIMARY KEY AUTO_INCREMENT,
    country_id     INT,
    city_id        INT,
    postal_code_id INT,
    region_id      INT,
    building_id    INT,
    street_id      INT,
    FOREIGN KEY (country_id) REFERENCES Countries (country_id),
    FOREIGN KEY (city_id) REFERENCES Cities (city_id),
    FOREIGN KEY (postal_code_id) REFERENCES Postal_Codes (postal_code_id),
    FOREIGN KEY (region_id) REFERENCES Regions (region_id),
    FOREIGN KEY (building_id) REFERENCES Buildings (building_id),
    FOREIGN KEY (street_id) REFERENCES Streets (street_id)
);

-- Создание таблицы "Клиенты" (Customers)
CREATE TABLE IF NOT EXISTS Customers
(
    customer_id             INT PRIMARY KEY AUTO_INCREMENT,
    title                   VARCHAR(50),
    first_name              VARCHAR(255),
    last_name               VARCHAR(255),
    correspondence_language VARCHAR(50),
    birth_date              VARCHAR(255),
    gender                  VARCHAR(10),
    marital_status          VARCHAR(50),
    address_id              INT,
    FOREIGN KEY (address_id) REFERENCES Addresses (address_id)
);


-- Создать временную таблицу для загрузки данных
CREATE TEMPORARY TABLE tmp_countries LIKE Countries;

ALTER TABLE Countries
    ADD UNIQUE KEY (country);

-- Загрузить данные во временную таблицу
LOAD DATA INFILE '/some_customers.csv'
    INTO TABLE tmp_countries
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
    (@dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, country, @dummy, @dummy, @dummy, @dummy, @dummy);

-- Вставить данные из временной таблицы в основную таблицу, игнорируя дубликаты
INSERT IGNORE INTO Countries (country)
SELECT country
FROM tmp_countries;

-- Удалить временную таблицу
DROP TEMPORARY TABLE IF EXISTS tmp_countries;

-- Создать временную таблицу для загрузки данных
CREATE TEMPORARY TABLE tmp_cities LIKE Cities;

ALTER TABLE Cities
    ADD UNIQUE KEY (city);

LOAD DATA INFILE '/some_customers.csv'
    INTO TABLE tmp_cities
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
    (@dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, city, @dummy, @dummy);

-- Вставить данные из временной таблицы в основную таблицу, игнорируя дубликаты
INSERT IGNORE INTO Cities (city)
SELECT city
FROM tmp_cities;

-- Удалить временную таблицу
DROP TEMPORARY TABLE IF EXISTS tmp_cities;

-- Создать временную таблицу для загрузки данных
CREATE TEMPORARY TABLE tmp_streets LIKE Streets;

ALTER TABLE Streets
    ADD UNIQUE KEY (street);

LOAD DATA INFILE '/some_customers.csv'
    INTO TABLE tmp_streets
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
    (@dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, street, @dummy);

-- Вставить данные из временной таблицы в основную таблицу, игнорируя дубликаты
INSERT IGNORE INTO Streets (street)
SELECT street
FROM tmp_streets;

-- Удалить временную таблицу
DROP TEMPORARY TABLE IF EXISTS tmp_streets;

-- Создать временную таблицу для загрузки данных
CREATE TEMPORARY TABLE tmp_regions LIKE Regions;

ALTER TABLE Regions
    ADD UNIQUE KEY (region);

-- Загрузить данные из файла во временную таблицу
LOAD DATA INFILE '/some_customers.csv'
    INTO TABLE tmp_regions
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
    (@dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, region, @dummy, @dummy, @dummy);

-- Вставить данные из временной таблицы в основную таблицу, игнорируя дубликаты
INSERT IGNORE INTO Regions (region)
SELECT region
FROM tmp_regions;

-- Удалить временную таблицу
DROP TEMPORARY TABLE IF EXISTS tmp_regions;

-- Создать временную таблицу для загрузки данных
CREATE TEMPORARY TABLE tmp_buildings LIKE Buildings;

ALTER TABLE Buildings
    ADD UNIQUE KEY (building_number);

-- Загрузить данные из файла во временную таблицу
LOAD DATA INFILE '/some_customers.csv'
    INTO TABLE tmp_buildings
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
    (@dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, building_number);

-- Вставить данные из временной таблицы в основную таблицу, игнорируя дубликаты
INSERT IGNORE INTO Buildings (building_number)
SELECT building_number
FROM tmp_buildings;

-- Удалить временную таблицу
DROP TEMPORARY TABLE IF EXISTS tmp_buildings;

-- Создать временную таблицу для загрузки данных
CREATE TEMPORARY TABLE tmp_postal_codes LIKE Postal_Codes;

ALTER TABLE Postal_Codes
    ADD UNIQUE KEY (postal_code);

-- Загрузить данные из файла во временную таблицу
LOAD DATA INFILE '/some_customers.csv'
    INTO TABLE tmp_postal_codes
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
    (@dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, postal_code, @dummy, @dummy, @dummy, @dummy);

-- Вставить данные из временной таблицы в основную таблицу, игнорируя дубликаты
INSERT IGNORE INTO Postal_Codes (postal_code)
SELECT postal_code
FROM tmp_postal_codes;

-- Удалить временную таблицу
DROP TEMPORARY TABLE IF EXISTS tmp_postal_codes;

LOAD DATA INFILE '/some_customers.csv'
    INTO TABLE Addresses
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
    (@dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @country, @postal_code, @region, @city, @street,
     @building_number)
    SET country_id = (SELECT country_id
                      FROM Countries
                      WHERE country = @country
                      LIMIT 1),
        city_id = (SELECT city_id
                   FROM Cities
                   WHERE city = @city
                   LIMIT 1),
        postal_code_id = (SELECT postal_code_id
                          FROM Postal_Codes
                          WHERE postal_code = @postal_code
                          LIMIT 1),
        region_id = (SELECT region_id
                     FROM Regions
                     WHERE region = @region
                     LIMIT 1),
        building_id = (SELECT building_id
                       FROM Buildings
                       WHERE building_number = @building_number
                       LIMIT 1),
        street_id = (SELECT street_id
                     FROM Streets
                     WHERE street = @street
                     LIMIT 1);

LOAD DATA INFILE '/some_customers.csv'
    INTO TABLE Customers
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
    (title, first_name, last_name, correspondence_language, birth_date, gender, marital_status, @country, @postal_code,
     @region, @city, @street, @building_number)
    SET address_id = (SELECT a.address_id
                      FROM Addresses a
                               JOIN Countries c ON a.country_id = c.country_id
                               JOIN Cities ci ON a.city_id = ci.city_id
                               JOIN Postal_Codes pc ON a.postal_code_id = pc.postal_code_id
                               JOIN Regions r ON a.region_id = r.region_id
                               JOIN Streets s ON a.street_id = s.street_id
                               JOIN Buildings b ON a.building_id = b.building_id
                      WHERE (c.country = @country OR @country like '""')
                        AND (ci.city = @city OR @city like '""')
                        AND (pc.postal_code = @postal_code OR @city like '""')
                        AND (r.region = @region OR @city like '""')
                        AND (b.building_number = @building_number OR @city like '""')
                        AND (s.street = @street OR @city like '""')
                      LIMIT 1);