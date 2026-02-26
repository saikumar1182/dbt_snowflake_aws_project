# DBT + Snowflake + AWS End-to-End Data Engineering Project

## Project Overview
This project implements a complete end-to-end data engineering pipeline for sample Airbnb data using modern cloud technologies. The solution demonstrates best practices in data warehousing, transformation, and analytics using Snowflake, dbt (Data Build Tool), and AWS.

The pipeline processes sample Airbnb listings, bookings, and hosts data through a medallion architecture (Bronze → Silver → Gold), implementing incremental loading, slowly changing dimensions (SCD Type 2), and creating analytics-ready datasets.

## Data Flow Architecture
``` 
Source Data (CSV) → AWS S3 → Snowflake (Staging) → Bronze Layer (Raw Tables) → Silver Layer (Cleaned Data) → Gold Layer (Analytics)
```

## Technology Stack

* Cloud Data Warehouse: Snowflake
* Transformation Layer: dbt (Data Build Tool)
* Cloud Storage: AWS S3 (implied)
* Version Control: Git
* Python: 3.12+

* Key dbt Features:
    * Incremental models
    * Snapshots (SCD Type 2)
    * Custom macros
    * Jinja templating
    * Testing and documentation

## Data Model
* Bronze Layer (Raw Data)
    * Raw data ingested from staging with minimal transformations:
        * bronze_bookings - Raw booking transactions
        * bronze_hosts - Raw host information
        * bronze_listings - Raw property listings

* Silver Layer (Cleaned Data)
    * Cleaned and standardized data with data quality improvements:
        * silver_bookings - Cleaned booking data
        * silver_hosts - Cleaned host data
        * silver_listings - Cleaned property listings

* Gold Layer (Analytics)
    * Analytics-ready data with business logic applied:
        * fact - Fact table with key metrics
        * joined_main - Main joined table for analysis
        * dimensions - Temporary dimension tables

* Snapshots (SCD Type 2)
    * Slowly Changing Dimensions to track historical changes:
        * dim_bookings - Historical booking changes
        * dim_hosts - Historical host profile changes
        * dim_listings - Historical listing changes



## Project Structure

``` 
dbt_snowflake_aws_project/
    ├── README.md                           # This file
    ├── pyproject.toml                      # Python dependencies
    ├── main.py                             # Main execution script
    │
    ├── source_data_raw/                    # Raw CSV data files
    │   ├── bookings.csv
    │   ├── hosts.csv
    │   └── listings.csv
    │
    ├── snowflake_workspace/                # Snowflake database & schema definitions
    │   ├── ddl.sql                         # Table creation scripts
    │   └── load_s3_to_stage.sql            # Load data from S3 to Snowflake
    │
    └── aws_dbt_snowflake_project/         # Main dbt project
        ├── dbt_project.yml                 # dbt project configuration
        │
        ├── models/                         # dbt models
        │   ├── sources/
        │   │   └── sources.yml             # Source definitions
        │   ├── bronze/                     # Raw data layer
        │   │   ├── bronze_bookings.sql
        │   │   ├── bronze_hosts.sql
        │   │   └── bronze_listings.sql
        │   ├── silver/                     # Cleaned data layer
        │   │   ├── silver_bookings.sql
        │   │   ├── silver_hosts.sql
        │   │   └── silver_listings.sql
        │   └── gold/                       # Analytics layer
        │       ├── fact.sql
        │       ├── joined_main.sql
        │       └── dimensions/              # Temporary models
        │           ├── bookings.sql
        │           ├── hosts.sql
        │           └── listings.sql
        │
        ├── macros/                         # Reusable SQL functions
        │   ├── generate_schema_name.sql    # Custom schema naming
        │   └── functions.sql                # Operations
        │
        ├── analyses/                       # Ad-hoc analysis queries
        │   ├── check.sql
        │   ├── if_else_test.sql
        │   └── for_loop_test.sql
        │
        ├── snapshots/                      # SCD Type 2 configurations
        │   └── scd_dim_tables.yml
        │
        ├── tests/                          # Data quality tests
        │   └── basic_source_test.sql
        │
        └── seeds/                          # Static reference data
```

## Getting Started

### Prerequisites
* Snowflake Account (will create one if doesn't exist)
* Python Environment
* Python 3.12 or higher
    * pip or uv package manager
* AWS Account (will create one if doesn't exist, for S3 storage)

### Installation
1. Clone the Repository
```bash
git clone <repository-url>
cd dbt_snowflake_aws_project
```

2. Create Virtual Environment
```bash
python -m venv .venv
.venv\Scripts\Activate.ps1  # Windows PowerShell
# or
source .venv/bin/activate    # Linux/Mac

```
3. Install Dependencies
```bash
pip install -r requirements.txt
# or using pyproject.toml
pip install -e .
```
* Core Dependencies:
```bash
dbt-core>=1.11.2
dbt-snowflake>=1.11.0
sqlfmt>=0.0.3
```

4. Configure Snowflake Connection

* Create ~/.dbt/profiles.yml:

```bash
aws_dbt_snowflake_project:
  outputs:
    dev:
      account: <your-account-identifier>
      database: <your-database>
      password: <your-password>
      role: ACCOUNTADMIN
      schema: <your-schema>
      threads: 4
      type: snowflake
      user: <your-username>
      warehouse: <your-warehouse>
  target: dev

```
5. Set Up Snowflake Database

* Run the DDL scripts to create tables:

```bash
# Execute DDL/ddl.sql in Snowflake to create staging tables
```

6. Load Source Data

* Load CSV files from SourceData/ to Snowflake staging schema:

    * bookings.csv → AIRBNB.STAGING.BOOKINGS
    * hosts.csv → AIRBNB.STAGING.HOSTS
    * listings.csv → AIRBNB.STAGING.LISTINGS


## Running dbt Commands
* Test Connection

```bash
cd aws_dbt_snowflake_project
dbt debug
```

* Install Dependencies

```bash
dbt deps
```

* Run All Models
```bash
dbt run
```

* Run Specific Layer

```bash
dbt run --select bronze.*      # Run bronze models only
dbt run --select silver.*      # Run silver models only
dbt run --select gold.*        # Run gold models only
```

* Run Tests
```bash
dbt test
```

* Run Snapshots
```bash
dbt snapshot
```

* Generate Documentation
```bash
dbt docs generate
dbt docs serve
```

* Build Everything
```bash
dbt build  # Runs models, tests, and snapshots
```
## Security & Best Practices

* Credentials Management
    * Never commit profiles.yml with credentials
    * Use environment variables for sensitive data
    * Implement role-based access control (RBAC) in Snowflake

* Code Quality
    * SQL formatting with sqlfmt
    * Version control with Git
    * Code reviews for model changes

* Performance Optimization
    * Incremental models for large datasets
    * Ephemeral models for intermediate transformations
    * Appropriate clustering keys in Snowflake

## Additional Resources
* dbt Documentation: https://docs.getdbt.com/
* Snowflake Documentation: https://docs.snowflake.com/
* dbt Best Practices: https://docs.getdbt.com/guides/best-practices


## Future Enhancements
* Add data quality dashboards
* Implement CI/CD pipeline
* Add more complex business metrics
* Integrate with BI tools (Tableau/Power BI)
* Add alerting and monitoring
* Implement data masking for PII
* Add more comprehensive testing suite


Thank you !! 