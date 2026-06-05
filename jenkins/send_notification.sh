#!/bin/bash
TO_EMAIL="$NOTIFICATION_EMAIL"
SUBJECT="Pipeline Status: $JOB_NAME - Build #$BUILD_NUMBER"
BODY="Pipeline finished with status: $JOB_STATUS. See artifacts at $BUILD_URL"

sendmail -S mailhog:1025 -f "jenkins@projetos07.com" "$TO_EMAIL" <<EOF
Subject: $SUBJECT
$BODY
EOF
