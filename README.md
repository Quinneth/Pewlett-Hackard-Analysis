# Pewlett-Hackard-Analysis

# Analysis Overview
The purpose of this analysis is to use the previously built Pewlett Hackard database to determine the number of retiring employees per title, and identify employees who are eligible to participate in a mentorship program. This project required the use of an entity relationship schematic to create query tables. There are three deliverables for this challenge:   
1) Create a table that has the number of retirement-age employees by most recent job title.
2) Create a Mentorship Eligibility table that holds the employees who are eligible to participate in a mentorship program.
3) Write a report on the employee database analysis (README.md) to help the manager prepare for the upcoming "silver tsunami."

# Results
Bulleted list with four major points from the two analysis deliverables.
- **Deliverable 1: *The Number of Retiring Employees by Title***<br>
This table holds all the titles of current employees who were born between January 1, 1952 and December 31, 1955.
Simply extracting the current employees who are reaching retirement age then sorting by title proved inconclusive because many current employees had multiple titles during their employment with the company. The remedy for finding the accuate number of retiring employees was derived by writing a query to extract the employee number, first and last name, and the *most recent title*. <br>
![unique_titles.csv](https://github.com/Quinneth/Pewlett-Hackard-Analysis/blob/main/Query/unique_titles.csv)<br>
The following table shows the number of current employees eligible for retirement broken down by title. <br>
![retiring_titles.csv](https://github.com/Quinneth/Pewlett-Hackard-Analysis/blob/main/Query/retiring_titles.csv)<br>

  - Total empolyees reaching retirement age range:  90,389
  - Over half of the titles facing vacancy are senior Engineer and senior Staff

- **Deliverable 2: *The Employees Eligible for the Mentorship Program***<br>
This table holds the employees eligible for a mentorship program filtered by birth year (1965) and no termination dates.<br>
![mentorship_eligibilty.csv](https://github.com/Quinneth/Pewlett-Hackard-Analysis/blob/main/Query/mentorship_eligibility.csv)
<br>


# Summary
1) How many roles will need to be filled as the "silver tsunami" begins to make an impact?
- A Total of 90,389 postions will need to be filled with the majority holding senior titles.

2) Are there enough qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett Hackard employees?
- There are not enough qualified employees eligible for the mentorship program. If Pewlett Hackard will face a devastating shortage of only 1550 employees to fill 90,389 postions.

3) Additional queries or tables that may provide more insight.
- Pewlett Hackard ultimately needs more employees to complete thier mentorship program. Beyond hiring more outside candidates, the company could change the program requirements to open the employee pool to younger employees.<br>
Two useful additional tables the company could query: 
- Repurpose mentorship eligibilty with younger birthdate.
- Sort eligibility by title to determine the birthdate requirements based on title.






