# Core Data Pipeline - First Phase

**Goal:** Establish a secure baseline pipeline that logs and audits all S3 and Glue activity.

### Components
- **S3:** Versioning + SSE-KMS enabled
- **CloudTrail:** Logs S3 data events into `caa304-cloudtrail-log`
- **Athena:** Queries CloudTrail logs for auditing
- **Glue:** Optional ETL integration (future phase)

**Steps Completed So Far:**
- Architecture diagram uploaded
- Setting up S3 + CloudTrail + Athena
- CloudTrail logging verified with `PutObject` and `ListObjects` events
- Set up Athena table
- Athena sample query tested


**Next Steps:**
1. Flatten and create view in Athena
2. Query logs in Athena: who accessed what, and when
3.

