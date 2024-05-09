-- Each query or sub query in DB produces a temporary dataset
-- permanent datasets are in Our tables in DB  
	-- Temporary datasets in MySQL DB are
		-- JOIN
        -- Subqueries
        -- WINDOW functions
        -- CTE
        -- Temporary Tables --> hold temorary result sets during our MySQL session
			-- Used at the back end when executing e-g ALTER TABLE or SELECT DISTINCT statements
            -- beneficial when need to refer to a dataset multiple time in a single MySQL session
-- Example --> Extract highest salary contract by all female employees working in company by storing the result set in a temporary table
USE employees;
CREATE TEMPORARY TABLE f_highest_salaries
SELECT s.emp_no, MAX(s.salary) AS f_salary
from salaries s
    JOIN
    employees e ON e.emp_no = s.emp_no AND e.gender = 'F'
GROUP BY s.emp_no
LIMIT 10;

SELECT 
    *
FROM
    f_highest_salaries;
    
-- Temporary tables can be used like any other table from our default DB, can be dropped as well
-- Are valid only within the scope of  our MySQL session and not beyond
DROP TEMPORARY TABLE f_highest_salaries;
-- So, after ending the session the temporary table won't be available and we would have to creat it again to use it in our session

-- Exercise 1
CREATE TEMPORARY TABLE male_highest_salaries
SELECT s.emp_no, MAX(s.salary) 
FROM salaries s
JOIN 
employees e ON e.emp_no = s.emp_no AND e.gender = 'M'
GROUP BY s.emp_no;

-- EXERCISE 2
SELECT 
    *
FROM
    male_highest_salaries;
    
-- Features of temporary tables
-- When a temporary table is used, it can be invoked only once (only used once in SELECT statement) and cannot be used in self JOINS or UNION or UNOIN ALL operations
-- Example
SELECT 
    *
FROM
    f_highest_salaries f1
        JOIN
    f_highest_salaries f2;
    
-- But their is a way out, we can use a table twice in a query such as UNION or SELF JOIN by using CTEs
WITH cte AS (SELECT s.emp_no, MAX(s.salary) AS f_max_salaries
FROM salaries s
JOIN 
employees e ON s.emp_no = e.emp_no AND gender = 'F'
GROUP BY s.emp_no
limit 10)
SELECT * FROM f_highest_salaries f1 JOIN cte c;

-- Using CTE to perform UNION function
WITH cte AS (SELECT s.emp_no, MAX(s.salary) AS f_max_salaries
FROM salaries s
JOIN 
employees e ON s.emp_no = e.emp_no AND gender = 'F'
GROUP BY s.emp_no
limit 10)
SELECT * FROM f_highest_salaries UNION ALL SELECT * FROM cte c;

-- To elaborate on How and why CTE will  help in JOIN or UNION functions if a temporary table is just created and filled with dataset
CREATE TEMPORARY TABLE dates
SELECT 
NOW() AS current_date_time,
DATE_SUB(NOW(), INTERVAL 1 MONTH) AS a_month_earlier,
DATE_SUB(NOW(), INTERVAL -1 YEAR) AS a_year_later;

SELECT 
    *
FROM
    dates;
    
-- JOIN
WITH cte AS(SELECT 
NOW() AS current_date_time,
DATE_SUB(NOW(), INTERVAL 1 MONTH) AS a_month_earlier,
DATE_SUB(NOW(), INTERVAL -1 YEAR) AS a_year_later)
SELECT * FROM dates d1 JOIN cte c1;
-- UNION
WITH cte AS(SELECT 
NOW() AS current_date_time,
DATE_SUB(NOW(), INTERVAL 1 MONTH) AS a_month_earlier,
DATE_SUB(NOW(), INTERVAL -1 YEAR) AS a_year_later)
SELECT * FROM dates UNION ALL SELECT * FROM cte;

-- DROP both temporary tables
DROP TABLE IF EXISTS f_highest_salaries;
DROP TABLE IF EXISTS dates;



-- Exercise 1
CREATE TEMPORARY TABLE dates
SELECT 
NOW() AS current_date_time,
DATE_SUB(NOW(), INTERVAL 2 MONTH) AS a_month_earlier,
DATE_SUB(NOW(), INTERVAL -2 YEAR) AS a_year_later;

-- Exercise 2
SELECT 
    *
FROM
    dates;
    
-- Exercise 3
WITH cte AS(SELECT 
NOW() AS current_date_time,
DATE_SUB(NOW(), INTERVAL 2 MONTH) AS a_month_earlier,
DATE_SUB(NOW(), INTERVAL -2 YEAR) AS a_year_later)
SELECT * FROM dates d1 JOIN cte c1;


-- Exercise 4
WITH cte AS(SELECT 
NOW() AS current_date_time,
DATE_SUB(NOW(), INTERVAL 2 MONTH) AS a_month_earlier,
DATE_SUB(NOW(), INTERVAL -2 YEAR) AS a_year_later)
SELECT * FROM dates UNION ALL SELECT * FROM cte;

-- Exercise 5
DROP TABLE IF EXISTS male_highest_salaries;

DROP TABLE IF EXISTS dates;