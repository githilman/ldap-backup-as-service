#!/bin/bash

timestamp=`date +%Y%m%d`

ldapsearch -D "uid=admin,ou=system" -w $PASS -p $PORT -h $IP -b "ou=system" -s sub -a always "(objectClass=*)" > /app/backup/$timestamp.ldif

echo "Database backup done"

gcloud auth activate-service-account $EMAIL --key-file=/app/key.json --project=$PROJECT

gsutil cp -r /app/backup/** gs://$BUCKET

echo "stored to gcs"