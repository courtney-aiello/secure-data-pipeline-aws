# Core Data Pipeline - First Phase

**Goal:** Establish a secure baseline pipeline that logs and audits all S3 and Glue activity.

**Components:**
- S3 (Versioning + SSE-KMS)
- CloudTrail (S3 Data Events)
- Athena (query CloudTrail logs)
- Glue (optional ETL later)

**Steps Completed So Far:**
- Architecture diagram uploaded
- 🚧 Setting up S3 + CloudTrail + Athena

**Next Steps:**
1. Create buckets: `caa304-raw-data`, `caa304-processed-data`, `caa304-cloudtrail-logs`
2. Enable CloudTrail → Log S3 Data Events
3. Query logs in Athena: who accessed what, and when
