# UC1 creating a database
CREATE DATABASE payroll_service;
show databases;
USE payroll_service; 

# UC2 creating table
CREATE TABLE employee_payroll
(
id INT UNSIGNED NOT NULL auto_increment, name VARCHAR(150) NOT NULL,
salary DOUBLE NOT NULL,
start DATE NOT NULL,
PRIMARY KEY (id)
);

#UC3 inserting values
INSERT INTO employee_payroll (name, salary, start) VALUES
('Ganesh', 10000.00, '2018-04-01'), ('Rajan', 30000.00, '2019-04-01'),
('Priya', 15000.00, '2020-04-01');

#UC4 retrieving data
SELECT * FROM employee_payroll;

#UC5 viewing data with conditions
SELECT salary FROM employee_payroll WHERE name = 'Ganesh'; SELECT salary FROM employee_payroll
WHERE start BETWEEN CAST('2018-01-01' AS DATE) AND DATE(NOW());
