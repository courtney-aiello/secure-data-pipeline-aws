
CREATE EXTERNAL TABLE IF NOT EXISTS cloudtrail_s3_events (
  Records ARRAY<STRUCT<
      eventVersion:STRING,
      userIdentity:STRUCT<
          type:STRING,
          principalId:STRING,
          arn:STRING,
          accountId:STRING,
          accessKeyId:STRING
      >,
      eventTime:STRING,
      eventSource:STRING,
      eventName:STRING,
      awsRegion:STRING,
      sourceIPAddress:STRING,
      userAgent:STRING,
      requestParameters:STRUCT<
          bucketName:STRING,
          key:STRING
      >,
      responseElements:STRUCT<
          x_amz_server_side_encryption:STRING,
          x_amz_server_side_encryption_aws_kms_key_id:STRING
      >,
      readOnly:BOOLEAN,
      eventID:STRING,
      eventType:STRING,
      managementEvent:BOOLEAN,
      recipientAccountId:STRING,
      eventCategory:STRING
  >>
)
ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe'
LOCATION 's3://caa304-cloudtrail-log/AWSLogs/880207977405/CloudTrail/us-east-2/';
