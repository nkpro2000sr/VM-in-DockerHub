# VM-in-DockerHub
To run Ubuntu Virtual Machine in DockerHub. Login via ssh, Getting IP &amp; Port via write.as, Reverse Tunneling through serveo.net.
> Don't think it runs forever :smile: [see this](https://success.docker.com/article/what-are-the-current-resource-limits-placed-on-automated-builds "It has some limitations")

## Procedure
1. Set [IP](http://serveo.net/ "I am using serveo.net") and Port (like IP:Port) to which the machine request for Reverse Tunneling in write.as and change the url in L4ssh.sh with your write.as url.  
> Q) why not raw-gist?  
> Although raw-git is a little bit easier than write.as it has some delay to host the updated changes.  
> Then among others it is easy to parse value from source code in write.as .  

If you want to use raw-gist replace line no. 8 and 29 as `ip="$(curl ${url}|sed -r "s/:/ -R /g")"`  

2. Goto [DockerHub](https://hub.docker.com/), create a repository. While creating repo choose github in Build Settings and select username and github-repo. Then create a Build Rule. Finally click 'Create' button.  

3. Now goto builds tab in docker repo and press 'Trigger' button in Automated Builds section.  

4. Build will be started after sometime. Now, 'L4ssh.sh' script is running and listening for ssh logins.

5. Now, `ssh nkpro@IP -p Port -o "ServerAliveInterval 10"` will login into VM running in DockerHub.
> nkpro is username according to this script. It can be changed by replacing 'nkpro:nkpro2000sr' by 'username:password'. Root password for this VM is 'toor' again it can also be changed in the script.
