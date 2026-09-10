CREATE DATABASE AI_Job_Market;

USE AI_Job_Market;

SELECT TOP 10 *
FROM AI_Job_Market_Data;

SELECT COUNT(*) AS total_rows
FROM AI_Job_Market_Data;

--- duplicates count
SELECT 
    id,
    COUNT(*) AS count
FROM AI_Job_Market_Data
GROUP BY id
HAVING COUNT(*) > 1;

SELECT 
    search_keyword,
    search_country,
    id,
    job_title,
    company_name,
    location,
    category,
    contract_type,
    contract_time,
    salary_min,
    salary_max,
    salary_is_predicted,
    created,
    description,
    is_ai_related,
    salary_avg,
    created_date,
    Year,
    Month,
    Month_Name,
    Day_Name,
    currency,
    country_name,
    COUNT(*) AS duplicate_count
FROM AI_Job_Market_Data
GROUP BY 
    search_keyword,
    search_country,
    id,
    job_title,
    company_name,
    location,
    category,
    contract_type,
    contract_time,
    salary_min,
    salary_max,
    salary_is_predicted,
    created,
    description,
    is_ai_related,
    salary_avg,
    created_date,
    Year,
    Month,
    Month_Name,
    Day_Name,
    currency,
    country_name
HAVING COUNT(*) > 1;


---- Country-wise job count

select country_name, count(*) as job_count
from AI_Job_Market_Data 
group by country_name;

--- How many AI-related and non-AI-related jobs are there?

select is_ai_related, count(*) as AI_related_or_not_count
from AI_Job_Market_Data
group by is_ai_related;

--- Find the average salary for AI-related jobs and non-AI-related jobs separately.

select is_ai_related, avg(salary_avg) as salary_average
from AI_Job_Market_Data
group by is_ai_related;

--- Find the number of jobs for each job title, and show only job titles having more than 100 jobs.

select job_title, count(*) as Number_of_Jobs
from AI_Job_Market_Data
group by job_title
having count(*) > 100;

---- Find the top 5 countries with the highest number of jobs.

select top 5  country_name, count(*) as job_count
from AI_Job_Market_Data
group by country_name
order by job_count desc;

--- Find the average salary for each country, but show only countries where:
--- There are at least 50 jobs
--- The average salary is greater than 50,000

select country_name, avg(salary_avg) as average_salary, count(*) as job_count
from AI_Job_Market_Data
group by country_name
having count(*) >=50 and AVG(salary_avg) > 50000;

--- Find the highest average salary among all job titles.

select job_title, avg(salary_avg) as average_salary
from AI_Job_Market_Data
group by job_title
order by average_salary desc;

--- Find all jobs whose salary_avg is higher than the overall average salary of all jobs.

select job_title, salary_avg
from AI_Job_Market_Data
WHERE salary_avg > (
    SELECT AVG(salary_avg)
    FROM AI_Job_Market_Data
);

--- Find the job titles whose average salary is higher than the overall average salary.

SELECT job_title,
       AVG(salary_avg) AS average_salary
FROM AI_Job_Market_Data
GROUP BY job_title
HAVING AVG(salary_avg) > (
    SELECT AVG(salary_avg)
    FROM AI_Job_Market_Data
);

SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'AI_Job_Market_Data';

--- Find the top 5 job titles with the highest average salary

select top 5 job_title, avg(salary_avg) as avg_salary
from AI_Job_Market_Data
group by job_title
order by avg_salary desc;

--- Find the number of AI-related jobs for each country.

SELECT country_name,
       COUNT(*) AS AI_job_count
FROM AI_Job_Market_Data
WHERE is_ai_related = 1
GROUP BY country_name;

--- Find the top 5 countries with the highest number of AI-related jobs.

SELECT top 5 country_name,
       COUNT(*) AS AI_job_count
FROM AI_Job_Market_Data
WHERE is_ai_related = 1
GROUP BY country_name
order by AI_job_count desc;

--- Find the top 5 companies with the highest number of job postings.

SELECT top 5 company_name,
       COUNT(*) AS job_count
FROM AI_Job_Market_Data
GROUP BY company_name
order by job_count desc;

--- Find the average salary for each job category, and show only categories where the average salary is greater than 60,000.

select category, avg(salary_avg) as average_salary
from AI_Job_Market_Data
group by category
having AVG(salary_avg) > 600000
ORDER BY average_salary DESC;

--- Using your Year column, find the number of job postings for each year.

select year, count(*) as job_count
from AI_Job_Market_Data
group by year
order by job_count desc;

--- Find the number of AI-related jobs for each year.

SELECT year,
       COUNT(*) AS AI_job_count
FROM AI_Job_Market_Data
WHERE is_ai_related = 1
GROUP BY year
order by year asc;

--- Find the number of job postings for each month

select month, count(*) as job_count
from AI_Job_Market_Data
group by month
order by month asc;

--- Find the number of job postings for each month name, but show only months with more than 100 job postings.

select Month_Name, count(*) as job_count
from AI_Job_Market_Data
group by Month_Name
having count(*) > 100;

--- Find the average salary for each contract type. Only show contract types where at least 50 jobs exist.
--- Sort by average_salary from highest to lowest.

select contract_type, avg(salary_avg) as average_salary, count(*) as job_count
from AI_Job_Market_Data
group by contract_type
having count(*) >= 50
order by average_salary desc;

--- Find the average salary for AI-related jobs in each category.

select category, avg(salary_avg) as average_salary, count(*) as job_count
from AI_Job_Market_Data
where is_ai_related = 1
group by category
having count(*) >= 20
order by average_salary desc;

--- Find the average minimum salary and average maximum salary for each country.

select country_name, min(salary_avg) as avg_min_salary, max(salary_avg) as avg_max_salary
from AI_Job_Market_Data
group by country_name
having count(*) >= 50
order by avg_max_salary desc;

--- Find the average salary of AI-related vs non-AI-related jobs for each country.

select country_name, is_ai_related, avg(salary_avg) as average_salary,
count(*) as job_count
from AI_Job_Market_Data
group by country_name, is_ai_related
having count(*) >= 20
order by country_name asc , average_salary desc;

--- Find the top 5 job categories by number of AI-related job postings.

select top 5  category, count(*) as ai_job_count
from AI_Job_Market_Data
where is_ai_related =1
group by category
order by ai_job_count desc;

--- Find the average salary by country for AI-related jobs, but only include countries where:
-- AI-related jobs are at least 50% of all jobs in that country.

select country_name, count( case when is_ai_related = 1 then 1 end) as ai_job_count, count(*) as total_job_count,
avg(salary_avg) as average_salary
from AI_Job_Market_Data
group by country_name
having count( case when is_ai_related = 1 then 1 end) * 100.0 / count(*) >= 50.0
order by average_salary desc;

--- Find the top 10 companies with the highest average salary.

select top 10 company_name, avg(salary_avg) as average_salary,
count(*) as job_count
from AI_Job_Market_Data
group by company_name
having count(*) >= 10
order by average_salary desc;


--- Find the number of job postings for each contract type and country.

select country_name , contract_type, count(*) as job_count
from AI_Job_Market_Data
group by contract_type, country_name
having count(*) >= 20
order by job_count desc;

---- Find the top 5 countries with the highest average salary for AI-related jobs.

select top 5 country_name, avg(salary_avg) as average_salary, count(*) as ai_job_count
from AI_Job_Market_Data
where is_ai_related= 1
group by country_name
having count(*) >= 20
order by average_salary desc;

--- Find the average salary for each job category, comparing AI-related vs non-AI-related jobs.

select category, is_ai_related, avg(salary_avg) as average_salary,
count(*) as job_count
from AI_Job_Market_Data
group by category, is_ai_related
having count(*) >= 20
order by category asc , average_salary desc;

--- Find the top 10 job titles with the highest number of AI-related postings.

select job_title, count(*) as ai_job_count, avg(salary_avg) as average_salary
from AI_Job_Market_Data
where is_ai_related= 1
group by job_title
having count(*) >=20
order by ai_job_count desc;

--- Find the percentage of AI-related jobs for each job category.

select category, count(case when is_ai_related = 1 then 1 end) as ai_job_count,
count(*) as total_job_count,
ai_job_count * 100.0 / total_job_count as ai_percentage
from AI_Job_Market_Data
group by category
order by ai_percentage desc;

with ai_related as (
select category, count(case when is_ai_related = 1 then 1 end) as ai_job_count,
count(*) as total_job_count
from AI_Job_Market_Data
group by category
)
select category, ai_job_count,
total_job_count,
ai_job_count * 100.0 / total_job_count as ai_percentage
from ai_related
order by ai_percentage desc;

--- Use a window function to find the top 3 job titles by job count within each country.
select country_name, job_title, job_count
from (
select country_name, job_title, COUNT(*) AS job_count,
dense_rank() over( PARTITION BY country_name order by count(*) desc) as rank
from AI_Job_Market_Data
GROUP BY country_name, job_title) as t
where rank <= 3;

--- Find the year-over-year change in total job postings.

WITH YearlyTotals AS (
    SELECT 
        Year,
        COUNT(*) AS job_count
    FROM AI_Job_Market_Data
    GROUP BY Year
),
PriorYearData AS (
    SELECT 
        Year,
        job_count,
        LAG(job_count, 1) OVER (ORDER BY Year ASC) AS previous_year_job_count
    FROM YearlyTotals
)
SELECT 
    Year,
    job_count,
    previous_year_job_count,
    (job_count - previous_year_job_count) AS growth
FROM PriorYearData
ORDER BY Year ASC;

--- Find the top 3 job categories in each year based on number of job postings.

select Year, category, job_count
from (
select Year, category, count(*) as job_count,
dense_rank() over(PARTITION BY Year order by count(*) desc) as rank
from AI_Job_Market_Data
GROUP BY Year, category) as t
where rank <= 3
ORDER BY Year ASC, rank ASC;;


