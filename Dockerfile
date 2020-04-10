FROM ubuntu
LABEL author="Naveen S R" github="nkpro2000sr" \
      maintainer="srnaveen2k@yahoo.com" \
      aim="To use DockerHub as VM using `docker build` and `ssh`" \
      image="ubuntu with updated, upgraded and openssh,systemd,curl,netcat installed. also root passwd toor."
COPY L4ssh.sh /

RUN apt-get update && apt-get -y upgrade && apt-get install -y openssh-server systemd curl netcat tmux
RUN service ssh restart && sh /L4ssh.sh

# For docker: nkpro/linux-ssh
RUN useradd -s /bin/bash user && echo "user:passwd" | chpasswd
ENTRYPOINT ["/bin/bash","-c", "service ssh start; \
            SleepAndWait () { \
                sleep ${1-60}; \
                while [ -n \"$(who | grep user)\" ]; do sleep ${2-1}; done; \
                exit; \
            }; saw () { SleepAndWait $@; }; $@", "foo"]
EXPOSE 22
CMD ["SleepAndWait"]
