-- Questions
USE projects;

SELECT * FROM HR;
-- Question 1 What is the Gender Breakdown of Employess in the Company
SELECT gender,count(*)AS count
FROM hr
WHERE age >=18 -- AND termdate='0000-00-00'
GROUP BY gender;
-- Question 2 What is the race/ethnicity breakdown of employees in the company?
SELECT race,count(*)AS count
FROM hr
WHERE age >=18 -- AND termdate='0000-00-00'
GROUP BY race
ORDER BY count(*) DESC;
-- Question 3 What is the age distribution of employees in the company?
-- SELECT 
-- min(age) AS youngest,
-- max(age) AS oldest
-- FROM hr 
-- WHERE age >=18 -- AND termdate='0000-00-00'

SELECT 
   CASE
WHEN age >= 18 AND age<=24 THEN '18-24'
WHEN age >= 25 AND age<=34 THEN '25-34'
WHEN age >= 45 AND age<=54 THEN '45-54'
WHEN age >= 55 AND age<=64 THEN '55-64'
ELSE '65+'
END AS age_group,
count(*) AS count
FROM hr
WHERE age >=18
GROUP BY age_group
ORDER BY age_group;

SELECT 
   CASE
WHEN age >= 18 AND age<=24 THEN '18-24'
WHEN age >= 25 AND age<=34 THEN '25-34'
WHEN age >= 45 AND age<=54 THEN '45-54'
WHEN age >= 55 AND age<=64 THEN '55-64'
ELSE '65+'
END AS age_group,gender,
count(*) AS count
FROM hr
WHERE age >=18
GROUP BY age_group,gender
ORDER BY age_group,gender;
-- Question 4 How many employees work at headquarters versus remote locations?
SELECT location,count(*) AS count
FROM hr
WHERE age >=18 -- AND termdate='0000-00-00'
GROUP BY location;
-- Question 5 What is the average length of employment for employees who have been terminated?
SELECT ROUND(AVG(DATEDIFF(termdate, hire_date))/365,0) AS avg_length_of_employment
FROM hr
WHERE termdate <> '0000-00-00' AND termdate <= CURDATE() AND age >= 18;
-- Question 6 How does the gender distribution vary across departments and job titles?
SELECT department, gender, COUNT(*) as count
FROM hr
WHERE age >= 18
GROUP BY department, gender
ORDER BY department;
-- Question 7 What is the distribution of job titles across the company?
SELECT jobtitle, COUNT(*) as count
FROM hr
WHERE age >= 18
GROUP BY jobtitle
ORDER BY jobtitle DESC;
-- Question 8 Which department has the highest turnover rate?
SELECT department, COUNT(*) as total_count, 
    SUM(CASE WHEN termdate <= CURDATE() AND termdate <> '0000-00-00' THEN 1 ELSE 0 END) as terminated_count, 
    SUM(CASE WHEN termdate = '0000-00-00' THEN 1 ELSE 0 END) as active_count,
    (SUM(CASE WHEN termdate <= CURDATE() THEN 1 ELSE 0 END) / COUNT(*)) as termination_rate
FROM hr
WHERE age >= 18
GROUP BY department
ORDER BY termination_rate DESC;
-- Question 9 What is the distribution of employees across locations by state?
SELECT location_state, COUNT(*) as count
FROM hr
WHERE age >= 18
GROUP BY location_state
ORDER BY count DESC;
-- Question 10 How has the company's employee count changed over time based on hire and term dates?
SELECT 
    YEAR(hire_date) AS year, 
    COUNT(*) AS hires, 
    SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= CURDATE() THEN 1 ELSE 0 END) AS terminations, 
    COUNT(*) - SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= CURDATE() THEN 1 ELSE 0 END) AS net_change,
    ROUND(((COUNT(*) - SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= CURDATE() THEN 1 ELSE 0 END)) / COUNT(*) * 100),2) AS net_change_percent
FROM 
    hr
WHERE age >= 18
GROUP BY 
    YEAR(hire_date)
ORDER BY 
    YEAR(hire_date) ASC;
-- Question 11 What is the tenure distribution for each department?
SELECT department, ROUND(AVG(DATEDIFF(CURDATE(), termdate)/365),0) as avg_tenure
FROM hr
WHERE termdate <= CURDATE() AND termdate <> '0000-00-00' AND age >= 18
GROUP BY department