CREATE OR REPLACE VIEW cloudtrail_s3_events_flattened AS
SELECT
  r.eventTime,
  r.eventName,
  r.eventSource,
  r.awsRegion,
  r.userIdentity.type AS user_type,
  r.userIdentity.arn AS user_arn,
  r.requestParameters.bucketName AS bucket_name,
  r.requestParameters.key AS object_key,
  r.sourceIPAddress,
  r.userAgent,
  r.eventType,
  r.readOnly,
  r.eventCategory,
  r.eventId
FROM cloudtrail_s3_events
CROSS JOIN UNNEST(records) AS t(r);