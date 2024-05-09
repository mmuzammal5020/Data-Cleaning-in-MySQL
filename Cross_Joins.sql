-- Cross join --> takes all values from a certain table and connect them with with the values of our required table we want to join with
-- Cross join connect all values and not only the matching values
-- That's why it's cartesian product of values from 2 or more sets


-- we can write cross join query in 3 different ways
-- 1st method
SELECT 
    dm.*, d.*
FROM
    dept_manager dm
        CROSS JOIN
    departments d
ORDER BY dm.emp_no , d.dept_no;

-- 2nd method
SELECT 
    dm.*, d.*
FROM
    dept_manager dm,
    departments d
ORDER BY dm.emp_no , d.dept_no;

-- 3rd method
SELECT 
    dm.*, d.*
FROM
    dept_manager dm
        JOIN
    departments d
ORDER BY dm.emp_no , d.dept_no;

-- In all 3 above mentioned methods there is no ON & WHERE condition

-- Now to get results from above query where dept_no for HOD is not included

SELECT 
    dm.*, d.*
FROM
    dept_manager dm
        CROSS JOIN
    departments d
WHERE d.dept_no <> dm.dept_no
ORDER BY dm.emp_no , d.dept_no;

-- double joins

SELECT 
    e.*, d.*
FROM
    dept_manager dm
        CROSS JOIN
    departments d
        JOIN
    employees e ON e.emp_no = dm.emp_no
WHERE
    d.dept_no <> dm.dept_no
ORDER BY dm.emp_no , d.dept_no;

-- Exercise 1
SELECT 
    dm.*, d.*
FROM
    departments d
        CROSS JOIN
    dept_manager dm
WHERE
    d.dept_no = 'd009'
ORDER BY dm.emp_no , d.dept_no;

-- Exercise 2
SELECT 
    dm.*, d.*
FROM
    dept_manager dm
        CROSS JOIN
    departments d
WHERE dm.emp_no < 100011
ORDER BY dm.emp_no , d.dept_no;

