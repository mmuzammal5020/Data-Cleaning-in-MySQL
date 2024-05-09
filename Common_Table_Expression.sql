-- In SQL every query or a sub query always produces a temporary result or temporary dataset
	-- CTE is a tool to obtain such temporary result sets that exists with-in the execution of given query 
    -- CTE is used with 
    -- INSERT statement
    -- DELETE statement
    -- UPDATE statement
    -- SELECT statement --> Mostly used statement with CTE
USE employees;
-- For example if we want to obtain a result set to see if all time avg contract salary of all female employees is greater than avg salary
WITH cte AS(
SELECT AVG(salary) AS Avg_salary FROM salaries) -- Subquery part of CTE or subclause of with clause
SELECT 
SUM(CASE WHEN s.salary > c.Avg_salary THEN 1 ELSE 0 END) AS No_of_salaries_above_avg,
COUNT(s.salary) AS Total_salary_contracts
FROM 
salaries s
JOIN
employees e ON s.emp_no = e.emp_no AND e.gender = 'F'
CROSS JOIN
cte c;

-- getting same output with another method
WITH cte AS(
SELECT AVG(salary) AS Avg_salary FROM salaries) -- Subquery part of CTE or subclause of with clause
SELECT 
SUM(CASE WHEN s.salary > c.Avg_salary THEN 1 ELSE 0 END) AS No_of_salaries_above_avg,
COUNT(CASE WHEN s.salary > c.Avg_salary THEN s.salary ELSE NULL END) AS No_of_salaries_above_avg_w_count,
COUNT(s.salary) AS Total_salary_contracts
FROM 
salaries s
JOIN
employees e ON s.emp_no = e.emp_no AND e.gender = 'F'
CROSS JOIN
cte c;

-- Exercise 1
WITH cte AS(
SELECT AVG(salary) AS avg_salary FROM salaries)
SELECT 
SUM(CASE WHEN s.salary >= c.avg_salary THEN 1 ELSE 0 END) As no_of_m_salaries_above_avg,
COUNT(s.salary) AS total_salary_contracts
FROM salaries s
JOIN 
employees e ON s.emp_no = e.emp_no AND e.gender = 'M'
CROSS JOIN
cte c;

-- Exercise 2
WITH cte AS(
SELECT AVG(salary) AS Avg_salary FROM salaries) -- Subquery part of CTE or subclause of with clause
SELECT 
COUNT(CASE WHEN s.salary > c.Avg_salary THEN s.salary ELSE NULL END) AS No_of_salaries_above_avg_w_count,
COUNT(s.salary) AS Total_salary_contracts
FROM 
salaries s
JOIN
employees e ON s.emp_no = e.emp_no AND e.gender = 'M'
CROSS JOIN
cte c;

-- Exercise 3--. same result without CTE
SELECT 
    SUM(CASE WHEN salary >= avg_salary THEN 1 ELSE 0 END) AS no_of_m_salaries_above_avg,
    COUNT(*) AS total_salary_contracts,
	AVG(salary) AS avg_salary
FROM (
    SELECT 
        s.salary,
        AVG(s.salary) OVER () AS avg_salary
    FROM 
        salaries s
        JOIN employees e ON s.emp_no = e.emp_no
    WHERE 
        e.gender = 'M'
) AS male_salaries;

-- Exercise 4
WITH cte AS(
SELECT AVG(salary) AS Avg_salary FROM salaries) -- Subquery part of CTE or subclause of with clause
SELECT 
SUM(CASE WHEN s.salary >= c.avg_salary THEN 1 ELSE 0 END) As no_of_m_salaries_above_avg,
COUNT(CASE WHEN s.salary > c.Avg_salary THEN s.salary ELSE NULL END) AS No_of_salaries_above_avg_w_count,
COUNT(s.salary) AS Total_salary_contracts
FROM 
salaries s
JOIN
employees e ON s.emp_no = e.emp_no AND e.gender = 'M'
CROSS JOIN
cte c;


-- Using multiple CTEs in 1 with clause
-- 1st CTE to count total avg salary
WITH cte1 AS(SELECT AVG(salary) AS total_avg_salary FROM salaries),
cte2 AS(SELECT s.emp_no, MAX(s.salary) AS f_highest_salary
FROM 
salaries s
JOIN
employees e ON s.emp_no = e.emp_no AND e.gender = 'F'
GROUP BY s.emp_no
)
SELECT 
SUM(CASE WHEN c2.f_highest_salary > c1.total_avg_salary THEN 1 ELSE 0 END) AS f_above_avg_salary,
COUNT(e.emp_no) AS total_f_contracts
FROM
employees e
JOIN cte2 c2 ON e.emp_no = c2.emp_no
CROSS JOIN 
cte1 c1;

-- We can extract same results as above using count function instead of SUM()
WITH cte1 AS(SELECT AVG(salary) AS total_avg_salary FROM salaries),
cte2 AS(SELECT s.emp_no, MAX(s.salary) AS f_highest_salary
FROM 
salaries s
JOIN
employees e ON s.emp_no = e.emp_no AND e.gender = 'F'
GROUP BY s.emp_no
)
SELECT 
COUNT(CASE WHEN c2.f_highest_salary > c1.total_avg_salary THEN c2.f_highest_salary ELSE NULL END) AS f_above_avg_salary,
COUNT(e.emp_no) AS total_f_contracts
FROM
employees e
JOIN cte2 c2 ON e.emp_no = c2.emp_no
CROSS JOIN 
cte1 c1;

-- Calculate female %age of higher salary females
WITH cte1 AS(SELECT AVG(salary) AS total_avg_salary FROM salaries),
cte2 AS(SELECT s.emp_no, MAX(s.salary) AS f_highest_salary
FROM 
salaries s
JOIN
employees e ON s.emp_no = e.emp_no AND e.gender = 'F'
GROUP BY s.emp_no
)
SELECT 
COUNT(CASE WHEN c2.f_highest_salary > c1.total_avg_salary THEN c2.f_highest_salary ELSE NULL END) AS f_above_avg_salary,
COUNT(e.emp_no) AS total_f_contracts,
CONCAT(ROUND((SUM(CASE WHEN c2.f_highest_salary > c1.total_avg_salary THEN 1 ELSE 0 END) / COUNT(e.emp_no))*100, 2), '%') AS '% percentage'
FROM
employees e
JOIN cte2 c2 ON e.emp_no = c2.emp_no
CROSS JOIN 
cte1 c1;


-- Exercise 1
WITH c_avg_salary AS(SELECT AVG(salary) AS total_avg_salary FROM salaries),
c_m_highest_salary AS(SELECT s.emp_no, MAX(s.salary) AS f_highest_salary
FROM 
salaries s
JOIN
employees e ON s.emp_no = e.emp_no AND e.gender = 'M'
GROUP BY s.emp_no
)
SELECT 
SUM(CASE WHEN c2.f_highest_salary < c1.total_avg_salary THEN 1 ELSE 0 END) AS f_below_avg_salary,
COUNT(e.emp_no) AS total_M_contracts,
CONCAT(ROUND((SUM(CASE WHEN c2.f_highest_salary < c1.total_avg_salary THEN 1 ELSE 0 END) / COUNT(e.emp_no))*100, 2), '%') AS '% percentage'
FROM
employees e
JOIN c_m_highest_salary c2 ON e.emp_no = c2.emp_no
CROSS JOIN 
c_avg_salary c1;

-- Exercise 2
WITH c_avg_salary AS(SELECT AVG(salary) AS total_avg_salary FROM salaries),
c_m_highest_salary AS(SELECT s.emp_no, MAX(s.salary) AS f_highest_salary
FROM 
salaries s
JOIN
employees e ON s.emp_no = e.emp_no AND e.gender = 'M'
GROUP BY s.emp_no
)
SELECT 
COUNT(CASE WHEN c2.f_highest_salary < c1.total_avg_salary THEN c2.f_highest_salary ELSE NULL END) AS f_below_avg_salary,
COUNT(e.emp_no) AS total_M_contracts,
CONCAT(ROUND((SUM(CASE WHEN c2.f_highest_salary < c1.total_avg_salary THEN 1 ELSE 0 END) / COUNT(e.emp_no))*100, 2), '%') AS '% percentage'
FROM
employees e
JOIN c_m_highest_salary c2 ON e.emp_no = c2.emp_no
CROSS JOIN 
c_avg_salary c1;

-- Exercise 3
WITH c_avg_salary AS(SELECT AVG(salary) AS total_avg_salary FROM salaries),
c_m_highest_salary AS(SELECT s.emp_no, MAX(s.salary) AS f_highest_salary
FROM 
salaries s
JOIN
employees e ON s.emp_no = e.emp_no AND e.gender = 'M'
GROUP BY s.emp_no
)
SELECT 
COUNT(CASE WHEN c2.f_highest_salary < c1.total_avg_salary THEN c2.f_highest_salary ELSE NULL END) AS f_below_avg_salary,
COUNT(c2.emp_no) AS total_M_contracts,
CONCAT(ROUND((SUM(CASE WHEN c2.f_highest_salary < c1.total_avg_salary THEN 1 ELSE 0 END) / COUNT(c2.emp_no))*100, 2), '%') AS '% percentage'
FROM
c_m_highest_salary c2 
CROSS JOIN 
c_avg_salary c1;

-- In the last we can use a CTE1 In CTE2 only if CTE1 is defined above/ before CTE2 and not the other way around
WITH emp_hired_after_2000 AS (SELECT * FROM employees WHERE hire_date > '2000-01-01'),
highest_contract_salary AS( SELECT s.emp_no, MAX(s.salary)
FROM 
salaries s
JOIN emp_hired_after_2000 e ON s.emp_no = e.emp_no 
GROUP BY s.emp_no)
SELECT * FROM highest_contract_salary;

-- But if CTE1 was declacred after CTE2 our query would have failed as given below
WITH highest_contract_salary AS( SELECT s.emp_no, MAX(s.salary)
FROM 
salaries s
JOIN emp_hired_after_2000 e ON s.emp_no = e.emp_no 
GROUP BY s.emp_no),
emp_hired_after_2000 AS (SELECT * FROM employees WHERE hire_date > '2000-01-01')
SELECT * FROM highest_contract_salary;