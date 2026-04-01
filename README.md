# First dbt Project

## Overview
This repository contains a sample dbt project designed to demonstrate data modeling, testing, and transformation workflows on Snowflake.  
Sensitive connection details (account, user, password, etc.) are **not included** in this repository. Instead, the project uses environment variables to ensure security and portability.

---

## Project Structure
- `models/` – Core dbt models
- `tests/` – Custom tests
- `macros/` – Reusable SQL macros
- `analyses/` – Analytical queries
- `snapshots/` – Snapshot definitions
- `seeds/` – Seed data
- `logs/` – Local logs (ignored in Git)
- `target/` – Compiled dbt artifacts (ignored in Git)
- `dbt_project.yml` – Project configuration
- `README.md` – Documentation

---

## Setup Instructions

### 1. Install dbt
Follow the official dbt installation guide:  
[https://docs.getdbt.com/docs/get-started/installation](https://docs.getdbt.com/docs/get-started/installation)

### 2. Configure Environment Variables
Before running dbt, export the following variables in your shell:

```bash
export SNOWFLAKE_ACCOUNT="your_account"
export SNOWFLAKE_USER="your_user"
export SNOWFLAKE_PASSWORD="your_password"
export SNOWFLAKE_ROLE="ACCOUNTADMIN"
export SNOWFLAKE_DATABASE="PC_HEVODATA_DB"
export SNOWFLAKE_SCHEMA="PUBLIC"
export SNOWFLAKE_WAREHOUSE="PC_HEVODATA_WH"

### Do not commit these values to GitHub. They must remain local to your environment

3. Update profiles.yml
Your ~/.dbt/profiles.yml should reference these environment variables:

first_dbt_project:
  outputs:
    dev:
      type: snowflake
      account: "{{ env_var('SNOWFLAKE_ACCOUNT') }}"
      user: "{{ env_var('SNOWFLAKE_USER') }}"
      password: "{{ env_var('SNOWFLAKE_PASSWORD') }}"
      role: "{{ env_var('SNOWFLAKE_ROLE') }}"
      database: "{{ env_var('SNOWFLAKE_DATABASE') }}"
      schema: "{{ env_var('SNOWFLAKE_SCHEMA') }}"
      warehouse: "{{ env_var('SNOWFLAKE_WAREHOUSE') }}"
      threads: 1
  target: dev


4. Here’s a secure .gitignore you can add to your first_dbt_project/ repo. It ensures sensitive files and local artifacts never get committed

# Ignore dbt profiles (contains credentials)
profiles.yml

# Ignore environment configs with secrets
.bashrc
.bash_profile

# Ignore dbt build artifacts
target/
logs/

# Ignore Python cache and logs
__pycache__/
*.log

# Ignore OS-specific files
.DS_Store
Thumbs.db

# Ignore editor/IDE settings
.vscode/
.idea/

5. Usage
Validate the connection:

dbt debug

Run models:

dbt run

Execute tests:
dbt test

6. 
Security Notes
- Credentials are never hardcoded in this repository.
- .gitignore excludes sensitive files (profiles.yml, .bashrc, .bash_profile, logs/, target/).
- Reviewers must configure their own environment variables before running dbt

7. License
This project is for demonstration purposes and is not intended for production use.


