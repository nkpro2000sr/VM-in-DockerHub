Ubuntu image updated and upgraded `apt-get update && apt-get -y upgrade`.  
OpenSSH, systemd, curl, netcat installed and sshd running `service ssh start`.  

#### Users - Password:
* user - passwd
* root - toor

### Usage:
* `docker run -p 2222:22 nkpro/linux-ssh` will start ssh-server, listening in localhost:2222. This wait 1Mins for connection and waits until the ssh session ends.   
> you can modify this 1Min like `docker run -p 2222:22 nkpro/linux-ssh ./SleepAndWait 300`. ( 300 -> 5Mins )
* `docker run -i -t nkpro/linux-ssh bash` to start interactive bash session. ssh-server also running ( `service ssh stop` to stop it ).  

##### Other Use:
This docker repo is also used for [VM-in-DockerHub](https://github.com/nkpro2000sr/VM-in-DockerHub "VM in DockerHub by misusing auto-build")
