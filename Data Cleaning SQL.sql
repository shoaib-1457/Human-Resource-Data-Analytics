USE projects;

SELECT * FROM HR;

DESCRIBE HR;

SET sql_safe_updates = 0;
SELECT termdate FROM hr;
UPDATE hr
-- SET termdate = date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC'))
-- SET new_date = STR_TO_DATE(analysedAt, '%Y-%m-%dT%H:%i:%s');
SET termdate = date(str_to_date(termdate,'%Y-%m-%d %H:%i:%s UTC'))
WHERE termdate IS NOT NULL AND termdate != '';

SET GLOBAL sql_mode = '';
ALTER TABLE hr
MODIFY COLUMN termdate DATE;

ALTER TABLE hr ADD COLUMN age INT;

UPDATE hr
SET age = timestampdiff(YEAR, birthdate, CURDATE());

SELECT 
	min(age) AS youngest,
    max(age) AS oldest
FROM hr;

SELECT count(*) FROM hr WHERE age < 18;

SELECT COUNT(*) FROM hr WHERE termdate > CURDATE();

SELECT COUNT(*)
FROM hr
WHERE termdate = '0000-00-00';

SELECT location FROM hr;

DESCRIBE HR;
