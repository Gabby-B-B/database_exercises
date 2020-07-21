USE employees;
--  Part 3 Exercise Goals

-- Find all employees with first names 'Irena', 'Vidya', or 'Maya' — 709 rows 
-- Modify your first query to order by first name. The first result should be Irena Reutenauer and the last result should be Vidya Simmen.
SELECT * 
FROM employees 
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name;

-- Update the query to order by first name and then last name. The first result should now be Irena Acton and the last should be Vidya Zweizig.
SELECT * 
FROM employees 
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name, last_name;

-- Change the order by clause so that you order by last name before first name. Your first result should still be Irena Acton but now the last result should be Maya Zyda.
SELECT * 
FROM employees 
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY last_name, first_name;

-- Find all employees whose last name starts with 'E' - 7,330 rows
-- Update your queries for employees with 'E' in their last name to sort the results by their employee number. Your results should not change!

-- query #1 with starts with 'e'
SELECT * 
FROM employees 
WHERE last_name LIKE 'E%'
ORDER BY emp_no;

-- query #2 with starts with or ends with 'e'
SELECT * FROM employees
WHERE last_name LIKE 'E%' 
OR last_name LIKE '%E'
ORDER BY emp_no;

-- Query #3 with starts with and ends with 'e'
SELECT * FROM employees
WHERE last_name LIKE 'E%' 
AND last_name LIKE '%E'
ORDER BY emp_no;

-- Now reverse the sort order for both queries.
-- REVERSE query #4 with starts with 'e'
SELECT * 
FROM employees 
WHERE last_name LIKE 'E%'
ORDER BY emp_no DESC;

-- REVERSE query #5 with starts with or ends with 'e'
SELECT * FROM employees
WHERE last_name LIKE 'E%' 
OR last_name LIKE '%E'
ORDER BY emp_no DESC;

-- REVERSE Query #6 with starts with and ends with 'e'
SELECT * FROM employees
WHERE last_name LIKE 'E%' 
AND last_name LIKE '%E'
ORDER BY emp_no DESC;

-- Change the query for employees hired in the 90s and born on Christmas such that the first result is the oldest employee who was hired last. It should be Khun Bernini.
SELECT * FROM employees 
WHERE birth_date LIKE '%-12-25'
AND hire_date BETWEEN '1990-01-01' AND '1999-12-31'
ORDER BY birth_date ASC, hire_date DESC;
