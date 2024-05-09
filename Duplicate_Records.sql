-- We can remove duplicate rows using GROUP BY Clause

-- 1st let's create duplicate record

INSERT INTO dept_manager_dup
VALUES('110228', 'd003', '1992-03-21', '9999-01-01');

INSERT INTO departments_dup
VALUES('d003', 'Costumer Service');

-- Check output in dept_manager_dup
SELECT 
    *
FROM
    dept_manager_dup
ORDER BY dept_no ASC; 

-- check output in departments_dup
SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no ASC; 


-- Now removing duplicat values in our joins output

SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        JOIN
    departments_dup d ON m.dept_no = d.dept_no
GROUP BY m.emp_no
ORDER BY dept_no;