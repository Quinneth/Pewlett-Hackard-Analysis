-- Creating tables for PH-EmployeeDB
--one coment to capture all of the talbles instead of on for each

CREATE TABLE departments (
     dept_no VARCHAR(4) NOT NULL,
	--creates a column named "dept_no" that can hold up to 4 vary characters
	--Constraint: not null tells sql that no null fields will be allowed when importing data
	--without not null, could have 1 or more rows with no primary key association
     dept_name VARCHAR(40) NOT NULL,
	--same except vary character count has max of 40
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
	--adds unique constraint to the dept_name column
);
--signals create table statement is complete, new code after will need a new statement

CREATE TABLE employees (
	 emp_no INT NOT NULL,
     birth_date DATE NOT NULL,
     first_name VARCHAR NOT NULL,
     last_name VARCHAR NOT NULL,
     gender VARCHAR NOT NULL,
     hire_date DATE NOT NULL,
     PRIMARY KEY (emp_no)
);

CREATE TABLE dept_manager (
	dept_no VARCHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
	--FK constraint tells Postgres about link between 2 tables
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	--() folowing fk specify which of the current tables columns is linked to another table
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	--References... tells postgres which other table uses  that column as primary key
    PRIMARY KEY (emp_no, dept_no)
);

DROP TABLE dept_manager CASCADE;

CREATE TABLE dept_manager (
	dept_no VARCHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
	--FK constraint tells Postgres about link between 2 tables
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	--() folowing fk specify which of the current tables columns is linked to another table
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	--References... tells postgres which other table uses  that column as primary key
    PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no)
);

CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	dept_no VARCHAR(4) NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE titles (
	emp_no INT NOT NULL,
	title VARCHAR(40) NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	PRIMARY KEY (emp_no)
);
SELECT * FROM dept_emp;
SELECT * FROM departments;
--select statement says we are about to query database
-- * says  we are looking for every column in table
--From depts says which tablde to search

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

SELECT * FROM dept_emp;
SELECT * FROM departments;
SELECT * FROM dept_manager;
SELECT * FROM employees;
SELECT * FROM salaries;
SELECT * FROM titles;
CREATE TABLE titles (
	emp_no INT NOT NULL,
	title VARCHAR(40) NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	PRIMARY KEY (emp_no, title, from_date, to_date)
);
DROP TABLE titles CASCADE;
--Select specific records requesting only first and last name
SELECT first_name, last_name
--Tell SQL which table to look in
FROM employees
--Condition of specific birth_date
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';
--employees born between 52-55
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';
--employees born in 52
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';
--employees born in 53
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';
--employees borning 54
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';
--employees born in 55

-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- COUNT Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--EXPORT SELECT INTO
SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
--output is only an total 41380

--query output
SELECT * FROM retirement_info;

--recreate retirement_info table with emp_no column
--1st drop old table
DROP TABLE retirement_info;
--2nd -- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info;

--joins
-- Joining departments and dept_manager tables
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
--points to the 2nd table to be joined, dept_manager (table2)
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

--alias
SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;
-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
    retirement_info.first_name,
retirement_info.last_name,
    dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;

--Alias
SELECT ri.emp_no,
    ri.first_name,
ri.last_name,
    de.to_date
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no;


--specify coluns and tables, emp+no, first_name, last_name, to-date
SELECT ri.emp_no,
    ri.first_name,
    ri.last_name,
de.to_date
--create new table to hold the info
INTO current_emp
--add code to join these tables
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
--add filter using where to filter current employees
WHERE de.to_date = ('9999-01-01');

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
--count fx used on emp_no
--aliases assigned to both tables
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_n--groupby  added to select statement( instead od sum)
GROUP BY de.dept_no;

-- Employee count by department number
--organized by dept #
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

DROP TABLE retiree_by_dept

-- Export Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
INTO retiree_by_dept
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
order by de.dept_no

--7.3.5Create Additional Lists
--creat list "employee information"

SELECT * FROM salaries;

SELECT * FROM salaries
ORDER BY to_date DESC;

SELECT emp_no, first_name, last_name, gender
INTO emp_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--create emp_infor table to join salaries table to add to-date and salary columns to query
--create a table emp_info 
--selects from 3 labels
DROP TABLE emp_info
SELECT e.emp_no, e.first_name, e.last_name, e.gender, s.salary, de.to_date
INTO emp_info
FROM employees as e
--joins 2 tables
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
--joins 3rd table
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
--filter by conditional
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
--add another conditional
AND (de.to_date = '9999-01-01');

--create Managment table
-- List of managers per department
SELECT  dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
INTO manager_info
FROM dept_manager AS dm
    INNER JOIN departments AS d
        ON (dm.dept_no = d.dept_no)
    INNER JOIN current_emp AS ce
        ON (dm.emp_no = ce.emp_no);
		
--Create Dept retirees table (add dept to current _emp table)
--use inner joins on current_emp, deptments, and dept_emp tables
--begin with select (selecting 4 columns from 2 tables)
---dont need to see a column from each table, but need fk and pk to link together
SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name
-- INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no);

SELECT ce.emp_no, ce.first_name, ce.last_name, d.dept_name
INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no);

-- List of Sales employees
SELECT ce.emp_no, ce.first_name, ce.last_name, d.dept_name
INTO sales_info
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no)
WHERE d.dept_name = 'Sales';

-- List of employees in Sales and Development
SELECT ce.emp_no, ce.first_name, ce.last_name, d.dept_name
INTO sales_dev
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no)
--use in condition becasue creating 2 items in the same column
WHERE d.dept_name IN ('Sales', 'Development')
ORDER BY ce.emp_no;