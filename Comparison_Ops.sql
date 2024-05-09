/* Comparison operator */
-- greater than
SELECT 
    *
FROM
    employees
WHERE
    hire_date > '2000-01-01';

-- not equal
SELECT 
    *
FROM
    employees
WHERE
    first_name != 'Mark';
    
    
-- less than or equal to
SELECT 
    *
FROM
    employees
WHERE
    hire_date <= '2000-01-01';