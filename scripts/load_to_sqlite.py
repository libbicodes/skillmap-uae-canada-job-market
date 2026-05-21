import sqlite3
from pathlib import Path

import pandas as pd


BASE_DIR = Path(__file__).resolve().parents[1]

CLEANED_JOBS_PATH = BASE_DIR / "data" / "processed" / "cleaned_jobs.csv"
JOB_SKILLS_PATH = BASE_DIR / "data" / "processed" / "job_skills.csv"
CREATE_TABLES_PATH = BASE_DIR / "sql" / "create_tables.sql"
DATABASE_PATH = BASE_DIR / "data" / "processed" / "skillmap.db"


JOB_COLUMNS = [
    "job_id",
    "collection_date",
    "country",
    "city",
    "job_title",
    "company",
    "source",
    "job_url",
    "employment_type",
    "work_mode",
    "seniority",
    "salary_min",
    "salary_max",
    "currency",
    "years_experience_min",
    "years_experience_max",
    "education_requirement",
    "description_short",
    "skills_text",
    "notes",
    "salary_period",
    "has_salary",
    "experience_category",
    "entry_level_with_high_experience",
]

SKILL_COLUMNS = [
    "job_id",
    "country",
    "city",
    "job_title",
    "company",
    "skills_text",
    "skill",
]


def bool_to_int(value):
    """Convert boolean-like values into 1, 0, or None for SQLite."""
    if pd.isna(value):
        return None

    if isinstance(value, bool):
        return int(value)

    text = str(value).strip().lower()

    if text in {"true", "1", "yes"}:
        return 1

    if text in {"false", "0", "no"}:
        return 0

    return None


def validate_input_files():
    required_paths = [
        CLEANED_JOBS_PATH,
        JOB_SKILLS_PATH,
        CREATE_TABLES_PATH,
    ]

    missing_paths = [path for path in required_paths if not path.exists()]

    if missing_paths:
        missing_text = "\n".join(str(path) for path in missing_paths)
        raise FileNotFoundError(f"Missing required file(s):\n{missing_text}")


def prepare_jobs_dataframe(jobs_df):
    for column in JOB_COLUMNS:
        if column not in jobs_df.columns:
            jobs_df[column] = pd.NA

    jobs_df = jobs_df[JOB_COLUMNS].copy()

    for boolean_column in ["has_salary", "entry_level_with_high_experience"]:
        jobs_df[boolean_column] = jobs_df[boolean_column].apply(bool_to_int)

    if jobs_df["job_id"].duplicated().any():
        duplicate_ids = jobs_df.loc[jobs_df["job_id"].duplicated(), "job_id"].tolist()
        raise ValueError(f"Duplicate job_id values found: {duplicate_ids}")

    return jobs_df


def prepare_skills_dataframe(skills_df, valid_job_ids):
    for column in SKILL_COLUMNS:
        if column not in skills_df.columns:
            skills_df[column] = pd.NA

    skills_df = skills_df[SKILL_COLUMNS].copy()

    missing_job_ids = set(skills_df["job_id"]) - set(valid_job_ids)

    if missing_job_ids:
        raise ValueError(f"job_skills contains job_id values not found in jobs: {missing_job_ids}")

    return skills_df


def convert_missing_values_to_none(dataframe):
    return dataframe.astype(object).where(pd.notna(dataframe), None)


def main():
    validate_input_files()

    jobs_df = pd.read_csv(CLEANED_JOBS_PATH)
    skills_df = pd.read_csv(JOB_SKILLS_PATH)

    jobs_df = prepare_jobs_dataframe(jobs_df)
    skills_df = prepare_skills_dataframe(skills_df, jobs_df["job_id"])

    jobs_df = convert_missing_values_to_none(jobs_df)
    skills_df = convert_missing_values_to_none(skills_df)

    DATABASE_PATH.parent.mkdir(parents=True, exist_ok=True)

    create_tables_sql = CREATE_TABLES_PATH.read_text(encoding="utf-8")

    with sqlite3.connect(DATABASE_PATH) as connection:
        connection.execute("PRAGMA foreign_keys = ON;")
        connection.executescript(create_tables_sql)

        jobs_df.to_sql("jobs", connection, if_exists="append", index=False)
        skills_df.to_sql("job_skills", connection, if_exists="append", index=False)

        job_count = connection.execute("SELECT COUNT(*) FROM jobs;").fetchone()[0]
        skill_count = connection.execute("SELECT COUNT(*) FROM job_skills;").fetchone()[0]

    print("SQLite database created successfully.")
    print(f"Database path: {DATABASE_PATH}")
    print(f"Jobs loaded: {job_count}")
    print(f"Skill rows loaded: {skill_count}")


if __name__ == "__main__":
    main()