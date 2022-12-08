-- 【Costco mobile sales system】

DROP DATABASE IF EXISTS mobile_sales_system;
CREATE DATABASE IF NOT EXISTS mobile_sales_system;
USE mobile_sales_system;

DROP TABLE IF EXISTS phones;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS reservations;
DROP TABLE IF EXISTS stores;
DROP TABLE IF EXISTS plans;
DROP TABLE IF EXISTS telecom_company;
DROP TABLE IF EXISTS sales_order;

CREATE TABLE phones
(
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(30),
	down_payment FLOAT,
	monthly_pay FLOAT, 
	bonus_credit INT
);


CREATE TABLE customers
(
	id INT PRIMARY KEY AUTO_INCREMENT,
	first_name VARCHAR(30),
	last_name VARCHAR(30), 
	phone_number VARCHAR(12) UNIQUE, 
	email VARCHAR(30) UNIQUE
);

CREATE TABLE stores
(
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(30),
	address VARCHAR(30),
	city VARCHAR(30),
	province VARCHAR(2),
	postcode VARCHAR(6)
);

CREATE TABLE reservations
(
	id INT PRIMARY KEY AUTO_INCREMENT,
	datetime DATETIME,
	store_id INT,
	phone_id INT,
	customer_id INT,
	FOREIGN KEY(store_id) REFERENCES stores(id),
	FOREIGN KEY (phone_id) REFERENCES phones(id),
	FOREIGN KEY (customer_id) REFERENCES customers(id)
);

CREATE TABLE plans
(
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(30),
monthly_fee FLOAT
);

CREATE TABLE telecom_company
(
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(30),
plan_id INT,
FOREIGN KEY(plan_id) REFERENCES plans(id)
);

CREATE TABLE sales_order
(
	id INT PRIMARY KEY AUTO_INCREMENT,
	customer_id INT,
	store_id INT,
	company_id INT,
	plan_id INT,
	phone_id INT,
	FOREIGN KEY(customer_id) REFERENCES customers(id),
	FOREIGN KEY(store_id) REFERENCES stores(id),
	FOREIGN KEY(company_id) REFERENCES telecom_company(id),
	FOREIGN KEY(plan_id) REFERENCES plans(id),
	FOREIGN KEY(phone_id) REFERENCES phones(id)
);

INSERT INTO phones (name, down_payment, monthly_pay, bonus_credit) 
VALUES 
('iPhone11 64GB', null, 1.00, 300),
('iPhone12 64GB', null, 26.42, 250),
('iPhone13 128GB', null, 20.00, 250),
('iPhone13Pro 128GB', null, 44.59, 150),
('iPhone13ProMax 128GB', null, 51.23, 150),
('iPhone14 128GB', null, 35.38, 200),
('iPhone14Plus 128GB', null, 53.55, 200),
('iPhone14Pro 128GB', 579.99, 33.25, null),
('iPhone14ProMax 128GB', 746.99, 33.29, null),
('Google Pixel6A 128GB', null, 1.00, 250),
('Google Pixel7 128GB', null, 9.00, 250),
('Google Pixel7 128GB Pro', null, 30.00, 200),
('Samsung Galaxy ZFold 256GB', 747.99, 33.34, null),
('Samsung Galaxy A53 128GB', null, 0.99, 250),
('Samsung Galaxy S22 Ultra 128GB', 332.99, 33.33, 150)
;

insert into customers(first_name,last_name,phone_number,email)
values
('Emma','Smith','5144768989','Emma.smith@gmail.com'),
('Gob','Bluth','4384567689','Gob.bluth@gmail.com'),
('George','Williams','5145674567','George.williams@gmail.com'),
('Lucille','Armstrong','4384532345','Lucille.Armstrong@gmail.com'),
('Emily','Simmonds','5132347865','Emily.simmonds@gmail.com'),
('Chris','Martin','5146781231',null),
('Mark','Watkins','4387896542','mark.watkis@hotmail.com'),
('Kat','Nash','5147681457',null),
('Toby','West','4385554321',null),
('John','Taylor','5146781230','John.taylor@hotmail.com'),
('William','Jones','5146771234','william.jones@hotmail.com'),
('Samantha','Roth','5146776574','sa.roth@gmail.com'),
('Roby','Johnson','4388086771','ro.johnson@gmail.com')
;

INSERT INTO stores (name, address, city, province, postcode) 
VALUES 
('Bridge', '300 Rue Bridge', 'Montréal', 'QC', 'H3K2C3'),
('Brossard', '9430 Taschereau Blvd', 'Brossard', 'QC', 'J4X2W2'),
('Candiac', '60 Rue de Strasbourg', 'Candiac', 'QC', 'J5R0B4'),
('Marche Central', '1015 Rue du Marché Central', 'Montréal', 'QC', 'H4N3J8'),
('Point-Claire', '5701 Trans-Canada Hwy', 'Pointe-Claire', 'QC', 'H9R5E8')
;

insert into reservations(datetime,store_id,phone_id,customer_id)
values
('2022-11-25 10:10:23',1,1,1),
('2022-11-25 21:12:20',3,3,5),
('2022-11-25 13:13:23',2,4,3),
('2022-11-25 09:10:13',3,2,2),
('2022-11-25 09:10:23',5,3,4),
('2022-11-25 09:10:13',3,5,6),
('2022-11-25 09:10:23',1,1,8),
('2022-11-25 09:10:13',2,6,10),
('2022-11-25 09:10:23',4,7,7),
('2022-11-25 09:10:13',3,8,9),
('2022-11-25 09:30:13',5,8,11),
('2022-11-25 09:38:23',5,9,12),
('2022-11-25 09:56:23',1,13,13)
;

INSERT INTO plans(name, monthly_fee)
VALUES
('Rogers Infinite', 50.00),
('Bring Your Own Device', 35.00),
('Sweet Pay Plan', 45.00),
('Promo 55', 55.00),
('Unlimited Quebec Talk Plan', 22.00),
('100 Canada-Wide Talk', 15.00);

INSERT INTO telecom_company(name, plan_id)
VALUES
('Rogers', 1),
('Fido', 2),
('Virgin Plus', 3),
('Bell', 4),
('Lucky Mobile', 5),
('Chatr Mobile',6 );

INSERT INTO sales_order (customer_id, store_id, company_id, plan_id, phone_id) 
VALUES 
(1, 1, 1, 1, 1),
(2, 1, 2, 2, 2),
(3, 2, 3, 3, 3),
(4, 2, 4, 4, 4),
(5, 3, 5, 5, 5),
(6, 3, 6, 6, 6),
(7, 4, 1, 1, 7),
(8, 4, 2, 2, 8),
(9, 5, 3, 3, 9),
(10, 5, 4, 4, 10),
(1, 1, 6, 6, 11),
(2, 1, 5, 5, 12),
(3, 2, 4, 4, 13),
(4, 2, 3, 3, 14),
(5, 3, 2, 2, 15),
(6, 3, 1, 1, 6),
(7, 4, 4, 4, 7),
(8, 4, 3, 3, 8),
(9, 5, 2, 2, 9),
(10, 5, 1, 1, 10)
;

-- SOME QUERIES
-- Create a view name it as no_bonus that shows the email of the customer who doesn't have bonus_credit in his sales order.
CREATE VIEW no_bonus
AS
SELECT cu.email, ph.bonus_credit
FROM reservations rv
JOIN customers cu
ON cu.id = rv.customer_id
JOIN phones ph
ON rv.phone_id = ph.id
WHERE bonus_credit is NULL;

SELECT * FROM no_bonus;
DROP VIEW no_bonus;



-- Create a view name it as YUL_FidoUser that shows the all the customers'info who choose fido in montreal store. 
CREATE VIEW YUL_FidoUser
AS
SELECT DISTINCT cu.id, concat(cu.first_name,' ', cu.last_name) AS customerName, cu.phone_number, cu.email, tc.name AS telecom_company, st.city  
FROM customers cu
JOIN sales_order so
ON cu.id = so.customer_id
JOIN stores st
ON so.store_id = st.id
JOIN telecom_company tc
ON so.company_id = tc.id
WHERE city = 'Montréal'
AND tc.name = 'Fido';

SELECT * FROM YUL_FidoUser;
DROP VIEW YUL_FidoUser;



-- Create a view name it as iPhone_AVGMAX to show the reservation time and customer's name for those who choose iPhone, monthly pay between Average and Maximum, order them by their monthly pay (highest to lowest).
CREATE VIEW iPhone_AVGMAX AS
    SELECT 
        rv.datetime AS reservation_time,
        CONCAT(cu.first_name, ' ', cu.last_name) AS customerName,
        ph.name AS phone_name,
        ph.monthly_pay
    FROM
        reservations rv
            JOIN
        customers cu ON cu.id = rv.customer_id
            JOIN
        phones ph ON rv.phone_id = ph.id
    WHERE
        ph.name LIKE 'iPhone%'
    GROUP BY customerName
    HAVING ph.monthly_pay BETWEEN (SELECT AVG(monthly_pay) FROM phones) AND MAX(monthly_pay)
    ORDER BY ph.monthly_pay DESC;

SELECT 
    *
FROM
    iPhone_AVGMAX;
DROP VIEW iPhone_AVGMAX;



-- Write a procedure to calculate the total number of mobile models.
DELIMITER $$
CREATE PROCEDURE GetTotalModels()
BEGIN
    #declaration
    DECLARE totalModels INT default 0;
    
    # body
    SELECT COUNT(*)
    INTO totalModels
    FROM phones;
    
    # return
    SELECT totalModels AS TotalMobileModels;
END$$
DELIMITER ;
DROP PROCEDURE GetTotalModels;
CALL GetTotalModels();



-- Create a function that shows the type of the discount regarding the bonus credit on the phone models.
DELIMITER $$
CREATE Function DiscountType(bonus_credit INT)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
  DECLARE discountLevel VARCHAR(30);
  -- add logic
    IF bonus_credit >= 300 THEN
        SET discountLevel = 'VVIP Doorbuster Deal';
    ELSEIF (bonus_credit < 300 AND
            bonus_credit >= 150) THEN
        SET discountLevel = 'VIP discount';
    ELSEIF bonus_credit is NULL THEN
        SET discountLevel = 'No discount offered';
    END IF;
    
    RETURN (discountLevel);
END $$
DELIMITER ;

SELECT DISCOUNTTYPE(300) AS DiscountType_$300;
SELECT DISCOUNTTYPE(150) AS DiscountType_$150to$299;
SELECT DISCOUNTTYPE(NULL) AS DiscountType_$0;
DROP FUNCTION DiscountType;



-- Create a trigger that limit the amount of the bonus credit up to $300 on the phone models.
DELIMITER $$
CREATE TRIGGER before_bonus_credit_insert
BEFORE INSERT
ON phones FOR EACH ROW
BEGIN
    IF NEW.bonus_credit > 300 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'New bonus_credit cannot be over 300.';
    END IF;
END $$
DELIMITER ;

SHOW TRIGGERS;

insert into phones(name, down_payment, monthly_pay, bonus_credit)
VALUES ('iPhone15 2TB', null, 200.00, 300);

select * from phones where name = 'iPhone15 2TB';

insert into phones(name, down_payment, monthly_pay, bonus_credit)
VALUES ('iPhone16 3TB', null, 200.00, 301);

DROP TRIGGER IF EXISTS before_bonus_credit_insert;



-- Look for customer's names who chose given phone and have contact information (either email or phone number).
DELIMITER $$
CREATE PROCEDURE customers_ordered_phone(IN phone_name varchar(30), out customer_names varchar(3000))
BEGIN
    DECLARE finished INT DEFAULT 0;
    DECLARE customer_name varchar(100) DEFAULT "";
    declare curName cursor for
    SELECT CONCAT(c.FIRST_NAME, ' ', c.last_name)
    FROM phones p inner join sales_order so
      on p.id=so.phone_id
     inner join customers c
      on so.customer_id=c.id
    WHERE p.name like concat('%',phone_name,'%')
     and (c.email is not null or c.phone_number is not null);
    
   -- declare NOT FOUND handler
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;
    set customer_names = '';
    open curName;
    getName: LOOP
    FETCH curName INTO customer_name;
    IF finished = 1 THEN
        LEAVE getName;
    END IF;
    SET customer_names = CONCAT(customer_name, ',', customer_names);
    END LOOP getName;
   CLOSE curName;
END$$
DELIMITER ;
CALL customers_ordered_phone('iPhone13',@customer_names);
select @customer_names;
drop procedure customers_email;



-- Query the quantity of phones which were sold (best sell first).
create view best_sellerphone as
select ph.name, count(0) quantity
from phones ph
inner join sales_order so
on ph.id = so.phone_id
group by ph.name
order by count(0) desc
limit 1;
select * from best_sellerphone ;
DROP VIEW best_sellerphone;



-- provide a promotion for the clients whose monthly_fee more than $35.
DELIMITER $$
CREATE FUNCTION deducted_monthlyfee(plan_id int) RETURNS float
DETERMINISTIC
BEGIN
    declare monthlyfee float;
    DECLARE new_monthlyfee float;
    
    SELECT MONTHLY_FEE into monthlyfee  
    FROM PLANS
    where id=plan_id;
    
    IF monthlyfee > 35.00 THEN
        SET new_monthlyfee = monthlyfee-10;
    ELSEIF monthlyfee <35.00 THEN
        SET new_monthlyfee = monthlyfee;
    end if;
   RETURN new_monthlyfee;
   END$$
DELIMITER ;

SELECT deducted_monthlyfee(5);



-- count the ordered phone.
CREATE TABLE ordered_phone_count(
    phone_id INT primary key,
    total_quantity INT NOT NULL
);

DELIMITER $$
CREATE TRIGGER after_salesorder_insert
After INSERT
ON sales_order
FOR EACH ROW
BEGIN
   DECLARE count INT;
   SELECT COUNT(*)
   INTO count
   FROM ordered_phone_count
   where phone_id = NEW.phone_id;
   
   IF count > 0 THEN
    UPDATE ordered_phone_count
    SET total_quantity = total_quantity + 1
    where phone_id=NEW.phone_id;
   ELSE
    INSERT INTO ordered_phone_count
    VALUES (NEW.phone_id, 1);
   END IF;
   END$$
DELIMITER ;

insert sales_order (customer_id, store_id, company_id, plan_id, phone_id)
VALUES
(1, 1, 2, 1, 2);
insert sales_order (customer_id, store_id, company_id, plan_id, phone_id)
VALUES
(1, 1, 2, 1, 1);

drop trigger after_salesorder_insert;
drop table ordered_phone_count;



-- Create a VIEW that shows the 3 Highest Phone Plans By MonthlyFee and name it Top3HighestPlans.
CREATE VIEW  Top3HighestPlans
AS
    SELECT
    plans.id, plans.name AS PlanName,
    telecom_company.name AS TelecomCompany,
    plans.monthly_fee
    FROM plans
        INNER JOIN telecom_company ON plans.id = telecom_company.plan_id
    ORDER BY plans.monthly_fee DESC
    LIMIT 3;    
    
SELECT * FROM Top3HighestPlans;   
DROP VIEW Top3HighestPlans;



-- Create a PROCEDURE that returns all phones plans, (name and monthly fee) name it getAllPhonePlans.
DELIMITER $$
CREATE PROCEDURE getAllPhonePlans()
BEGIN
    SELECT plans.name,  plans.monthly_fee FROM plans;
END $$
DELIMITER ;

CALL getAllPhonePlans();
DROP PROCEDURE getAllPhonePlans;



-- Create a FUNCTION that returns the phone plan fee after a year (12 months) the function takes in an argument called "fee" of type float and name the function getAnnualFee.
DELIMITER $$
CREATE FUNCTION getAnnualFee(fee FLOAT)
RETURNS FLOAT
DETERMINISTIC
BEGIN
    DECLARE annualFee float;
    IF fee > 0 THEN
        SET annualFee = 12 * fee;
    END IF;
    RETURN (annualFee);
END $$
DELIMITER ;

SELECT getAnnualFee(35.00);
DROP FUNCTION getAnnualFee;



-- Create a trigger for when a new row is inserted insert in the plans table to check if a new monthly fee is greater than 20.00 $.
DELIMITER $$
CREATE TRIGGER validate_monthly_fee
BEFORE INSERT ON plans
FOR EACH ROW
BEGIN
    IF NEW.monthly_fee <= 20 THEN
    SIGNAL SQLSTATE '50001' SET MESSAGE_TEXT = 'Monthly fee must be greater than 20.00$';
    END IF;
END $$
DELIMITER ;

--  example
INSERT INTO plans(monthly_fee)
VALUES (15.00);

DROP TRIGGER validate_monthly_fee;



-- Select the telecom company with the lowest monthly fee phone plan and rename the column to lowest_monthly_fee.
SELECT telecom_company.name, MIN(plans.monthly_fee) AS lowest_monthly_fee
FROM telecom_company
INNER JOIN plans ON telecom_company.plan_id = plans.id
;



-- Select all phone plans with a monthly fee between 30 and 50 dollars.
SELECT * FROM plans
WHERE monthly_fee BETWEEN 30.00 AND 50.00;



-- Select all telecom_company names, monthly fee  order them by their monthly fee (highest to lowest)
SELECT  telecom_company.name, plans.monthly_fee FROM plans
INNER JOIN telecom_company ON telecom_company.plan_id = plans.id
ORDER BY plans.monthly_fee DESC;



-- select all customers whose phone number starts with area code [514].
select *
from customers
where SUBSTRING(phone_number, 1, 3) = '514';



-- select all customers whose email adress is from gmail.com.
SELECT * FROM customers WHERE email LIKE '%@gmail.com';



-- VIEW
-- show a summary of sales orders; displaying customers full names, the store name they bought from, the telecom company, the plan they bought and the phone they bought.
CREATE VIEW sales_order_summary AS 
SELECT so.id, customers.first_name, customers.last_name, stores.name 'store_name', telecom_company.name 'telecom_name', plans.name 'plan', phones.name 'phone'
FROM sales_order AS so
INNER JOIN customers ON so.customer_id = customers.id
INNER JOIN stores ON so.store_id = stores.id
INNER JOIN telecom_company ON so.store_id = telecom_company.id
INNER JOIN plans ON so.store_id = plans.id
INNER JOIN phones ON so.store_id = phones.id;



-- PROCEDURE: create a procedure that displays someones reservation depending on their inputed timeslot.
DROP PROCEDURE showReservations;
DELIMITER $$
CREATE PROCEDURE showReservations(IN mydate datetime)
BEGIN
	select reservations.datetime, customers.first_name, customers.last_name
    FROM reservations
    INNER JOIN customers ON reservations.id = customers.id
    WHERE reservations.datetime = mydate;
END$$
DELIMITER ;
CALL showReservations('2022-11-25 10:10:23');



-- create a function that calculates the remaining total cost for a customers' phone payment => phone payment per month + inputed months left.
DELIMITER $$

CREATE FUNCTION calcRemainingCost(
	monthlyPayment float,
    monthsLeft float
) 
RETURNS float
DETERMINISTIC
BEGIN
	DECLARE totalLeft float;
	SET totalLeft = monthlypayment * monthsLeft;
    RETURN (totalLeft);
END$$
DELIMITER ;



-- TRIGGER
-- create a before-delete trigger on 'phones' table to send deleted phones to an archive.
DROP TABLE IF EXISTS phoneArchive;    
CREATE TABLE phoneArchive (
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(30),
	down_payment FLOAT,
	monthly_pay FLOAT, 
	bonus_credit INT
);

DROP TRIGGER before_phones_delete;
DELIMITER $$
CREATE TRIGGER before_phones_delete
BEFORE DELETE
ON phones FOR EACH ROW
BEGIN
    INSERT INTO phoneArchive(name,down_payment,monthly_pay,bonus_credit)
    VALUES(OLD.name,OLD.down_payment,OLD.monthly_pay,OLD.bonus_credit);
END$$    
DELIMITER ;

INSERT INTO phones (name, down_payment, monthly_pay, bonus_credit) VALUES ('testphone', null, 1.00, 300);
DELETE from phones WHERE id = 16;