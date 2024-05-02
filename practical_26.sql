-- Create an 'employee' database and 4 tables (hobby, employee, employee_salary, employee_hobby)
CREATE TABLE `hobby` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `employee` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `age` int NOT NULL,
  `mobile_number` varchar(17) NOT NULL,
  `address` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `employee_salary` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fk_employee_id` int NOT NULL,
  `salary` double DEFAULT NULL,
  `salary_date` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `employee_salary_fk` (`fk_employee_id`),
  CONSTRAINT `employee_salary_fk` FOREIGN KEY (`fk_employee_id`) REFERENCES `employee` (`id`) 
);

CREATE TABLE `employee_hobby` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fk_employee_id` int NOT NULL,
  `fk_hobby_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `employee_hobby_fk_1` (`fk_employee_id`),
  KEY `employee_hobby_fk_2` (`fk_hobby_id`),
  CONSTRAINT `employee_hobby_fk_1` FOREIGN KEY (`fk_employee_id`) REFERENCES `employee` (`id`),
  CONSTRAINT `employee_hobby_fk_2` FOREIGN KEY (`fk_hobby_id`) REFERENCES `hobby` (`id`)
);

-- Insert records into all tables
INSERT INTO hobby (name)
VALUES ('Cricket'), ('Chess'), ('Swimming'), ('To watch movies');

INSERT INTO employee (first_name, last_name, age, mobile_number, address)
VALUES ('Jayesh', 'Soni', 20, 8932545823, 'Lilanagar, Ahemdabad'),
	   ('Naitik', 'Bogdi', 23, 8278545389, 'Paladi, Ahemdabad'),
	   ('Harsh', 'Chaudhary', 25, 9876433254, 'Ayodhyanagar Society, Palanpur'),
	   ('Anand', 'Pate', 26, 8765349201, 'Chandralock Society, Palanpur');

INSERT INTO employee_salary (fk_employee_id, salary, salary_date)
VALUES (1, 15000, '2024-03-15'), (2, 10000, '2024-03-10'), (3, 18000, '2024-04-24'), (4, 20000, '2024-04-12'), (1, 15000, '2024-04-15'), (2, 10000, '2024-04-10');

INSERT INTO employee_hobby (fk_employee_id, fk_hobby_id)
VALUES (1, 2), (2, 3), (3, 1), (4, 4);

-- Update records of all tables
UPDATE employee
SET first_name = 'jayesh'
WHERE first_name = 'virat';

UPDATE employee
SET age = 28
WHERE first_name = 'Anand';

UPDATE hobby
SET name = 'Volly ball'
WHERE name = 'Swimming' ;

UPDATE hobby
SET name = 'To watch movies'
WHERE name = 'chess';

UPDATE employee_salary
SET salary = 13000
WHERE salary = 10000;

UPDATE employee_salary
SET salary_date = '2024-03-01'
WHERE salary_date = '2024-03-12';

UPDATE employee_hobby 
SET fk_hobby_id = 4
WHERE fk_employee_id = 2;

UPDATE employee_hobby
SET fk_hobby_id = 3
WHERE fk_employee_id = 4;

-- Delete records of all tables
DELETE
FROM employee_hobby
WHERE fk_hobby_id = 3;

DELETE
FROM employee_hobby
WHERE fk_employee_id = 1;

DELETE
FROM employee_salary
WHERE salary_date = '2024-03-15';

DELETE
FROM employee_salary
WHERE salary = 18000;

DELETE
FROM hobby
WHERE name = 'Volly ball';

DELETE
FROM hobby
WHERE name = 'To watch movies';

DELETE
FROM employee
WHERE id = 4;

DELETE
FROM employee
WHERE id = 1;

-- Truncate all tables.
TRUNCATE TABLE employee_hobby ;

TRUNCATE TABLE employee_salary ;

TRUNCATE TABLE hobby ;

TRUNCATE TABLE employee;

-- Create a separate select queries to get a hobby, employee, employee_salary, employee_hobby
SELECT *
FROM hobby;

SELECT *
FROM employee;

SELECT *
FROM employee_salary;

SELECT *
FROM employee_hobby;

-- Create a select single query to get all employee name, all hobby_name in single column
SELECT CONCAT(first_name, ' ', last_name) AS 'employee_name'
FROM employee
UNION ALL 
SELECT name FROM hobby;

--  Create a select query to get employee name, his/her employee_salary
SELECT CONCAT(e.first_name, ' ', e.last_name) AS 'employee_name', es.salary
FROM employee e
INNER JOIN employee_salary es ON es.fk_employee_id = e.id;

/* Create a select query to get employee name, total salary of employee,
hobby name(comma-separated- you need to use subquery for hobby name) */
SELECT CONCAT(e.first_name, ' ', e.last_name) AS 'employee_name', SUM(es.salary) AS 'total_salary',
	(SELECT GROUP_CONCAT(h.name SEPARATOR ', ')
	FROM hobby h 
	INNER JOIN employee_hobby eh ON eh.fk_hobby_id = h.id 
	WHERE eh.fk_employee_id = e.id) AS 'hobby' 
FROM employee e 
INNER JOIN employee_salary es ON es.fk_employee_id = e.id
GROUP BY es.fk_employee_id; 
