-- HR Data Questions

-- 1) What is the gender breakdown of employees in the Company ?

select Gender, count(gender) as count from hr
where age >=18 and termdate = '0000-00-00'
group by gender;

-- 2) What is the race/ethnicity breakdown of employees in the Company ?

select Race, count(race) as count from hr
where age >=18 and termdate = '0000-00-00'
group by race
order by count(*) desc;

-- 3) What is the age distribution of the Employees in the company ?

select min(age) as Youngest, max(age) as Eldest from hr
where age >=18 and termdate = '0000-00-00';

select
 case 
  when age between 18 and 24 then '18-24'
  when age between 25 and 34 then '25-34'
  when age between 35 and 44 then '35-44'
  when age between 45 and 54 then '45-54'
  when age between 55 and 64 then '55-64'
  else '65+'
 end as Age_group,gender,
count(*) as Count from hr
where age>=18 and termdate = '0000-00-00'
group by age_group, gender
order by age_group, gender;

-- 4) How many Employees work at Headquarters versus remote locations ?

select location, count(location) as Count from hr
where age>=18 and termdate = '0000-00-00'
group by location
order by location desc;

-- 5) What is the average length of employement of employees who ave been terminated ?

select 
round(avg(timestampdiff(Year, hire_date, termdate)),1) as avg_emp_duration
from hr
where termdate != "0000-00-00" and termdate<= curdate() and age>18;

-- 6) How does the gender distribution vary across the departments and job titles ?

select department, gender, count(*) as count
from hr 
where age>=18 and termdate = '0000-00-00'
group by department, gender
order by department;

-- 7) What is the distribution of job titles across the company? 

select location, jobtitle, count(*) as count from hr
group by jobtitle
order by location, count(*);

-- 8) Which department has the highest turnover rate? (Rate at which emploess leave a company)

select department,total_count,terminated_count,  terminated_count/total_count as turnover_rate
 from 
 (select department,
 count(*) as total_count,
 sum(case when termdate!='0000-00-00' and termdate<=curdate() then 1 else 0 end) as terminated_count 
 from hr
 where age>=18
  group by department) 
as subquery
order by turnover_rate desc;

-- 8 ) What is the distribution of employees across locations by city and state

select location_state, count(*) as count
from hr
where age>=18 and termdate = '0000-00-00'
group by location_state
order by count(*) desc ; 

-- 9 ) How has the company's employee count changes over time based on hire and term dates ?

select
year,
hires,
terminations,
hires-terminations as net_change,
round((hires-terminations)/hires*100, 1) as net_change_percentage
from 
(select 
year(hire_date) as year,
count(hire_date) as hires ,
sum(case when termdate !="0000-00-00" and termdate<=curdate() then 1 else 0 end) as terminations
from hr
where age>=18
group by year(hire_date)) as subquery
order by year;


-- 10) What is the tenure distribution of each department ?

select 
department,
round(avg((datediff(termdate, hire_date))/365), 0) as avg_tenure
from hr
where termdate!= '0000-00-00' and termdate<=curdate() and age>18
group by department;


-- 11) Age distribution across Company.

select
 case 
  when age between 18 and 24 then '18-24'
  when age between 25 and 34 then '25-34'
  when age between 35 and 44 then '35-44'
  when age between 45 and 54 then '45-54'
  when age between 55 and 64 then '55-64'
  else '65+'
 end as Age_group,
count(*) as Count from hr
where age>=18 and termdate = '0000-00-00'
group by age_group
order by age_group;

