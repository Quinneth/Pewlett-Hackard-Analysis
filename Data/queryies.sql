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

