Use employees;
-- Self Join --> Uses 1 table --> makes 2 tables from it --> then treats then as two seperate tables in its operation

-- Example
SELECT 
    e1.*
FROM
    emp_manager e1
        JOIN
    emp_manager e2 ON e1.emp_no = e2.manager_no
ORDER BY e1.emp_no;

-- Retrieving only desired field

SELECT 
    e1.emp_no, e1.dept_no, e2.manager_no
FROM
    emp_manager e1
        JOIN
    emp_manager e2 ON e1.emp_no = e2.manager_no
ORDER BY e1.emp_no;

-- But how can we obtain only dsired rows instead of 42 rows of data --> lets see

SELECT DISTINCT
    e1.*
FROM
    emp_manager e1
        JOIN
    emp_manager e2 ON e1.emp_no = e2.manager_no
ORDER BY e1.emp_no;


-- Getting the same 2 rows of output without DISTINCT clause

SELECT 
    e1.*
FROM
    emp_manager e1
        JOIN
    emp_manager e2 ON e1.emp_no = e2.manager_no
WHERE
    e2.emp_no IN (SELECT 
            manager_no
        FROM
            emp_manager);