-- While using aggregated functions in join, we can't include used in ON clause
-- the reason is MySQL will return 1st 2 values from the table while matching because our answer is in 2 fields 
-- but the given values of employee no such as '10001' or '10002' can not be employee nos for average values
-- so for above mentiond reason we should not include such values in our output while using aggregated functions in joins

SELECT 
    e.gender, AVG(s.salary) AS Average_Salary
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
GROUP BY gender;