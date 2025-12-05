import boto3
import hashlib
import json
from datetime import datetime, timezone

s3 = boto3.client('s3')

def lambda_helper(event, context):
    # extract bucket and key from s3 event
    record = event['Records'][0]
    bucket = record['s3']['bucket']['name']
    key = record['s3']['object']['key']

    # avoid loops on provenance objects
    if key.startswith('provenance/'):
        return {"status": "skipped", "reason": "provenance object"}

     # download file so we can examine it and fingerprint it
    obj = s3.get_object(Bucket=bucket, Key=key)
    body = obj['Body'].read()

     # hash it
    hash_sha256 = hashlib.sha256(body).hexdigest()

     # build the provenance json saving metadata about it
    provenance = {
        "bucket_name": bucket,
        "object_key": key,
        "sha256": hash_sha256,
        "file_size_bytes": obj["ContentLength"],
        "last_modified": obj["LastModified"].isoformat(),
        "hashed_at": datetime.now(timezone.utc).isoformat()
    }

     # save json to s3 to encrypt it
    provenance_key = f"provenance/{key}.json"

    s3.put_object(
        Bucket=bucket,
        Key=provenance_key,
        Body=(json.dumps(provenance) + "\n").encode("utf-8"),
        ServerSideEncryption="aws:kms",
        ContentType="application/json"
    )


    # return metadata for cloudwatch
    return {
        "status": "ok",
        "original_key": key,
        "provenance_key": provenance_key,
        "hash_sha256": hash_sha256

    }

