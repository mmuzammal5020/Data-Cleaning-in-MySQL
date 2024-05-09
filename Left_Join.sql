USE employees;

DELETE FROM dept_manager_dup
WHERE emp_no = '110228';

DELETE FROM departments_dup
WHERE dept_no = 'd009';

select *
from departments_dup;

INSERT INTO 
departments_dup
values('d009', 'Costumer Service');


-- Left Join --> contain all values from left table including joined portion of two tables 

SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        LEFT JOIN
        -- in Left Join the order of on clause matters
    departments_dup d ON m.dept_no = d.dept_no
-- GROUP BY m.emp_no
ORDER BY dept_no;

SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
-- inverting the order of th join -- hence output changes adn we only get values from left table
-- we can use either left join or left outer join -- output will be the same
SELECT 
    d.dept_no, m.emp_no, d.dept_name
FROM
    departments_dup d
        LEFT JOIN
        -- in Left Join the order of on clause matters
    dept_manager_dup m ON m.dept_no = d.dept_no
-- GROUP BY d.emp_no
ORDER BY d.dept_no;

-- To get all null values in our left join, we can use where clause with IS NULL condition
SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        LEFT JOIN
    departments_dup d ON m.dept_no = d.dept_no
WHERE dept_name IS NULL
ORDER BY dept_no;


-- Exercise
SELECT 
    e.emp_no, e.first_name, e.last_name, md.dept_no, md.from_date
FROM
    employees e
        LEFT JOIN
    dept_manager md ON e.emp_no = md.emp_no
WHERE e.last_name = 'Markovitch'
ORDER BY md.dept_no DESC, e.emp_no;

