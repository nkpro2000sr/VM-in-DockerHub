FROM ubuntu
LABEL author="Naveen S R" github="nkpro2000sr" \
      maintainer="srnaveen2k@yahoo.com" \
      aim="To use DockerHub as VM using `docker build` and `ssh`"
COPY L4ssh.sh /

RUN apt-get update && apt-get update && apt-get install -y openssh-server systemd curl netcat
RUN service ssh restart && sh /L4ssh.sh
ENTRYPOINT bash

