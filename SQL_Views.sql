-- SQL VIEWS --> the virtual table whose contents are obtained from an existing table or tables, called base tables
-- the retrieval happns through an SQL Statement, incorporating into the view
-- lets see
SELECT 
    emp_no, MAX(from_date) AS from_date, MAX(to_date) AS to_date
FROM
    dept_emp
GROUP BY emp_no;

-- Now running the above statement we obtained 300025 rows of data
-- and eventually we'll have to do that everytime to get unique or latest data of an employee
-- so, instead of using this select statement we can use the view statement, by doing this our
-- data will be stored in our schema under view table for every user in the team to see, instead of running 
-- the select statement again and again
-- & alos view is writte once so, no extra memory space is required

-- so,

CREATE OR REPLACE VIEW v_dept_emp_latest_date AS
    SELECT 
        emp_no, MAX(from_date) AS from_date, MAX(to_date) AS to_date
    FROM
        dept_emp
    GROUP BY emp_no;
    
    
-- Exercise --> calculate Average salary of all managers

CREATE OR REPLACE VIEW v_Average_Manager_Salary AS
    SELECT 
        ROUND(AVG(s.salary), 2) AS Average_Managers_Salary
    FROM
        salaries s
        JOIN
        dept_manager dm ON s.emp_no = dm.emp_no;
        
