CREATE TABLE job (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(30),	
	min_salary DOUBLE NOT NULL,
	max_salary DOUBLE NOT NULL
);

CREATE TABLE country (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	country VARCHAR(30)
);

CREATE TABLE department (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(30),
	fk_country_id INT,
	FOREIGN KEY (fk_country_id) REFERENCES country(id)
);

CREATE TABLE employee (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	firstname VARCHAR(30),
	lastname VARCHAR(30),
	email VARCHAR(50),
	salary DOUBLE,
	fk_department_id INT,
	fk_job_id INT,
	FOREIGN KEY (fk_department_id) REFERENCES department(id),
	FOREIGN KEY (fk_job_id) REFERENCES job(id)
);

-- Get name (firstname + lastname), department name, country name, job name

SELECT CONCAT(e.firstname, " ", e.lastname) AS getname, j.name AS jobname, c.country AS countryname, d.name AS departmentname
FROM employee e, job j, country c, department d
WHERE e.fk_job_id = j.id AND e.fk_department_id = d.id AND d.fk_country_id = c.id;

-- Get 2nd highest salary of the employee

SELECT MAX(salary) AS second_highest_salary FROM employee WHERE salary < (SELECT MAX(salary) FROM employee);

SELECT salary AS second_highest_salary FROM employee 
GROUP BY salary
ORDER BY salary DESC LIMIT 1,1;

-- Get all job name and department name in single query

SELECT name FROM job 
UNION 
SELECT name FROM department;
