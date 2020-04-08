FROM ubuntu
LABEL author="Naveen S R" github="nkpro2000sr" \
      maintainer="srnaveen2k@yahoo.com" \
      aim="To use DockerHub as VM using `docker build` and `ssh`" \
      image="ubuntu with updated, upgraded and openssh,systemd,curl,netcat installed. also root passwd toor."
COPY L4ssh.sh /

RUN apt-get update && apt-get -y upgrade && apt-get install -y openssh-server systemd curl netcat
RUN service ssh restart && sh /L4ssh.sh && userdel -rf nkpro && rm -f /L4ssh.sh /Exit /Ecode
