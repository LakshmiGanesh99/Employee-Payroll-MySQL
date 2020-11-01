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