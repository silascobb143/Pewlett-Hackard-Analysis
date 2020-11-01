--Creating titles table
CREATE TABLE "Titles" (
    "emp_no" int   NOT NULL,
    "title" varchar   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL,
   PRIMARY KEY ("emp_no")
);
--Creating Retirement Tables
SELECT  
	e.emp_no,
	e.first_name,
	e.last_name,
	ti.titles,
	ti.from_date,
	ti.to_date
INTO Retirement_titles
FROM employees AS e
INNER JOIN titles AS ti
ON (e.emp_no = ti.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no
	

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) 
	rt.emp_no,
	rt.titles,
	rt.first_name,
	rt.last_name
INTO new_table
FROM retirement_titles AS rt
ORDER BY rt.emp_no, rt.to_date DESC;

-- Create Retiring Table

SELECT COUNT (nt.emp_no), nt.titles
INTO retiring_titles
FROM new_table AS nt
GROUP BY nt.titles
ORDER BY COUNT DESC;

SELECT
	n.emp_no,
	n.first_name,
	n.last_name,
	n.title
Into unique_titles
FROM new_table AS n

SELECT COUNT (un.emp_no), un.title
INTO retiring_titles
FROM unique_titles AS un
GROUP by ut.title
ORDER by ut.count DESC;
SELECT*FROM retiring_titles

--Creating Mentorship Eligibility
SELECT DISTINCT ON (e.emp_no) ti.title,
	e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date
INTO mentorship_table
FROM employees AS e
INNER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
INNER JOIN titles AS ti
ON (e.emp_no = ti.emp_no)
WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no,title;

SELECT*FROM mentorship_table

SELECT 
	mt.emp_no,
 	mt.first_name,
 	mt.last_name,
 	mt.birth_date,
 	mt.from_date,
 	mt.to_date,
 	mt.title
INTO mentorship_eligibility
FROM mentorship_table AS mt

SELECT*FROM mentorship_eligibility