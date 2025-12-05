CREATE EXTERNAL TABLE IF NOT EXISTS s3_object_hashes (
    bucket_name        string,
    object_key         string,
    sha256             string,
    file_size_bytes    bigint,
    hashed_at          timestamp
)
ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe'
WITH SERDEPROPERTIES (
    'ignore.malformed.json' = 'true'
)
LOCATION 's3://caa304-raw-data/provenance/incoming/';
