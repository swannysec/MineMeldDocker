############################################################
# Dockerfile to build Palo Alto Networks MineMeld
# Based on Ubuntu 14.04
# Instructions:
# Build with the following commands:
# sudo docker build -t MineMeld
# sudo docker run -itd -p 8880:80 4443:443 13514 MineMeld
# Change the admin password:
# sudo docker exec -it MineMeld sudo htpasswd /opt/minemeld/local/config/wsgi.htpasswd admin
# sudo docker exec -it MineMeld sudo -u minemeld /opt/minemeld/engine/current/bin/supervisorctl -c /opt/minemeld/local/supervisor/config/supervisord.conf restart minemeld-web
# The Web UI will be available on https://<address>:4443
############################################################

# Set the base image to Ubuntu 14.04
FROM ubuntu:14.04

# File Author / Maintainer
MAINTAINER John D. Swanson

# Update the repository sources list, install wget, and run updates
RUN apt-get update && apt-get install wget && apt-get dist-upgrade -y

# Add the MineMeld Repo GPG Key
RUN wget -qO - https://minemeld-updates.panw.io/gpg.key | sudo apt-key add -

# Add the MineMeld APT Repo
RUN add-apt-repository "deb http://minemeld-updates.panw.io/ubuntu trusty-minemeld main"

# Install MineMeld
RUN apt-get update && apt-get install -y minemeld rsyslog-minemeld rsyslog-mmnormalize apache2-utils

# Expose Ports
EXPOSE 22 80 443 13514
