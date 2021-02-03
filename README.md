# LDAP Backup as Service

A cron to backup .ldif file from Apacheds LDAP server and stored to GCS.

It's hard to automatically backup LDAP data since there's no convenient way to backup it. This repo is a cron that will backup LDAP data under ou=system every 01.00 AM and stored the backup file to GCS bucket. This is my convenient way to do regular user data backup from LDAP server deployed on kubernetes cluster.

### HOW TO

- Create service account file .json. You can include it in this dockerize or mount it as a secret in Kubernetes. The service account file json set as **`key.json`** in this app.

- Set env variable
```
set .env.example to .env and fill the value of yours

all value used in backup.sh file

```
.env value

```
PASS= "your LDAP Password"
PORT= "your LDAP PORT"
IP= "your LDAP IP"
EMAIL= "your GCP service account email"
PROJECT= "your GCP project"
BUCKET= "your GCS Bucket"
```

- Build Docker Image
```
docker build -t image-name:latest .
```

- Test on local 
```
docker run -d --name ldap-backup image-name:latest
```

- Push The Image to your container registry
```
ex Dockerhub:

docker tag image-name username/repository:latest

docker push username/repository:latest
```

- Your Image ready to be deployed to kubernetes as a deployment service