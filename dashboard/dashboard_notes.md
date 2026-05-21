# Power BI Dashboard Notes

## Dashboard Name

SkillMap: UAE–Canada Tech Job Market Intelligence Dashboard

## Purpose

This dashboard analyzes an initial manually collected sample of early-career analytics, data, BI, product, and related technology job postings from the UAE and Canada.

The goal is to compare:

- job distribution by country
- seniority and work mode patterns
- salary disclosure
- skill demand by country
- technical tool demand
- entry-level experience expectations
- candidate skill gaps

## Dashboard Pages

### 1. Market Overview

Shows the total number of postings, country split, salary disclosure, seniority distribution, and work mode distribution.

This page gives a high-level view of the dataset and includes a limitation note explaining that the dashboard is based on a 20-posting sample.

### 2. Skills Demand

Shows the most frequently mentioned skills across the dataset and compares skill demand between UAE and Canada.

Each skill count represents the number of job postings mentioning that skill. Since one posting can mention multiple skills, skill counts are not expected to add up to the number of postings per country.

### 3. Entry-Level Reality

Highlights experience expectations and identifies early-career roles that still ask for 2+ years of experience.

This page is designed to show the gap between early-career job labels and actual experience expectations.

### 4. Candidate Skill Gap

Compares current candidate strengths with frequently mentioned market skills and identifies learning priorities.

This page connects the job-market analysis to candidate positioning by comparing existing strengths, developing skills, and learning priorities.

## Data Sources

The dashboard uses the processed datasets:

- `data/processed/cleaned_jobs.csv`
- `data/processed/job_skills.csv`

The processed files were created from the manually collected raw job-posting dataset using Python.

## Data Model

The dashboard uses two main tables:

- `Jobs`: one row per job posting
- `Job Skills`: one row per job-skill relationship

The tables are connected through `job_id` using a one-to-many relationship:

- `Jobs[job_id]` → `Job Skills[job_id]`

A manually entered `My Skills` table is also used for the Candidate Skill Gap page.

## Key Measures

Important Power BI measures include:

- `Total Jobs`
- `UAE Jobs`
- `Canada Jobs`
- `Jobs With Salary`
- `Salary Disclosure Rate`
- `Jobs Mentioning Skill`
- `Market Demand %`
- `Early Career Roles With 2+ Years`

## Limitations

This dashboard is based on an initial manually collected sample of 20 job postings. The results are directional and should not be interpreted as a complete representation of the UAE or Canadian job market.

Skill extraction was manually standardized, so the results depend on the selected postings and coding decisions.

Salary comparisons are limited because postings use different salary periods, including hourly and annual values, and some postings do not disclose salary.

## Future Improvements

Potential future improvements include:

- expanding the dataset to 100+ postings
- adding province/city-level analysis for Canada
- adding industry-level analysis
- normalizing salaries by period before comparison
- automating skill extraction with NLP
- publishing an interactive dashboard or Streamlit app