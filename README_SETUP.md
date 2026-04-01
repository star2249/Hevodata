**Setup Guide**

This document provides step-by-step instructions to set up the environment and pipeline for the dbt project.

This project contains two README files for clarity:

📘 **1. Data Pipeline Setup**

👉 **Refer to: README_SETUP.md**

Covers:

PostgreSQL setup

Hevo pipeline configuration

Snowflake destination setup

Data ingestion & validation

📗 2. **dbt Models & Transformations**

👉 **Refer to: README.md**

Covers:

dbt project setup

Model creation (customers.sql)

Tests and validations

Running dbt locally

🏗️ **Architecture**

**PostgreSQL → Hevo Data → Snowflake → dbt Core → Analytics Tables**

🔗 **Reference**

Hevo Official Docs: https://docs.hevodata.com/

🚀 Quick Start

**Step 1: Setup Data Pipeline**

Follow instructions in:👉 README_SETUP.md

**Step 2: Run dbt Models**

Follow instructions in:👉 README.md

**🔐 Security Notes**

Credentials are NOT stored in this repository

Use environment variables for sensitive data

profiles.yml is excluded from version control

**🎯 Key Highlights**

Built using modern ELT architecture

Separation of ingestion and transformation layers

Modular and reusable dbt models

Clean documentation for easy onboarding

**1. Prerequisite: Create VM in AWS Account**

Ensure you have created a Virtual Machine (VM) instance in your AWS account to host the PostgreSQL database or other components as needed.

Configure security groups and network settings to allow necessary access.

Ensure you have created a Virtual Machine (VM) instance in your AWS account to host the PostgreSQL database or other components as needed.

Configure security groups and network settings to allow necessary access. * Log on to the VM.

Update the package repository:

**sudo apt-get update**

Install Docker using the package manager:

For Ubuntu/Debian:

**sudo apt-get install -y docker.io**

For CentOS/RHEL:

**sudo yum install -y docker**

**Start and enable the Docker service:**

sudo systemctl start docker
sudo systemctl enable docker

****Verify Docker installation:**

docker --version

This will install Docker on your VM, allowing you to run PostgreSQL containers or other Docker images as needed.

**1. Install PostgreSQL Database (Docker-based)**

Ensure Docker is installed on your local machine or cloud VM.

Pull and run the PostgreSQL image on the AWS VM machine

docker run --name <container_name> -e POSTGRES_PASSWORD=<your_password> -p 5432:5432 -d postgres:latest

**sudo docker run --name <container_name> 
  -e POSTGRES_USER=<username> 
  -e POSTGRES_PASSWORD=<your_password> 
  -e POSTGRES_DB=<Databasename> 
  -p 5432:5432 
  -v pg_data:/var/lib/postgresql 
  -d postgres:latest
**


Replace <container_name> with your desired Docker container name.

Replace <your_password> with a secure password for the PostgreSQL user.

Replace <username> with a username you want for the PostgreSQL user.

Replace <Databasename> with a db you want for the PostgreSQL

The default PostgreSQL database inside the container is named postgres, but you can create and use other database names as needed.

 -v pg_data:/var/lib/postgresql 
  -d postgres:latest  # This option mounts a Docker volume named 'pg_data' to the container's data directory to create persistent storage for PostgreSQL data, ensuring data is retained across container restarts or recreations

Example:

sudo docker run --name pgdb -e POSTGRES_PASSWORD=mysecurepassword -p 5432:5432 -d postgres:latest

This command will start a PostgreSQL container named pgdb with the password mysecurepassword and expose port 5432 on your host machine.

You can connect to any other database you create inside the container using your preferred PostgreSQL user.

Verify the container is running:

**sudo docker ps**

**2. Create Tables and Load CSV Data**

Connect to the PostgreSQL container:

You can connect to the PostgreSQL container using several methods, with flexibility to use the PostgreSQL database name (e.g., pgdb) and any valid PostgreSQL user:

Using pgAdmin installed on your local laptop or VM:

Open pgAdmin and create a new server connection.

Enter the container's IP address or hostname, port (default 5432), username, and password. You can use any PostgreSQL user, not just 'postgres'.

Save and connect to manage the database via the GUI.

Using psql installed on your local machine or laptop:

Run the command:

psql -h <container_ip_or_hostname> -p 5432 -U <username>

Enter the password when prompted. You can use any PostgreSQL user, not just 'postgres'.

Using Docker exec to connect directly inside the container:

Run the command:

docker exec -it <container_name> psql -U <username> -d <database_name>

Replace <username> and <container_name> with the desired PostgreSQL user.

These methods allow flexibility in connecting to your PostgreSQL container using different users and tools

Create the required tables:

I have not added the DDL of the tables to avoid security issues, since we do not have to share the DB etc details



Load CSV files into the tables using copy or insert statements

**3. Sign Up for Snowflake Trial**

Visit Snowflake Trial and create a free account.

Set up a warehouse and database.

**4. Sign Up for Hevo Trial via Snowflake Partner Connect**

Log in to your Snowflake account.

Navigate to Partner Connect.

Select Hevo Data and sign up for a trial account.

Please follow the document at the link : https://hevodata.com/learn/snowflake-partner-connect-hevo/

**5. Build the Pipeline**

In Hevo, create a new pipeline.

Source: PostgreSQL database (from Step 1).

Destination: Snowflake warehouse (from Step 3).

Configure the pipeline to use Logical Replication ingestion mode.

Start the pipeline and verify data flow.

Here’s the official documentation link you can reference for setting up pipelines in Hevo Data:“I followed the official documentation from Hevo Data to set up a data pipeline from PostgreSQL to Snowflake:https://docs.hevodata.com/” 

More specific sections you might use:

Pipeline creation guide

Source configuration (PostgreSQL)

Destination setup (Snowflake/Snowflake Partner Connect)

Incremental load / CDC setup

I built a real-time data pipeline using Hevo Data to replicate data from PostgreSQL to Snowflake. I configured CDC using WAL logs, validated data consistency between source and destination, and ensured schema mapping.

Since dbt Cloud wasn’t available for the hevo free tier account , I implemented transformations using dbt Core locally(AWS VM Machine), version-controlled via GitHub. I created modular models, added tests, and ensured secure credential handling using environment variables.

Using Hevo Data (Free tier) + dbt Core + GitHub is used in the setup/

**Verification**

Run SELECT queries on the relevant Snowflake tables to verify data ingestion; specific queries are not included to avoid exposing database details.

**Notes**

Ensure network access between your PostgreSQL container and Hevo.

Use environment variables or secrets management for credentials.

Do not commit sensitive information (passwords, connection strings) to GitHub. Sensitive information (passwords, connection strings) to GitHub.

Please refer to the README files for dbt and GitHub setup—README.md covers dbt models, and README_SETUP.md details the data pipeline setup.
