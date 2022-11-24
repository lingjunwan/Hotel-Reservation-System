DROP DATABASE IF EXISTS RSM;
CREATE DATABASE IF NOT EXISTS RSM;

USE RSM;

DROP TABLE IF EXISTS hotels;
DROP TABLE IF EXISTS clients;
DROP TABLE IF EXISTS rooms;
DROP TABLE IF EXISTS reservations;

CREATE TABLE hotels
(
	hotel_id INT PRIMARY KEY,
    hotel_name VARCHAR(20),
    street VARCHAR(20),
    state VARCHAR(20),
    country VARCHAR(20)
);

CREATE TABLE clients
(
	client_id INT PRIMARY KEY,
    client_first_name VARCHAR(30),
    client_last_name VARCHAR(30),
    client_address VARCHAR(100),
    birth_date DATE,
    phone_number VARCHAR(11) UNIQUE
);

CREATE TABLE rooms
(
	room_number INT PRIMARY KEY,
    room_type VARCHAR(20),
    room_view VARCHAR(20),
    room_status VARCHAR(20),
    hotel_id INT,
    FOREIGN KEY(hotel_id) REFERENCES hotels(hotel_id)
);

CREATE TABLE reservations
(
	reserve_num INT PRIMARY KEY,
    client_id INT,
    hotel_id INT,
    reserve_status VARCHAR(20),
    room_num INT,
    checking_date DATE,
    checkout_date DATE,
    FOREIGN KEY(client_id) REFERENCES clients(client_id),
	FOREIGN KEY(hotel_id) REFERENCES hotels(hotel_id),
    FOREIGN KEY(room_num) REFERENCES rooms(room_number)
);



INSERT INTO hotels (hotel_id, hotel_name, street, state, country) 
VALUES 
(1,'Hotel A','1 Martin Street','QC','Canada'),
(2,'Hotel B','2 Martin Street','QC','Canada'),
(3,'Hotel C','3 East Street','ON','Canada'),
(4,'Hotel D','4 USA Street','Texas','USA')
;

INSERT INTO clients (client_id, client_first_name, client_last_name, client_address, birth_date, phone_number) 
VALUES 
(001,'Reza','Shalchian','1 Martin Street','1991-01-01','5140000001'),
(002,'Tom','Apple','2 Martin Street','1992-03-02','4380000002'),
(003,'Tom','Ball','3 Martin Street','1993-03-03','4380000003'),
(004,'Tom','Catie','4 Martin Street','1994-03-09','5120000004')
;

INSERT INTO rooms (room_number, room_type, room_view, room_status, hotel_id) 
VALUES 
(0001,'single bed','beach','not reserved',1),
(0002,'double','beach','not reserved',2),
(0003,'single bed','beach','reserved',3),
(0004,'single bed','yard','not reserved',4),
(0005,'honeymoon suit','yard','not reserved',1),
(0006,'single bed','yard','not reserved',1),
(0007,'single bed','yard','not reserved',1),
(0008,'single bed','yard','not reserved',1),
(0009,'double','beach','reserved',2)
;

INSERT INTO reservations (reserve_num, client_id, hotel_id, reserve_status, room_num, checking_date, checkout_date) 
VALUES 
(01, 001, 1, 'confirmed', 0001, '2023-02-01', '2023-02-02'),
(02, 002, 2, 'not confirmed', 0002, '2023-02-03', '2023-02-04'),
(03, 003, 3, 'confirmed', 0003, '2023-02-02', '2023-02-05'),
(04, 004, 4, 'confirmed', 0004, '2023-01-02', '2023-01-05')
;
SELECT * FROM clients;
SELECT * FROM rooms;
SELECT * FROM reservations;

-- 1- Create a query to give all the hotels in ‘QC’ which is in Canada
SELECT * FROM hotels WHERE state = 'QC' AND country = 'Canada';

-- 2- Create a query that returns all the first_name and last_name with “: ” seperated
-- (Reza:Shalchian) as 1 field ‘client_name’ who have birthday in March
SELECT client_id, CONCAT(client_first_name,':',client_last_name) AS client_name, birth_date
FROM clients
WHERE birth_date like '%03-%';

-- 3- Create a query to give all the rooms that are ‘single bed’ and not reserved as status
SELECT room_number, room_type, room_view, room_status, hotel_id
FROM rooms
WHERE room_type = 'single bed' 
AND
room_status = 'not reserved';

-- 4- Create a query that return count of all the reservations that the status of reservation is
-- confirmed.
SELECT COUNT(*)
FROM reservations
WHERE reserve_status = 'confirmed';

-- 5- Create a query to show all reservations that checking in dates are in 2023-02
SELECT *
FROM reservations
WHERE checking_date LIKE '2023-02%';

-- 6- Create a query that shows all the room types and count of each.
-- a. ‘single bed’, 6
-- b. ‘double’, 2
-- c. ‘honeymoon suit’ , 1
SELECT room_type, COUNT(*)
FROM rooms
GROUP BY room_type;

-- 7- Create a query that sorts all the client by their birthdate and shows 3 of oldest customers
SELECT *
FROM clients
ORDER BY birth_date ASC
LIMIT 3;

-- 8- Create a query that gives the customers who have a phone number that has area code 438 or
-- 512
SELECT *
FROM clients
WHERE substr(phone_number, 1,3) 
IN ('438','512');
