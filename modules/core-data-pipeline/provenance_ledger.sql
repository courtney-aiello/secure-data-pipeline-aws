CREATE OR REPLACE VIEW provenance_ledger AS
SELECT
    ct.eventTime              AS event_time,
    ct.eventName              AS event_name,
    ct.bucket_name,
    ct.object_key,
    ct.user_arn,
    ct.sourceIPAddress        AS source_ip,
    h.sha256                  AS object_hash,
    h.file_size_bytes         AS file_size_bytes,
    h.hashed_at,

    -- pipeline classification
    CASE
        WHEN ct.bucket_name LIKE '%raw-data%' 
             AND ct.object_key LIKE 'incoming/%'
             THEN 'bronze'
        WHEN ct.bucket_name LIKE '%raw-data%' 
             AND ct.object_key LIKE 'processed/%'
             THEN 'silver'
        WHEN ct.bucket_name LIKE '%cloudtrail%' 
             THEN 'audit_log'
        ELSE 'unknown'
    END AS pipeline_layer

FROM cloudtrail_s3_events_flattened ct
LEFT JOIN s3_object_hashes h
    ON  ct.bucket_name = h.bucket_name
    AND ct.object_key  = h.object_key;
