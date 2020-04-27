#!/bin/bash

mkdir -p $MNT_PATH

export AWS_ACCESS_KEY_ID=$S3_ACCESS_KEY
export AWS_SECRET_ACCESS_KEY=$S3_SECRET_KEY

syslog-ng -f /etc/syslog-ng/syslog-ng.conf

goofys -f ${S3_ENDPOINT:+--endpoint $S3_ENDPOINT} ${S3_REGION:+--region $S3_REGION} --stat-cache-ttl $STAT_CACHE_TTL --type-cache-ttl $TYPE_CACHE_TTL --dir-mode $DIR_MODE --file-mode $FILE_MODE -o allow_other $S3_BUCKET $MNT_PATH