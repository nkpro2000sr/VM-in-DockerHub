# VM-in-DockerHub
To run Ubuntu Virtual Machine in DockerHub. Login via ssh, Getting IP &amp; Port via write.as, Reverse Tunneling through serveo.net.
> Don't think it runs forever :smile: [see this](https://success.docker.com/article/what-are-the-current-resource-limits-placed-on-automated-builds "It has some limitations")

## Procedure
1. Set [IP](http://serveo.net/ "I am using serveo.net") and Port (like IP:Port or IP|22:Port) to which the machine request for Reverse Tunneling in write.as and change the [url in L4ssh.sh](https://github.com/nkpro2000sr/VM-in-DockerHub/blob/master/L4ssh.sh#L2 "url=https://write.as/nkpro/hackdok") with your write.as url.  
> Q) why not raw-gist?  
> Although raw-git is a little bit easier than write.as it has some delay to host the updated changes.  
> Then among others it is easy to parse value from source code in write.as .  

If you want to use [raw-gist](https://gist.githubusercontent.com/nkpro2000sr/1c43d7de1bb3ed5a6f6d1e9b98fbc867/raw/hackdok "Example raw-gist") replace line no. [11](https://github.com/nkpro2000sr/VM-in-DockerHub/blob/master/L4ssh.sh#L11 "ip=[\S ]*") and [36](https://github.com/nkpro2000sr/VM-in-DockerHub/blob/master/L4ssh.sh#L36 "ip=[\S ]*") as `ip="$(curl ${url}|sed -r "s/:/ -R /g;s/\|/ -p /g")"`  
> Don't forgot to make raw-gist link in 'https://gist.githubusercontent.com/<username\>/\<hash>/raw/\<filename>' format.  

Alternative to Serveo you can use your local machine as Tunneling service (if your IP is static). For this you can specify IP, Port (in which ssh-server is running) and RPort (in which you can connect for ssh-session) in your write.as page (like IP|Port:RPort).  
You can also run Serveo Server in your local machine (see [this](https://gist.github.com/nkpro2000sr/3ee13cd346c57f90c20cd8e33497d6a3 "ServeoinLocal")).  

2. Goto [DockerHub](https://hub.docker.com/), create a repository. While creating repo choose github in Build Settings and select username and github-repo. Then create a Build Rule. Finally click 'Create' button.  

3. Now goto builds tab in docker repo and press 'Trigger' button in Automated Builds section.  

4. Build will be started after sometime. Now, 'L4ssh.sh' script is running and listening for ssh logins.  

5. Now, `ssh user@IP -p Port -o "ServerAliveInterval 10"` will login into VM running in DockerHub and password is 'passwd'.  
> user is username according to this Dockerfile. It can be changed by replacing ['user:passwd'](https://github.com/nkpro2000sr/VM-in-DockerHub/blob/master/Dockerfile#L10 "echo user:passwd | chpasswd") by 'username:password' in Dockerfile. Root password for this VM is 'toor' again it can also be changed in the Dockerfile.

## Usage
### \<close>
To make L4ssh not to start Reverse Tunneling. If Reverse Tunneling already started it will close if no ssh session running otherwise it waits. Also if Reverse Tunneling started within 5Mins ago it will wait (untill this 5Mins ends).  
##### Example
* [write.as](https://write.as/nkpro/close "<close> in write.as")
* [raw-gist](https://gist.githubusercontent.com/nkpro2000sr/1c43d7de1bb3ed5a6f6d1e9b98fbc867/raw/close "<close> in raw-git")

### \<Fclose>
Same as \<close> but it waits for nothing.  
##### Example
* [write.as](https://write.as/nkpro/fclose "<Fclose> in write.as")
* [raw-gist](https://gist.githubusercontent.com/nkpro2000sr/1c43d7de1bb3ed5a6f6d1e9b98fbc867/raw/fclose "<Fclose> in raw-gist")

### \<exit>
To exit L4ssh. It also wait for nothing.  
##### Example
* [write.as](https://write.as/nkpro/exit "<exit> in write.as")
* [raw-gist](https://gist.githubusercontent.com/nkpro2000sr/1c43d7de1bb3ed5a6f6d1e9b98fbc867/raw/exit "<exit> in raw-gist")

### /Exit
To command L4ssh to exit from ssh session. Just creating '/Exit' file `touch /Exit` will make L4ssh exit immediately.  

### /Ecode
Every time L4ssh exiting it exits with value in '/Ecode' as return code `exit $(cat /Ecode)` .  
And it can be modified within ssh session.  
