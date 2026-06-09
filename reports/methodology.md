# Methodology

## Project Objective

The objective of this project was to analyze early-career analytics, BI, data, product, and related technology job postings from the UAE and Canada.

The project was designed to answer the following questions:

* What skills appear most often in early-career analytics-related job postings?
* How do UAE and Canada postings differ in skill demand?
* How often do job postings disclose salary information?
* Are entry-level roles truly beginner-friendly?
* Which skills should an early-career candidate prioritize for data analyst and BI analyst roles?

## Data Collection

The dataset was manually collected from job postings related to analytics, data, BI, product, and technology roles.

The sample contains:

* 10 UAE job postings
* 10 Canada job postings
* 20 total job postings

The dataset was intentionally kept small for the first version of the project so the full workflow could be built, tested, and documented clearly.

Each job posting was recorded with structured fields including:

* job ID
* collection date
* country
* city
* job title
* company
* job source
* job URL
* employment type
* work mode
* seniority
* salary information
* experience requirements
* education requirements
* short description
* skills text
* notes

## Data Cleaning

The raw job-posting dataset was cleaned using Python and pandas.

The cleaning process included:

* standardizing column names
* checking dataset shape and structure
* reviewing missing values
* standardizing salary-related fields
* creating a salary disclosure indicator
* categorizing experience requirements
* identifying early-career roles that require higher experience
* saving a cleaned job-level dataset

The cleaned job-level output was saved as:

```text
data/processed/cleaned_jobs.csv
```

## Skill Extraction

The original cleaned dataset contained a `skills_text` column where multiple skills were stored in one comma-separated field.

A separate skill extraction notebook was used to split this field into a normalized job-skills table.

The skill extraction process included:

* reading the cleaned jobs dataset
* selecting job identifiers and the `skills_text` column
* splitting comma-separated skills
* exploding skills so each skill became its own row
* trimming extra spaces
* removing blank skill values
* validating that accidental text fragments were not included as skills
* saving the final job-skills table

The normalized job-skills output was saved as:

```text
data/processed/job_skills.csv
```

This structure is useful because it allows the project to count skill mentions, compare skills by country, join jobs and skills in SQL, and build Power BI visuals using individual skill values.

## Python Analysis

Python was used for exploratory market analysis.

The analysis included:

* job counts by country
* salary disclosure analysis
* seniority distribution
* work mode distribution
* top skills overall
* top skills by country
* early-career roles requiring 2 or more years of experience
* candidate skill-gap analysis

The Python analysis was completed in Jupyter notebooks using pandas.

## SQL and Database Methodology

The cleaned CSV files were loaded into a local SQLite database.

The database contains two main tables:

* `jobs`: one row per job posting
* `job_skills`: one row per job-skill relationship

The database structure supports relational analysis because job-level information and skill-level information are stored separately but connected through `job_id`.

SQL was used to analyze:

* total job counts
* job counts by country
* seniority distribution
* work mode distribution
* salary disclosure rates
* top skills overall
* top skills by country
* technical tool demand
* early-career roles requiring 2 or more years of experience
* roles mentioning both SQL and Power BI
* roles overlapping with QA, testing, and documentation skills

The main SQL files are:

```text
sql/create_tables.sql
sql/analysis_queries.sql
scripts/load_to_sqlite.py
```

## Power BI Dashboard Methodology

Power BI was used to build the final dashboard.

The dashboard uses the processed datasets:

```text
data/processed/cleaned_jobs.csv
data/processed/job_skills.csv
```

The data model includes a one-to-many relationship:

```text
Jobs[job_id] → Job Skills[job_id]
```

A manually entered `My Skills` table was also added to support the candidate skill-gap analysis.

The dashboard includes four pages:

1. **Market Overview**
   Shows total postings, country split, salary disclosure, seniority distribution, and work mode distribution.

2. **Skills Demand**
   Compares skill demand across UAE and Canada job postings.

3. **Entry-Level Reality**
   Highlights early-career roles that still require 2 or more years of experience.

4. **Candidate Skill Gap**
   Compares current candidate strengths and learning priorities with market demand.

## Key Measures Used in Power BI

Important Power BI measures include:

* `Total Jobs`
* `UAE Jobs`
* `Canada Jobs`
* `Jobs With Salary`
* `Salary Disclosure Rate`
* `Jobs Mentioning Skill`
* `Market Demand %`
* `Early Career Roles With 2+ Years`

These measures were used to summarize the job market sample and support dashboard visuals.

## Validation Checks

Several validation checks were used during the project:

* confirming the cleaned jobs dataset contained 20 rows
* confirming the job-skills table contained 145 skill rows
* checking that skills were split correctly
* checking that accidental text fragments were not included as skills
* confirming the SQLite database loaded 20 jobs and 145 skill rows
* refreshing Power BI after regenerating processed data files

## Limitations

This project is based on a small manually collected sample of 20 job postings. The results should be treated as directional, not representative of the full UAE or Canadian job market.

The sample may be affected by:

* the specific job platforms used
* the search terms selected
* the timing of collection
* differences in how employers write job descriptions
* manual skill coding decisions

Salary analysis is limited because some postings do not disclose salary, and disclosed salaries may use different salary periods.

## Future Methodology Improvements

Future versions of the project could improve the methodology by:

* expanding the dataset to include more job postings across additional cities, provinces, and emirates
* collecting postings over multiple time periods to reduce timing bias
* adding industry classification to compare demand by sector
* normalizing salary values by period and currency
* using NLP techniques to extract skills from job descriptions more systematically
* comparing candidate resumes against job requirements
* publishing an interactive dashboard for easier exploration