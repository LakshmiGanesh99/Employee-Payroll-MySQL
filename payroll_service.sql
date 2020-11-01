# UC1 creating a database
CREATE DATABASE payroll_service;
show databases;
USE payroll_service; 

# UC2 creating table
CREATE TABLE employee_payroll
(
id INT UNSIGNED NOT NULL auto_increment, name VARCHAR(150) NOT NULL,
name     VARCHAR(150) NOT NULL,
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

#UC6 adding a gender colum and adding data for each row
SET SQL_SAFE_UPDATES=0;
ALTER TABLE employee_payroll ADD gender CHAR(1) AFTER name; 
UPDATE employee_payroll SET gender = 'M' WHERE name = 'Ganesh'; 
UPDATE employee_payroll SET gender = 'M' WHERE name = 'Rajan'; 
UPDATE employee_payroll SET gender = 'F' WHERE name = 'Priya';

#UC7 doing some basinc operations
SELECT SUM(salary) FROM employee_payroll WHERE gender = 'F' GROUP BY gender; SELECT SUM(salary) FROM employee_payroll WHERE gender = 'M' GROUP BY gender; SELECT AVG(salary) FROM employee_payroll WHERE gender = 'F' GROUP BY gender; SELECT AVG(salary) FROM employee_payroll
WHERE gender = 'M' GROUP BY gender;
SELECT MIN(salary) FROM employee_payroll
WHERE gender = 'F' GROUP BY gender;
SELECT MAX(salary) FROM employee_payroll
WHERE gender = 'M' GROUP BY gender;
SELECT gender, AVG(salary) FROM employee_payroll GROUP BY GENDER;

#UC8 Ability to extend employee_payroll data to store employee information like employee phone, address and department
ALTER TABLE employee_payroll 
ADD COLUMN phone VARCHAR(13) AFTER name,
ADD COLUMN address VARCHAR(250) DEFAULT 'India' AFTER phone,
ADD COLUMN department VARCHAR(150) NOT NULL AFTER address;
SELECT * FROM employee_payroll;

#UC9 
ALTER TABLE employee_payroll 
ADD COLUMN basic_pay DOUBLE NOT NULL AFTER gender,
ADD COLUMN deductions DOUBLE NOT NULL AFTER basic_pay,
ADD COLUMN taxable_pay DOUBLE NOT NULL AFTER deductions,
ADD COLUMN tax DOUBLE NOT NULL AFTER taxable_pay,
ADD COLUMN net_pay DOUBLE NOT NULL AFTER tax;
SELECT * FROM employee_payroll;

#UC10
SET SQL_SAFE_UPDATES = 0;
UPDATE employee_payroll SET department = 'sales' WHERE name = 'Priya';
INSERT INTO employee_payroll (name,phone,address,department,gender,basic_pay,deductions,taxable_pay,tax,net_pay,start) VALUES
('Terisa','1231231231','Goa','marketing','F',300000.00,100000,2000000,500000,1500000,'2020-05-21');
SELECT * FROM employee_payroll;

#UC11
DROP TABLE payroll;

CREATE TABLE payroll (
  payroll_id VARCHAR(6) NOT NULL,
  basic_pay DOUBLE NOT NULL,
  deductions DOUBLE NOT NULL,
  taxable_pay DOUBLE NOT NULL,
  tax DOUBLE NOT NULL,
  net_pay DOUBLE NOT NULL,
  PRIMARY KEY (payroll_id)
);

CREATE TABLE Employee_Details (
   id INT unsigned NOT NULL auto_increment,
   name VARCHAR(150) NOT NULL,
   phone VARCHAR(10),
   address VARCHAR(250),
   gender CHAR(1),
   start_date DATE NOT NULL,
   payroll_id VARCHAR(6) NOT NULL,
   PRIMARY KEY (id),
   FOREIGN KEY (payroll_id) REFERENCES payroll (payroll_id)
);

CREATE TABLE Department (
  department_id VARCHAR(6) NOT NULL,
  department VARCHAR(150) NOT NULL,
  PRIMARY KEY (department_id)
);

CREATE TABLE Employee_Dep (
  id INT UNSIGNED NOT NULL auto_increment,
  dep_id VARCHAR(6) NOT NULL,
  FOREIGN KEY (id) REFERENCES employee_details (id),
  FOREIGN KEY (dep_id) REFERENCES department (department_id)
);

INSERT INTO payroll(payroll_id,basic_pay,deductions,taxable_pay,tax,net_pay) VALUES
('PID001',30000,10000,20000,2000,18000),
('PID002',50000,10000,40000,4000,36000),
('PID003',40000,10000,30000,3000,27000);
SELECT * FROM payroll;

INSERT INTO employee_details (name,phone,address,gender,start_date,payroll_id) VALUES
('Bill','1231231231','Pune','M','2020-05-21','PID001'),
('Mark','3213213213','Goa','M','2020-01-15','PID002'),
('Terisa','9879879879','Pune','F','2019-011-01','PID003');
SELECT * FROM employee_details;

INSERT INTO department(department_id,department) VALUES
('DEP000', 'training'),
('DEP001', 'sales'),
('DEP002', 'marketing'),
('DEP003', 'HR');
SELECT * FROM department;

INSERT INTO employee_dep(id,dep_id) VALUES
(1,'DEP000'),
(2,'DEP003'),
(3,'DEP001'),
(3,'DEP002');
SELECT * FROM employee_dep;

SELECT gender,SUM(net_pay),AVG(net_pay),MIN(net_pay),MAX(net_pay) 
FROM employee_details JOIN payroll 
ON employee_details.payroll_id = payroll.payroll_id
WHERE gender = 'M' ;  

SELECT gender,SUM(net_pay),AVG(net_pay),MIN(net_pay),MAX(net_pay) 
FROM employee_details JOIN payroll 
ON employee_details.payroll_id = payroll.payroll_id
WHERE gender = 'F' ; 

select gender,COUNT(*) from employee_details group by gender;

#UC12

SELECT name,basic_pay,deductions,taxable_pay,tax,net_pay 
FROM employee_details JOIN payroll 
ON employee_details.payroll_id = payroll.payroll_id
HAVING name = 'Bill';               

SELECT start_date,name,basic_pay,deductions,taxable_pay,tax,net_pay 
FROM employee_details JOIN payroll 
ON employee_details.payroll_id = payroll.payroll_id
HAVING start_date BETWEEN CAST('2018-01-01' as date) and date(now());
