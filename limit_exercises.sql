USE employees;
--  LIMIT exercise goals

-- Find all the unique titles within the company
SELECT DISTINCT title as 'Unique Titles' FROM titles;

-- List the first 10 distinct last name sorted in descending order
SELECT DISTINCT last_name AS "Unique last names" FROM employees 
ORDER BY last_name DESC 
LIMIT 10;

-- Find your query for employees born on Christmas and hired in the 90s from order_by_exercises.sql. Update it to find just the first 5 employees.
SELECT * FROM employees 
WHERE birth_date LIKE '%-12-25'
AND hire_date BETWEEN '1990-01-01' AND '1999-12-31'
ORDER BY birth_date ASC, hire_date DESC
LIMIT 5;

-- Try to think of your results as batches, sets, or pages. The first five results are your first page. The five after that would be your second page, etc. Update the query to find the tenth page of results. 
SELECT * FROM employees 
WHERE birth_date LIKE '%-12-25'
AND hire_date BETWEEN '1990-01-01' AND '1999-12-31'
ORDER BY birth_date ASC, hire_date DESC
LIMIT 5 OFFSET 45;