USE employees;
# Find all the employees with the same hire date as employee 101010 using a sub-query. 69 Rows
SELECT e.hire_date, e.first_name, e.last_name 
FROM employees AS e
WHERE e.hire_date = (SELECT hire_date FROM employees WHERE emp_no = '101010');


# Find all the titles held by all employees with the first name Aamod. 314 total titles, 6 unique titles
SELECT t.title, COUNT(t.title)
FROM employees AS e
JOIN titles AS t ON t.emp_no = e.emp_no
WHERE e.emp_no IN (
    SELECT e.emp_no
    FROM employees
    WHERE e.first_name = 'Aamod')
GROUP BY t.title;

-- Or

SELECT title
FROM titles
WHERE emp_no IN (
	SELECT emp_no
	FROM employees
	WHERE first_name = "Aamod");


# How many people in the employees table are no longer working for the company?
SELECT * 
FROM employees
WHERE emp_no NOT IN (
	SELECT emp_no
	FROM dept_emp
	WHERE to_date > curdate())
;
/* Find all the current department managers that are female.


+------------+------------+
| first_name | last_name  |
+------------+------------+
| Isamu      | Legleitner |
| Karsten    | Sigstam    |
| Leon       | DasSarma   |
| Hilary     | Kambil     |
+------------+------------+ */
SELECT  first_name, last_name
FROM employees
WHERE emp_no IN (
SELECT emp_no
FROM dept_manager
WHERE emp_no IN (
		SELECT emp_no
		FROM employees
		WHERE gender = 'F')
	AND to_date > curdate())
;

/* Find all the employees that currently have a higher than average salary.

154543 rows in total. Here is what the first 5 rows will look like:
+------------+-----------+--------+
| first_name | last_name | salary |
+------------+-----------+--------+
| Georgi     | Facello   | 88958  |
| Bezalel    | Simmel    | 72527  |
| Chirstian  | Koblick   | 74057  |
| Kyoichi    | Maliniak  | 94692  |
| Tzvetan    | Zielinski | 88070  |
+------------+-----------+--------+ */

SELECT first_name, last_name, salary
FROM employees
JOIN salaries on salaries.emp_no = employees.emp_no
WHERE salary > (
	SELECT AVG(salary)
	FROM salaries
)
AND to_date > curdate();
/* How many current salaries are within 1 standard deviation of the highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this? 78 salaries */
SELECT * 
FROM salaries
WHERE salary >(
SELECT MAX(salary)-STDDEV(salary)
FROM salaries)
AND to_date > curdate();


SELECT COUNT(*) AS 'num_salaries_1_stddev_below_max',
(count(*)/ (SELECT count(*) FROM salaries)) * 100
FROM salaries
WHERE salary >=
(
	(SELECT max(salary) FROM salaries) - (SELECT STDDEV(salary) FROM salaries)
)
and to_date > curdate();
/* Bonus 1-
Find all the department names that currently have female managers.


+-----------------+
| dept_name       |
+-----------------+
| Development     |
| Finance         |
| Human Resources |
| Research        |
+-----------------+ */


/* Bonus 2-
Find the first and last name of the employee with the highest salary.
+------------+-----------+
| first_name | last_name |
+------------+-----------+
| Tokuyasu   | Pesch     |
+------------+-----------+ */

/* Bonus 3-   
Find the department name that the employee with the highest salary works in.
+-----------+
| dept_name |
+-----------+
| Sales     |*/
+-----------+