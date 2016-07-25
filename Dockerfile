############################################################
# Dockerfile to build Palo Alto Networks MineMeld
# Based on Ubuntu 14.04
# Instructions:
# Build with the following commands:
# sudo docker build -t swannysec:MineMeld github.com/swannysec/MineMeldDocker
# sudo docker run -itd -p 8880:80 -p 4443:443 -p 13514 swannysec:MineMeld
# Change the admin password:
# Get the Container ID first:
# sudo docker ps
# sudo docker exec -it CONTAINER htpasswd /opt/minemeld/local/config/wsgi.htpasswd admin
# sudo docker exec -it CONTAINER sudo -u minemeld /opt/minemeld/engine/current/bin/supervisorctl -c /opt/minemeld/local/supervisor/config/supervisord.conf restart minemeld-web
# The Web UI will be available on https://<address>:4443
############################################################

# Set the base image to Ubuntu 14.04
FROM ubuntu:14.04

# File Author / Maintainer
MAINTAINER John D. Swanson

# Update the repository sources list, install wget and software-properties-common, and run updates
RUN apt-get update && apt-get install wget software-properties-common -y && apt-get dist-upgrade -y

# Add the MineMeld Repo GPG Key
RUN wget -qO - https://minemeld-updates.panw.io/gpg.key | sudo apt-key add -

# Add the MineMeld APT Repo
RUN sudo add-apt-repository "deb http://minemeld-updates.panw.io/ubuntu trusty-minemeld main"

# Install MineMeld
RUN apt-get update && apt-get install -y minemeld rsyslog-minemeld rsyslog-mmnormalize apache2-utils

# Expose Ports and Set CMD
EXPOSE 22 80 443 13514
