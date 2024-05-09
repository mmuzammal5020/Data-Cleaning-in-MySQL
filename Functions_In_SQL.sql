-- Functions --> Same as procedures with a little syntax difference

DROP FUNCTION IF EXISTS f_emp_avg_salary;

DELIMITER $$
CREATE FUNCTION f_emp_avg_salary_out(p_emp_no INTEGER) RETURNS DECIMAL (10, 2)
DETERMINISTIC
BEGIN
DECLARE v_avg_salary DECIMAL (10,2);
SELECT AVG(s.salary)
INTO v_avg_salary
FROM employees e
JOIN
salaries s on e.emp_no = s.emp_no
WHERE
p_emp_no = e.emp_no;

RETURN v_avg_salary;
END$$

DELIMITER $$

-- Functions return values by select statement and we only need to pass input parameters

DROP FUNCTION IF EXISTS f_emp_info;
-- Exercise
DELIMITER $$



CREATE FUNCTION emp_info(p_first_name varchar(255), p_last_name varchar(255)) RETURNS decimal(10,2)

DETERMINISTIC NO SQL READS SQL DATA

BEGIN



                DECLARE v_max_from_date date;



    DECLARE v_salary decimal(10,2);



SELECT

    MAX(from_date)

INTO v_max_from_date FROM

    employees e

        JOIN

    salaries s ON e.emp_no = s.emp_no

WHERE

    e.first_name = p_first_name

        AND e.last_name = p_last_name;



SELECT

    s.salary

INTO v_salary FROM

    employees e

        JOIN

    salaries s ON e.emp_no = s.emp_no

WHERE

    e.first_name = p_first_name

        AND e.last_name = p_last_name

        AND s.from_date = v_max_from_date;

       

                RETURN v_salary;



END$$



DELIMITER ;


SELECT emp_info('Aruna', 'Journel');

