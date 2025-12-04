# Secure Data Pipeline on AWS
This project demonstrates how to build and secure a small data pipeline using AWS S3, Glue, and Athena with defense-in-depth principles like encryption, monitoring, and automated alerts.

## Folder Structure
- `data/` <- sample dataset for ingestion
- `diagrams/` <- system and provenance diagrams
- `glue_jobs/` <-  ETL scripts
- `lambda/` <- lambdas
- `modules/` <-  sql and other files
- `docs/` <-  documentation and security notes


## Architecture Diagram
![Architecture Diagram](diagrams/architecture.png)

## Setup
Create S3 buckets for:
	raw/ (Bronze)
	raw/provenance/ (hash logs and signatures)
	processed/ (Silver)
	analytics/ (Gold)

Add in Lambda functions
Query with Athena
Run Glue jobs

## Security Controls
Encryption -
- S3 default encryption (SSE-KMS)
- KMS-encrypted CloudTrail logs
- Encrypted object-level hashing + signature storage in provenance layer

Access Controls -
- IAM least-privilege policies for Glue, Athena, and Lambda
- S3 bucket policies enforcing explicit principals
- CloudTrail logging for all bucket read/write operations

Monitoring -
- CloudTrail events tracked and parsed into Athena
- SNS notifications for anomalies

Data Integrity & Provenance -
- Hashing lambda captures SHA-256 for each file as soon as it lands
- (S3 + Athena view) track: lineage

## Data Provenance Layer
This is the main objective of the project.
It:
- Logs every write to S3 using CloudTrail
- In the Lambda, it extracts metadata (bucket, key, user, IP, event time)
- Computes file hashes for integrity verification
![Provenance Flow Diagram](../diagrams/provenance-flow.png)
