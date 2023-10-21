use project1;

select * from hr;
Alter table hr
Change column ï»¿id emp_id Varchar(20) Null;

Describe hr;

Select birthdate from hr;
set sql_safe_updates = 0;

UPDATE hr
SET birthdate = 
    CASE
        WHEN birthdate LIKE '%/%' THEN DATE_FORMAT(STR_TO_DATE(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
        WHEN birthdate LIKE '%-%' THEN DATE_FORMAT(STR_TO_DATE(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
        ELSE NULL
END;

alter table hr
modify column birthdate Date;

UPDATE hr
SET hire_date = 
    CASE
        WHEN hire_date LIKE '%/%' THEN DATE_FORMAT(STR_TO_DATE(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
        WHEN hire_date LIKE '%-%' THEN DATE_FORMAT(STR_TO_DATE(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
        ELSE NULL
END;

alter table hr
modify column hire_date Date;

UPDATE hr
set termdate = date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC'))
where termdate is not null and termdate != ' ';

alter table hr
modify column termdate Date;

SET sql_mode = 'ALLOW_INVALID_DATES';

select termdate from hr;

alter table hr
add column age int;

update hr
set age = timestampdiff(Year,birthdate, curdate() );

select birthdate, age from hr







