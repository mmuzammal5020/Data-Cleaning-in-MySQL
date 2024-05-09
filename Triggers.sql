-- Triggers --> A piece of program that activates automatically when a change occurs in related table
-- Triggers work on 3 DML statements 
									-- INSERT
                                    -- UPDATE
                                    -- DELETE
-- Tyes of trigger
					-- BEFORE
                    -- AFTER
                    
USE employees;

-- NOw commit here to roll back to previous state of DB 

COMMIT;


-- Now create a trigger

-- BEFORE TRIGGER
DELIMITER $$

CREATE TRIGGER before_salaries_insert
BEFORE INSERT ON salaries
FOR EACH ROW
BEGIN
IF NEW.salary < 0 THEN
SET NEW.salary = 0;
END IF;
END$$

DELIMITER ;


-- check a record
SELECT 
    *
FROM
    salaries
WHERE
    emp_no = '10001'
    AND from_date = '2010-06-22';
    
-- INSERT new values

INSERT INTO salaries VALUES(10001, -92891, '2010-06-22', '9999-01-01');


-- BEFORE UPDATE TRIGGER
DELIMITER $$

CREATE TRIGGER trig_upd_salary
BEFORE UPDATE ON salaries
FOR EACH ROW
BEGIN 
	IF NEW.salary < 0 THEN 
		SET NEW.salary = OLD.salary; 
	END IF; 
END $$

DELIMITER ;


-- Check trigger by updating value in salaries table
UPDATE salaries 
SET 
    salary = 98765
WHERE
    emp_no = '10001'
        AND from_date = '2010-06-22';
        
-- Now insert salary less than 0

UPDATE salaries 
SET 
    salary = - 50000
WHERE
    emp_no = '10001'
        AND from_date = '2010-06-22';


-- SYSTEM FUNCTIONS = BUILT-IN FUNCTIONS
SELECT SYSDATE();

SELECT DATE_FORMAT(SYSDATE(), '%y-%m-%d') AS today;



-- AFTER INSERT TRIGGER
DELIMITER $$

CREATE TRIGGER trig_ins_dept_mng
AFTER INSERT ON dept_manager
FOR EACH ROW
BEGIN
	DECLARE v_curr_salary int;
    
    SELECT 
		MAX(salary)
	INTO v_curr_salary FROM
		salaries
	WHERE
		emp_no = NEW.emp_no;

	IF v_curr_salary IS NOT NULL THEN
		UPDATE salaries 
		SET 
			to_date = SYSDATE()
		WHERE
			emp_no = NEW.emp_no and to_date = NEW.to_date;

		INSERT INTO salaries 
			VALUES (NEW.emp_no, v_curr_salary + 20000, NEW.from_date, NEW.to_date);
    END IF;
END $$

DELIMITER ;

# After you are sure you have understood how this query works, please execute it and then run the following INSERT statement.  
INSERT INTO dept_manager VALUES ('111534', 'd009', date_format(sysdate(), '%y-%m-%d'), '9999-01-01');

# SELECT the record of employee number 111534 in the ‘dept_manager’ table, and then in the ‘salaries’ table to see how the output was affected. 
SELECT 
    *
FROM
    dept_manager
WHERE
    emp_no = 111534;
    
SELECT 
    *
FROM
    salaries
WHERE
    emp_no = 111534;

# Conceptually, this was an ‘after’ trigger that automatically added $20,000 to the salary of the employee who was just promoted as a manager. 
# Moreover, it set the start date of her new contract to be the day on which you executed the insert statement.

# Finally, to restore the data in the database to the state from the beginning of this lecture, execute the following ROLLBACK statement. 
ROLLBACK;


-- EXERCISE
DELIMITER $$

CREATE TRIGGER trig_udate_emp_hire_date
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
IF 
NEW.hire_date > date_format(sysdate(), '%y-%m-%d') THEN
SET NEW.hire_date = date_format(sysdate(), '%y-%m-%d');
END IF;
END $$

DELIMITER ;

-- Check the results of our trigger by inserting new values
INSERT employees VALUES ('999904', '1970-01-31', 'John', 'Johnson', 'M', '2025-01-01');  


-- Fetch results
SELECT  
    *  
FROM  
    employees
ORDER BY emp_no DESC
LIMIT 10;
