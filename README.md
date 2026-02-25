# DBT + Snowflake + AWS End-to-End Data Engineering Project

## Project Overview
This project implements a complete end-to-end data engineering pipeline for sample Airbnb data using modern cloud technologies. The solution demonstrates best practices in data warehousing, transformation, and analytics using Snowflake, dbt (Data Build Tool), and AWS.

The pipeline processes sample Airbnb listings, bookings, and hosts data through a medallion architecture (Bronze → Silver → Gold), implementing incremental loading, slowly changing dimensions (SCD Type 2), and creating analytics-ready datasets.

## Data Flow
``` 
Source Data (CSV) → AWS S3 → Snowflake (Staging) → Bronze Layer (Raw Tables) → Silver Layer (Cleaned Data) → Gold Layer (Analytics)
```

## Project Structure

``` dbt_snowflake_aws_project/
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