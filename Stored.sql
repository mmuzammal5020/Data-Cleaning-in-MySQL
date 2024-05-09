-- Stored routine is a query stored in DB, so everytime instead of running the same query again and again
-- we can simply call our store routine --> it can save time
										-- save memory
			-- 2 types
				-- store procedure --> All procedures are stored therefore stored procedue
                -- functions --> User defined functions as stored routines --> done manually by user 
-- ; works as terminator but it's also a delimeter
-- to use ; in our statement, we have to set another symbol as delimeter such as $$ or //

-- so, let's begin

use employees;

-- creating a procedure
DROP PROCEDURE IF EXISTS select_employees;
DELIMITER $$
CREATE PROCEDURE select_employees()
BEGIN

	SELECT * from employees
	limit 1000;

END$$

DELIMITER ;
 
 -- Call a stored procedure --> we can call a procedure with or without '()'
 
 call employees.select_employees();
 
 -- 2nd way
 call select_employees();
 
 
 -- Exercise
 
 DROP PROCEDURE IF EXISTS average_salary;
 
 -- Create a new procedure
 DELIMITER $$
 CREATE PROCEDURE average_salary()
 BEGIN
 select ROUND(AVG(salary), 2) FROM salaries;
 END$$
 
 DELIMITER ;
 
 -- DROP a procedure
DROP PROCEDURE select_salaries;


-- Stored procedures with an input parameters

DROP PROCEDURE IF EXISTS emp_salary;

DELIMITER $$
CREATE PROCEDURE emp_salary(IN p_emp_no INTEGER)
BEGIN
SELECT e.first_name, e.last_name, s.salary, s.from_date, s.to_date
FROM employees e
JOIN
salaries s on e.emp_no = s.emp_no
WHERE
p_emp_no = e.emp_no;
END$$

DELIMITER $$


-- Now to count average salary of each desired employee
DELIMITER $$
CREATE PROCEDURE emp_avg_salary(IN p_emp_no INTEGER)
BEGIN
SELECT e.first_name, e.last_name, ROUND(AVG(s.salary), 2)
FROM employees e
JOIN
salaries s on e.emp_no = s.emp_no
WHERE
p_emp_no = e.emp_no;
END$$

DELIMITER $$




-- Stored procedure with output parameters

DELIMITER $$
CREATE PROCEDURE emp_avg_salary_out(IN p_emp_no INTEGER, OUT p_avg_salary DECIMAL (10, 2))
BEGIN
SELECT AVG(s.salary)
INTO p_avg_salary
FROM employees e
JOIN
salaries s on e.emp_no = s.emp_no
WHERE
p_emp_no = e.emp_no;
END$$

DELIMITER $$


-- Exercise
DROP PROCEDURE IF EXISTS emp_info;

DELIMITER $$
CREATE PROCEDURE emp_info(IN p_first_name VARCHAR(14), IN p_last_name CHAR(16), OUT p_emp_no INTEGER)
BEGIN
SELECT e.emp_no
INTO p_emp_no
FROM employees e
WHERE
e.first_name = p_first_name AND e.last_name = p_last_name;
END$$
DELIMITER ;

