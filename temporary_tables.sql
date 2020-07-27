USE darden_1033;
-- 1. Using the example from the lesson, re-create the employees_with_departments table.
CREATE TEMPORARY TABLE employees_with_departments AS
SELECT employees.emp_no, employees.first_name, employees.last_name, departments.dept_no, departments.dept_name
FROM employees.employees
JOIN employees.dept_emp USING(emp_no)
JOIN employees.departments USING(dept_no)
;
SELECT *
FROM employees_with_departments;
-- 1-A. Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns
ALTER TABLE employees_with_departments ADD full_name VARCHAR(41);

-- 1-B Update the table so that full name column contains the correct data
UPDATE employees_with_departments
SET full_name = CONCAT(first_name, ' ', last_name);
SELECT * 
FROM employees_with_departments;

-- 1-C. Remove the first_name and last_name columns from the table.
ALTER TABLE employees_with_departments
DROP COLUMN first_name;
ALTER TABLE employees_with_departments
DROP COLUMN last_name;
SELECT * 
FROM employees_with_departments;

-- 1-D. What is another way you could have ended up with this same table?
CREATE TEMPORARY TABLE employees_w_departments AS
SELECT employees.emp_no, CONCAT(employees.first_name, ' ', employees.last_name) AS 'full_name', departments.dept_no, departments.dept_name
FROM employees.employees
JOIN employees.dept_emp USING(emp_no)
JOIN employees.departments USING(dept_no)
;
SELECT *
FROM employees_w_departments;

-- 2. Create a temporary table based on the payment table from the sakila database.
USE darden_1033;
CREATE TEMPORARY TABLE payment AS
SELECT payment.payment_id, payment.customer_id, payment.staff_id, payment.rental_id, payment.amount, payment.payment_date, payment.last_update
FROM sakila.payment;
SELECT * FROM payment;

-- 2-A. Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.
CREATE TEMPORARY TABLE paymentss AS
SELECT *, AMOUNT * 100 AS pennies
FROM sakila.payment;

SELECT * FROM paymentss;

ALTER TABLE paymentss MODIFY pennies INT UNSIGNED;
SELECT * FROM paymentss;
ALTER TABLE payments
DROP COLUMN amount;

SELECT *, pennies as 'amount'
from paymentss;
/* 3.Find out how the average pay in each department compares to the overall average pay. In order to make the comparison easier, you should use the Z-score for salaries. In terms of salary, what is the best department to work for? The worst?


+--------------------+-----------------+
| dept_name          | salary_z_score  | 
+--------------------+-----------------+
| Customer Service   | -0.273079       | 
| Development        | -0.251549       | 
| Finance            |  0.378261       | 
| Human Resources    | -0.467379       | 
| Marketing          |  0.464854       | 
| Production         | -0.24084        | 
| Quality Management | -0.379563       | 
| Research           | -0.236791       | 
| Sales              |  0.972891       | 
+--------------------+-----------------+ */
CREATE TABLE salaries_with_departments AS 
SELECT
e.*,
s.salary,
d.dept_name as department,
d.dept_no
FROM employees.employees AS e
JOIN employees.salaries AS s USING(emp_no)
JOIN employees.dept_emp AS de USING(emp_no)
JOIN employees.departments AS d USING (dept_no)
WHERE s.to_date > curdate()
AND de.to_date > curdate();
SELECT * FROM salaries_with_departments LIMIT 50;

ALTER TABLE salaries_with_departments 
ADD mean_salary FLOAT;
ALTER TABLE salaries_with_departments
ADD sd_salary FLOAT;
ALTER TABLE salaries_with_departments
ADD z_salary FLOAT;
CREATE TEMPORARY TABLE salary_aggregates AS
SELECT
	AVG(salary) AS mean,
	STDDEV(salary) AS sd
FROM salaries_with_departments;

SELECT * FROM salary_aggregates;

UPDATE salaries_with_departments 
SET mean_salary = (
	SELECT mean FROM salary_aggregates);
UPDATE salaries_with_departments
SET sd_salary = (
	SELECT sd FROM salary_aggregates);
UPDATE salaries_with_departments
SET z_salary = (
	salary - mean_salary) 
	/ sd_salary;
SELECT department, AVG(z_salary) AS z_salary
FROM salaries_with_departments
GROUP BY department
ORDER BY z_salary;