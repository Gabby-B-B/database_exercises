USE employees;
USE employees;
-- In your script, use DISTINCT to find the unique titles in the titles table. Your results should look like:

SELECT DISTINCT title AS 'unique_titles' FROM titles;

-- Find your query for employees whose last names start and end with 'E'. Update the query find just the unique last names that start and end with 'E' using GROUP BY. The results should be:

SELECT last_name FROM employees
WHERE last_name LIKE 'E%' 
AND last_name LIKE '%E'
GROUP BY last_name;

-- Update your previous query to now find unique combinations of first and last name where the last name starts and ends with 'E'. You should get 846 rows. */
SELECT DISTINCT first_name, last_name FROM employees
WHERE last_name LIKE 'E%' 
AND last_name LIKE '%E';


-- Find the unique last names with a 'q' but not 'qu'.

SELECT DISTINCT last_name FROM employees
WHERE last_name LIKE '%q%'
AND
last_name NOT LIKE '%qu%';

-- Add a COUNT() to your results and use ORDER BY to make it easier to find employees whose unusual name is shared with others.
SELECT DISTINCT last_name, COUNT(last_name)
FROM employees
WHERE last_name LIKE '%q%'
AND
last_name NOT LIKE '%qu%'-- Add a COUNT() to your results and use ORDER BY to make it easier to find employees whose unusual name is shared with others.
SELECT DISTINCT last_name, COUNT(last_name)
FROM employees
GROUP BY last_name
ORDER BY last_name
ORDER BY last_name ASC;

-- Update your query for 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names.
SELECT COUNT(*), gender 
FROM employees 
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
GROUP BY gender;

-- Recall the query the generated usernames for the employees from the last lesson. Are there any duplicate usernames?
SELECT LOWER(
CONCAT(
SUBSTR(first_name,1,1),
SUBSTR(last_name,1,4),	
' ', 
SUBSTR(birth_date, 6,2), 
SUBSTR(birth_date, 3,2)
							 ))
AS user_name
FROM employees
GROUP BY user_name;

-- Bonus Answer
select count(*) as "number of duplicates", sum(records) as "total of each duplicate"
from 
(select user_name, count(*) as records
from 
    (select lower(concat(substr(first_name, 1, 1), substr(last_name, 1, 4), "_" , 
     substr(birth_date, 6, 2), substr(birth_date, 3, 2))) as user_name,
     first_name,
     last_name,
     birth_date
from employees) temp 
group by user_name
having count(*) > 1
order by user_name
) temp2
-- Answer: 13251
