drop database if exists cinema_booking_system;
create database cinema_booking_system;
use cinema_booking_system;

drop table if exists reserved_seat;
drop table if exists bookings;
drop table if exists screening;
drop table if exists films;
drop table if exists customers;
drop table if exists seats;
drop table if exists rooms;


create table films(
	id bigint not null primary key auto_increment,
	film_name varchar(50),
	length time
);

create table customers(
	id bigint not null primary key auto_increment,
	first_name varchar(30),
	last_name varchar(30),
	email varchar(100)
);

create table rooms(
	id bigint not null primary key auto_increment,
	room_name varchar(30),
	no_seats int unsigned
);

create table screening(
	id bigint not null primary key auto_increment,
	film_id bigint,
	room_id bigint,
	start_time datetime,
	foreign key (film_id) references films(id),
	foreign key (room_id) references rooms(id)
);

create table seats(
	id bigint not null primary key auto_increment,
	row_seat varchar(10),
	number_seat int unsigned,
	room_id bigint,
	foreign key (room_id) references rooms(id)
);


create table bookings(
	id bigint not null primary key auto_increment,
	screening_id bigint,
	customer_id bigint,
	foreign key (screening_id) references screening(id),
	foreign key (customer_id) references customers(id)
);

create table reserved_seat(
	id bigint not null primary key auto_increment,
	booking_id bigint,
	seat_id bigint,
	foreign key (booking_id) references bookings(id),
	foreign key (seat_id) references seats(id)
);

show tables;

insert into films(film_name, length)
values('StarWars','3:30:00'),
('StarWars1','3:30:00'),
('StarTrek1','3:30:00'),
('StarTrek2','3:00:00'),
('StarTrek3','3:30:00'),
('StarTrek4','3:00:00'),
('StarTrek5','3:25:00'),
('StarshipTroopers1','3:00:00'),
('StarshipTroopers2','3:00:00'),
('PitchBlack1','3:40:00'),
('PitchBlack2','3:45:00');

insert into customers(first_name, last_name)
values
('FFF111','LLL6'),
('FFF18','LLL9');
insert into customers(first_name, last_name, email)
values('reza','LLL2','test1@gmail.com'),
('FFF1','reza','test1@gmail.com'),
('FFF1','LLL2','test1@gmail.com'),
('FFF1','LLL3','test2@gmail.com'),
('FFF2','LLL2','test3@gmail.com'),
('FFF3','LLL4','tes41@gmail.com'),
('FFF4','LLL4','test5@gmail.com'),
('FFF5','LLL2','test6@gmail.com'),
('FFF3','LLL4','test7@gmail.com');

insert into rooms(room_name, no_seats)
values('bluemoon1',200),
('bluemoon2',200),
('sunrise1',50),
('sunrise2',50),
('bluemoon3', 180);

select * from films;
select * from rooms;
select * from screening;
select * from seats;
select * from customers;
select * from bookings;


insert into screening(film_id, room_id, start_time)
values(1, 1,'2022-12-20 19-00-00'),
(2, 2,'2022-12-22 19-00-00'),
(3, 4,'2022-12-22 19-00-00'),
(4, 3,'2022-12-22 23-00-00'),
(5, 4,'2022-12-22 19-00-00'),
(6, 4,'2022-12-22 23-00-00'),
(7, 1,'2022-12-23 11-00-00'),
(8,3,'2022-12-23 11-00-00'),
(9, 2,'2022-12-23 16-00-00');

insert into seats(row_seat, number_seat, room_id)
values('A', 1, 1),
('A',11, 2),
('A',12, 3),
('A',13, 3),
('A',14, 1),
('A',15, 4),
('A',16,5),
('A',17, 1),
('A',18,2),
('A',19,2),
('AA',1,1),
('BB',16,3),
('A',1,1);

insert into bookings(screening_id,customer_id)
values(1, 1),(2, 1),(3, 3),(4, 4),(5, 5),(6, 6),(7, 7),(8, 8),(9, 11) ;

insert into reserved_seat(booking_id,seat_id)
values(1, 13),(2, 12),(3, 11),(4, 12),(5, 11),(6, 10),(7, 9);


-- List of all the customers who does not have email
SELECT * 
FROM customers
WHERE email is null;

--  List of all the rooms that they play 'starwars'
-- FILMS to query the film name
-- rooms

SELECT sc.start_time, films.film_name, rooms.room_name
FROM screening sc
INNER JOIN films on films.id = sc.film_id 
INNER JOIN rooms on rooms.id = sc.room_id
WHERE films.film_name = 'StarWars' ;

--  List of all the reserved_seats that is related to customer name 'reza'
SELECT *
FROM reserved_seat rs
INNER JOIN bookings on bookings.id = rs.booking_id
INNER JOIN customers on customers.id = bookings.customer_id
-- INNER JOIN screening on bookings.screening_id = screening.id
WHERE customers.first_name = 'reza';

-- Show the count of OCCUPIED seats that are in each room
SELECT count(seat_id), room_id
FROM reserved_seat
Inner join seats on seats.id = reserved_seat.seat_id
group by room_id;

-- List all the films that are longer than 2 hours
SELECT *
FROM films
where time_to_sec(length)>(60 * 60 * 2);
  
-- show all the rooms sorted by number of seats descending

select * from rooms
order by no_seats desc;

--  show the row number and seat numbers that are occupied by 'reza'
select row_seat, number_seat, first_name, last_name
from reserved_seat
inner join bookings
inner join customers
inner join seats
on reserved_seat.seat_id = seats.id 
and reserved_seat.booking_id = bookings.id 
and bookings.customer_id = customers.id 
where customers.first_name = 'reza' or customers.last_name = 'reza';