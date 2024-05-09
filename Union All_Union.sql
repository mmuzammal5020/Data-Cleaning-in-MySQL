-- Union is used to combile all select statements from 2 or more tables in a single output
-- the condition --> select same no. of columns from both table
-- the columns selected should have the same names and must be in the same order
-- Union displays only distincts values from 2 identically organized tables --> thus more computaional power and space required
-- while union all retrieves the duplicate values as well --> thus less computational power and space required

-- Exercise

SELECT 
    *
FROM
    (SELECT 
			e.emp_no,
            e.first_name,
            e.last_name,
            NULL AS dept_no,
            NULL AS from_date
    FROM
        employees e
    WHERE
        last_name = 'Denis' UNION SELECT 
			NULL AS emp_no,
            NULL AS first_name,
            NULL AS last_name,
            dm.dept_no,
            dm.from_date
    FROM
        dept_manager dm) AS a
ORDER BY - a.emp_no DESC;

