USE employees;

-- Sub queries are nested queries or inner queries of an outer queries

-- Select 1st & last_name of employees working as managers in the employees DB
-- Sub queries aloow better structure for the outer query
	-- Thus inner can be thought of in isolation
		-- hence the name of SQL

SELECT 
    e.first_name, e.last_name, e.hire_date
FROM
    employees e
WHERE
    e.emp_no IN (SELECT 
            dm.emp_no
        FROM
            dept_manager dm);
            
            
-- Exercise
SELECT 
    e.first_name, e.last_name, e.hire_date
FROM
    employees e
WHERE
    e.emp_no IN (SELECT 
            dm.emp_no
        FROM
            dept_manager dm
            WHERE hire_date BETWEEN '1990-01-01' AND '1995-01-01');
            
-- EXIST || NOT EXIST in Sub queries
-- THis check is conducted row by row
-- returns a boolean value
SELECT 
    e.first_name, e.last_name, e.hire_date
FROM
    employees e
WHERE
    EXISTS (SELECT 
            dm.emp_no
        FROM
            dept_manager dm
            WHERE e.emp_no = dm.emp_no)
ORDER BY emp_no;

-- Exercise of Exist not exist 
SELECT 
    e.*
FROM
    employees e
WHERE
    EXISTS( SELECT 
            t.*
        FROM
            titles t
        WHERE
            e.emp_no = t.emp_no
                AND title = 'Assistant Engineer')
ORDER BY emp_no;



