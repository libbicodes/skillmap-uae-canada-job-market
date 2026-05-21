PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS job_skills;
DROP TABLE IF EXISTS jobs;

CREATE TABLE jobs (
    job_id TEXT PRIMARY KEY,
    collection_date TEXT,
    country TEXT NOT NULL,
    city TEXT,
    job_title TEXT,
    company TEXT,
    source TEXT,
    job_url TEXT,
    employment_type TEXT,
    work_mode TEXT,
    seniority TEXT,
    salary_min REAL,
    salary_max REAL,
    currency TEXT,
    years_experience_min REAL,
    years_experience_max REAL,
    education_requirement TEXT,
    description_short TEXT,
    skills_text TEXT,
    notes TEXT,
    salary_period TEXT,
    has_salary INTEGER,
    experience_category TEXT,
    entry_level_with_high_experience INTEGER
);

CREATE TABLE job_skills (
    skill_id INTEGER PRIMARY KEY AUTOINCREMENT,
    job_id TEXT NOT NULL,
    country TEXT,
    city TEXT,
    job_title TEXT,
    company TEXT,
    skills_text TEXT,
    skill TEXT NOT NULL,
    FOREIGN KEY (job_id) REFERENCES jobs(job_id)
);

CREATE INDEX idx_jobs_country ON jobs(country);
CREATE INDEX idx_jobs_seniority ON jobs(seniority);
CREATE INDEX idx_jobs_work_mode ON jobs(work_mode);
CREATE INDEX idx_job_skills_job_id ON job_skills(job_id);
CREATE INDEX idx_job_skills_skill ON job_skills(skill);
CREATE INDEX idx_job_skills_country ON job_skills(country);