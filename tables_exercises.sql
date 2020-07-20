USE employees; 
SELECT database ();
SHOW TABLES;
DESCRIBE departments;
DESCRIBE dept_emp;
DESCRIBE dept_manager;
DESCRIBE employees_with_departments;
DESCRIBE salaries;
DESCRIBE titles;
 #Tables in this database are: current_dept_emp, departments, dept_emp, dept_emp_latest_date, dept_manager, employees, employees_with_departments, salaries, and titles
#Which table(s) do you think contain a numeric type column? current_dept_emp, dept_emp, dept_manager, employees, employees_with_departments, salaries, and titles
#Which table(s) do you think contain a string type column? current_dept_emp, departments, dept_emp, dept_manager, employee, employees_with_departments, and titles
#Which table(s) do you think contain a date type column? dept_emp, dept_manager, dept_emp_latest_date, salaries, and titles
# What is the relationship between the employees and the departments tables? They are not linked but there are tables called employees_with_departments and dept_emp to link the infomriation together.
CREATE TABLE `dept_manager` (
  `emp_no` int(11) NOT NULL,
  `dept_no` char(4) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  PRIMARY KEY (`emp_no`,`dept_no`),
  KEY `dept_no` (`dept_no`),
  CONSTRAINT `dept_manager_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE,
  CONSTRAINT `dept_manager_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;