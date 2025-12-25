# dbt-fusion DuckDB Demo

[![Test dbt-fusion DuckDB](https://github.com/dimasgonzales/dbt-fusion-duckdb-demo/actions/workflows/test.yml/badge.svg)](https://github.com/dimasgonzales/dbt-fusion-duckdb-demo/actions/workflows/test.yml)

A demonstration repository showing how [dbt-fusion](https://github.com/dimasgonzales/dbt-fusion) works with DuckDB.

## Overview

This project demonstrates the dbt-fusion engine's DuckDB adapter support, featuring:

- **Staging & Mart Models** – Layered data transformation pattern
- **Column Tests** – `not_null`, `unique`, and `accepted_values` tests
- **Unit Tests** – YAML-based unit tests for model logic validation
- **Seed Data** – Sample CSV data loaded into DuckDB
- **CI Pipeline** – GitHub Actions workflow that builds dbt-fusion from source and runs the full dbt lifecycle

## Prerequisites

### Option 1: Use Pre-built Binary

Download the latest release from the [dbt-fusion releases](https://github.com/dimasgonzales/dbt-fusion/releases).

### Option 2: Build from Source

```bash
# Clone and build dbt-fusion
git clone https://github.com/dimasgonzales/dbt-fusion.git
cd dbt-fusion
cargo build --release -p dbt-sa-cli

# Binary will be at: target/release/dbt-sa-cli
```

## Quick Start

```bash
# Clone this demo
git clone https://github.com/dimasgonzales/dbt-fusion-duckdb-demo.git
cd dbt-fusion-duckdb-demo

# Set path to dbt-fusion binary (adjust as needed)
export DBT_SA=/path/to/dbt-sa-cli

# Verify connection
$DBT_SA debug --project-dir . --profiles-dir .

# Parse project
$DBT_SA parse --project-dir . --profiles-dir .

# Load seed data
$DBT_SA seed --project-dir . --profiles-dir .

# Run models
$DBT_SA run --project-dir . --profiles-dir .

# Run tests
$DBT_SA test --project-dir . --profiles-dir .
```

## Project Structure

```
.
├── dbt_project.yml          # Project configuration
├── profiles.yml             # DuckDB connection (local file)
├── models/
│   ├── staging/
│   │   └── stg_orders.sql   # Staged order data
│   ├── marts/
│   │   └── dim_customers.sql # Customer aggregations
│   └── schema.yml           # Tests + unit tests
├── seeds/
│   └── raw_orders.csv       # Sample order data
├── tests/
│   └── assert_positive_ids.sql # Custom singular test
└── .github/workflows/
    └── test.yml             # CI workflow
```

## Models

| Model | Type | Description |
|-------|------|-------------|
| `stg_orders` | View | Cleans and types raw order data |
| `dim_customers` | Table | Aggregates order metrics per customer |

## Tests

- **Column tests**: `not_null`, `unique`, `accepted_values` on order fields
- **Singular test**: Validates all order IDs are positive
- **Unit test**: Verifies customer aggregation logic

## Configuration

### profiles.yml

```yaml
duckdb_demo:
  target: dev
  outputs:
    dev:
      type: duckdb
      path: 'demo.duckdb'
      threads: 4
```

The database file `demo.duckdb` is created automatically on first run.

## License

MIT
