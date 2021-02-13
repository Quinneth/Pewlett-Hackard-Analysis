--Deliverable 1: Create retirement_titles
-- Creating retirement_titles.csv
--a) retirieve emp_no, first)name, and last_name columns from employees table
--and title, from_date, and to_date columns from tht titles table ??alias?
SELECT e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date
--create using new table using INTO clause
INTO retirement_titles
--Joing tables on prirmary key
FROM employees as e
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
--Conditional, filter on bithdate column to retieve the employees born between 1952-1955
WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
--order by employee number
ORDER BY e.emp_no;

--Remove duplicate rows using starter code
-- Use Dictinct with Orderby to remove duplicate rows
--1) retreive employee # first and last name, and title columns from retirement titles table
--Distinct on statment retrieve 1st occurance of emp_no for each set of rows defined by ON()
SELECT DISTINCT ON (emp_no) emp_no, first_name, last_name, title
--create unique titles table using INTO
INTO unique_titles
FROM retirement_titles
--sort by ascending order by employee # and decending order by last date )to_dat) of most recent title
ORDER BY emp_no ASC, to_date DESC

-- Retrieve the number of employees by their most recent job title who are about to retire.
--1) retrieve # of titles from unique titles table
SELECT COUNT(ut.emp_no), ut.title
--create a retiring titles table to hold info
INTO retiring_titles
FROM unique_titles as ut
GROUP BY title 
-- sort the count column in decending order
ORDER BY COUNT(title) DESC;