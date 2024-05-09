 use employees;
 SELECT 
    e.emp_no, e.first_name, e.last_name, s.salary
FROM
    employees e
        JOIN
        # We can include all columns as per our desire but, must include column to join table and field use in where clause
    salaries s ON e.emp_no = s.emp_no
WHERE
    salary > '145000';
 
 
 -- Exercise
 SELECT 
    *
FROM
    titles;
    
    
  SELECT 
    e.emp_no, e.first_name, e.last_name, e.hire_date, t.title
FROM
    employees e
        JOIN
    titles t ON e.emp_no = t.emp_no
WHERE
    first_name = 'Margareta' AND last_name = 'Markovitch';