USE employees;

-- Using more than 2 tables in JOIN

-- for example a query to check when an individual was promoted to department managers post in each department

SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    m.from_date,
    d.dept_name
FROM
    employees e
        JOIN
    dept_manager m ON e.emp_no = m.emp_no
        JOIN
    departments d ON m.dept_no = d.dept_no;
    
    -- If we change the order of join we will still obtain the same result
    SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    t.title,
    m.from_date,
    d.dept_name
FROM
    employees e
        JOIN
    dept_manager m ON e.emp_no = m.emp_no
        JOIN
    departments d ON m.dept_no = d.dept_no
        JOIN
    titles t ON e.emp_no = t.emp_no
WHERE
    t.title = 'Manager'
ORDER BY e.emp_no;
    
    -- Exercise
    
    
    -- Using JOINS & aggregated Functions to calculate avg salaries of all managers
    
    SELECT 
    d.dept_name, AVG(s.salary)
FROM
    departments d
        JOIN
    dept_manager m ON d.dept_no = m.dept_no
        JOIN
    salaries s ON m.emp_no = s.emp_no
GROUP BY d.dept_name;

-- As HAVING is associated with group by clause, so we can use it in our query
    SELECT 
    d.dept_name, AVG(s.salary) AS average_salary
FROM
    departments d
        JOIN
    dept_manager m ON d.dept_no = m.dept_no
        JOIN
    salaries s ON m.emp_no = s.emp_no
GROUP BY d.dept_name
HAVING average_salary > 60000
ORDER BY average_salary DESC;


-- Exercise
SELECT 
    e.gender, COUNT(m.dept_no) AS gender_ratio
FROM
    employees e
        JOIN
    dept_manager m ON e.emp_no = m.emp_no
GROUP BY e.gender;











-- Retrieve current sql_mode
SELECT @@global.sql_mode;

-- Modify and set sql_mode
SET @@global.sql_mode = REPLACE(@@global.sql_mode, 'ONLY_FULL_GROUP_BY', '');

