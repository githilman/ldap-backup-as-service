FROM ubuntu:16.04

WORKDIR /app

COPY . .

COPY .env.example .env

RUN source .env
# Add crontab file in the cron directory
ADD crontab /etc/cron.d/hello-cron

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/hello-cron

RUN chmod +x backup.sh

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

RUN apt-get update
RUN apt-get -y install curl cron ldap-utils

# Add the Cloud SDK distribution URI as a package source
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

# Import the Google Cloud Platform public key
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -

#Install Cron ldap-utils gcloud-sdk
RUN apt-get update
RUN apt-get -y install google-cloud-sdk

RUN chmod +x entrypoint.sh

# Run the command on container startup
ENTRYPOINT [ "./entrypoint.sh" ]
