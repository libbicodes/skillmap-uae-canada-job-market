# Executive Summary

## Project

**SkillMap: UAE–Canada Tech Job Market Intelligence Dashboard**

## Project Purpose

This project analyzes an initial sample of early-career analytics, BI, data, product, and related technology job postings from the UAE and Canada.

The goal is to identify:

* commonly requested skills
* differences between UAE and Canada job postings
* salary disclosure patterns
* experience expectations for early-career roles
* gaps between current candidate skills and market demand

The project uses Python, SQL, SQLite, and Power BI to turn manually collected job-posting data into a structured job-market intelligence dashboard.

## Dataset

The analysis uses an initial manually collected sample of 20 job postings:

* UAE postings: 10
* Canada postings: 10

Each posting includes job-level details such as country, city, job title, company, work mode, seniority, salary information, experience requirements, education requirements, description, and skills.

The cleaned dataset was also transformed into a normalized job-skills table, where each row represents one job-skill relationship.

## Key Findings

### 1. Business-facing skills appeared frequently

Stakeholder communication, reporting, dashboarding, and documentation appeared frequently in the sample. This suggests that early-career analytics roles are not only technical; they also require communication, presentation, and business-facing skills.

### 2. SQL, Excel, Python, and Power BI are important technical skills

The job postings frequently mentioned tools and skills such as SQL, Excel, Python, Power BI, reporting, and dashboarding. These skills are especially relevant for data analyst, BI analyst, and analytics-focused roles.

### 3. UAE and Canada postings showed different skill emphasis

In this sample:

* UAE postings showed stronger mentions of Excel, dashboarding, presentation skills, and stakeholder communication.
* Canada postings showed stronger mentions of Python, SQL, and technical documentation.
* SQL appeared important in both regions.

### 4. Some early-career roles still required prior experience

In this sample, 4 roles labelled as entry-level, junior, or associate required at least 2 years of experience.

This suggests that early-career candidates may need portfolio projects, internships, academic projects, and transferable experience to compete effectively.

### 5. Candidate skill gaps can be turned into a learning roadmap

The candidate skill-gap analysis showed that existing strengths in Python, QA, testing, bug reporting, and technical documentation can support a transition into analytics roles.

Priority skills to strengthen include:

* SQL
* Power BI
* Excel
* dashboarding
* reporting

## Dashboard Output

The final Power BI dashboard includes four pages:

1. **Market Overview**
   Summarizes total postings, country split, salary disclosure, seniority distribution, and work mode distribution.

2. **Skills Demand**
   Compares frequently mentioned skills across UAE and Canada job postings.

3. **Entry-Level Reality**
   Highlights roles labelled as early-career that still ask for 2 or more years of experience.

4. **Candidate Skill Gap**
   Compares current candidate strengths with skills appearing in the job-posting sample.

## Technical Outputs

The project produced the following outputs:

* cleaned job-level dataset: `data/processed/cleaned_jobs.csv`
* normalized job-skills dataset: `data/processed/job_skills.csv`
* SQLite database: `data/processed/skillmap.db`
* SQL analysis queries: `sql/analysis_queries.sql`
* Power BI dashboard: `dashboard/skillmap_dashboard.pbix`
* dashboard screenshots: `dashboard/screenshots/`

## Limitations

This project is based on an initial manually collected sample of 20 job postings. The findings are directional and should not be interpreted as a complete representation of the UAE or Canadian job market.

Skill extraction was manually standardized, so results depend on the selected postings and coding decisions.

Salary analysis is limited because some postings do not disclose salary, and disclosed salaries may use different salary periods such as hourly, monthly, or annual values.

## Recommended Next Steps

The next version of this project should focus on:

* expanding the dataset to improve reliability
* normalizing salary values for stronger compensation analysis
* automating or semi-automating skill extraction to reduce manual coding bias