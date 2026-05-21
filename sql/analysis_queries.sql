-- SkillMap SQL Analysis Queries
-- Project: UAE–Canada Tech Job Market Intelligence Dashboard
-- Database: data/processed/skillmap.db


-- 1. Preview the jobs table
SELECT *
FROM jobs
LIMIT 5;


-- 2. Preview the job_skills table
SELECT *
FROM job_skills
LIMIT 10;


-- 3. Count job postings by country
SELECT
    country,
    COUNT(*) AS job_count
FROM jobs
GROUP BY country
ORDER BY job_count DESC;


-- 4. Count job postings by seniority
SELECT
    seniority,
    COUNT(*) AS job_count
FROM jobs
GROUP BY seniority
ORDER BY job_count DESC;


-- 5. Count seniority by country
SELECT
    country,
    seniority,
    COUNT(*) AS job_count
FROM jobs
GROUP BY country, seniority
ORDER BY country, job_count DESC;


-- 6. Work mode distribution by country
SELECT
    country,
    COALESCE(work_mode, 'Not specified') AS work_mode,
    COUNT(*) AS job_count
FROM jobs
GROUP BY country, COALESCE(work_mode, 'Not specified')
ORDER BY country, job_count DESC;


-- 7. Salary disclosure by country
SELECT
    country,
    COUNT(*) AS total_jobs,
    SUM(CASE WHEN has_salary = 1 THEN 1 ELSE 0 END) AS salary_disclosed_jobs,
    ROUND(
        SUM(CASE WHEN has_salary = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        1
    ) AS salary_disclosure_percentage
FROM jobs
GROUP BY country
ORDER BY country;


-- 8. Salary period by country
SELECT
    country,
    COALESCE(salary_period, 'Not specified') AS salary_period,
    COUNT(*) AS job_count
FROM jobs
GROUP BY country, COALESCE(salary_period, 'Not specified')
ORDER BY country, job_count DESC;


-- 9. Experience category distribution
SELECT
    experience_category,
    COUNT(*) AS job_count
FROM jobs
GROUP BY experience_category
ORDER BY job_count DESC;


-- 10. Early-career roles requiring at least 2 years of experience
SELECT
    job_id,
    country,
    job_title,
    company,
    seniority,
    years_experience_min,
    years_experience_max,
    notes
FROM jobs
WHERE seniority IN ('Entry-level', 'Junior', 'Associate')
  AND years_experience_min >= 2
ORDER BY country, years_experience_min DESC;


-- 11. Top skills overall
SELECT
    skill,
    COUNT(DISTINCT job_id) AS job_count,
    ROUND(
        COUNT(DISTINCT job_id) * 100.0 / (SELECT COUNT(*) FROM jobs),
        1
    ) AS percentage_of_all_jobs
FROM job_skills
GROUP BY skill
ORDER BY job_count DESC, skill ASC;


-- 12. Top skills by country
SELECT
    js.country,
    js.skill,
    COUNT(DISTINCT js.job_id) AS job_count,
    ROUND(
        COUNT(DISTINCT js.job_id) * 100.0 /
        (
            SELECT COUNT(*)
            FROM jobs j
            WHERE j.country = js.country
        ),
        1
    ) AS percentage_of_country_jobs
FROM job_skills js
GROUP BY js.country, js.skill
ORDER BY js.country, job_count DESC, js.skill ASC;


-- 13. Technical tool demand by country
SELECT
    js.country,
    js.skill,
    COUNT(DISTINCT js.job_id) AS job_count,
    ROUND(
        COUNT(DISTINCT js.job_id) * 100.0 /
        (
            SELECT COUNT(*)
            FROM jobs j
            WHERE j.country = js.country
        ),
        1
    ) AS percentage_of_country_jobs
FROM job_skills js
WHERE js.skill IN (
    'SQL',
    'Python',
    'Excel',
    'Power BI',
    'Tableau',
    'R',
    'Looker',
    'Azure',
    'AWS',
    'Google Cloud',
    'Snowflake'
)
GROUP BY js.country, js.skill
ORDER BY js.country, job_count DESC, js.skill ASC;


-- 14. Jobs mentioning SQL
SELECT DISTINCT
    j.job_id,
    j.country,
    j.city,
    j.job_title,
    j.company,
    j.seniority
FROM jobs j
JOIN job_skills js
    ON j.job_id = js.job_id
WHERE js.skill = 'SQL'
ORDER BY j.country, j.job_id;


-- 15. Jobs mentioning both SQL and Power BI
SELECT DISTINCT
    j.job_id,
    j.country,
    j.city,
    j.job_title,
    j.company,
    j.seniority
FROM jobs j
JOIN job_skills sql_skill
    ON j.job_id = sql_skill.job_id
JOIN job_skills powerbi_skill
    ON j.job_id = powerbi_skill.job_id
WHERE sql_skill.skill = 'SQL'
  AND powerbi_skill.skill = 'Power BI'
ORDER BY j.country, j.job_id;


-- 16. Jobs mentioning Python
SELECT DISTINCT
    j.job_id,
    j.country,
    j.city,
    j.job_title,
    j.company,
    j.seniority
FROM jobs j
JOIN job_skills js
    ON j.job_id = js.job_id
WHERE js.skill = 'Python'
ORDER BY j.country, j.job_id;


-- 17. Student-friendly or internship-style roles
SELECT
    job_id,
    country,
    city,
    job_title,
    company,
    employment_type,
    seniority,
    years_experience_min,
    years_experience_max
FROM jobs
WHERE seniority IN ('Internship', 'Co-op')
   OR years_experience_min BETWEEN 0 AND 1
ORDER BY country, job_id;


-- 18. Roles with QA, testing, or documentation overlap
SELECT DISTINCT
    j.job_id,
    j.country,
    j.job_title,
    j.company,
    j.seniority,
    js.skill
FROM jobs j
JOIN job_skills js
    ON j.job_id = js.job_id
WHERE js.skill IN (
    'Quality Assurance',
    'Manual Testing',
    'Bug Reporting',
    'Technical Documentation'
)
ORDER BY j.country, j.job_id, js.skill;


-- 19. Job source distribution
SELECT
    source,
    country,
    COUNT(*) AS job_count
FROM jobs
GROUP BY source, country
ORDER BY job_count DESC, source;


-- 20. Most skill-dense job postings
SELECT
    j.job_id,
    j.country,
    j.job_title,
    j.company,
    COUNT(js.skill) AS skill_count
FROM jobs j
JOIN job_skills js
    ON j.job_id = js.job_id
GROUP BY j.job_id, j.country, j.job_title, j.company
ORDER BY skill_count DESC, j.job_id;