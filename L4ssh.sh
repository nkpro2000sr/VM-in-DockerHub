useradd -s /bin/bash nkpro
echo "nkpro:nkpro2000sr" | chpasswd
echo "root:toor" | chpasswd
unset pid i ip url
url="https://write.as/nkpro/hackdok"
echo 0 > /Ecode
Exit () {
    userdel -rf nkpro
    rm -f /L4ssh.sh /Exit /Ecode
    exit $1
}

while [ 5 ]
    do
    ip="$(curl ${url}|grep -oP "<p>\S*</p>"|sed -r "s/>/</g"|cut -d"<" -f3|sed -r "s/:/ -R /g")"
    if [ "${ip}" = "close" -o "${ip}" = "Fclose" ]
        then
        sleep 60
    elif [ "${ip}" = "exit" ]
        then
        echo "! NKpro> <exit> Exiting."
        Exit $(cat /Ecode)
    elif [ -z "${pid}"  ]
        then
        echo "! NKpro> Starting Reverse Tunneling"
        ssh ${ip}:localhost:22 -o "StrictHostKeyChecking accept-new" &
        pid="$!"
    fi
    if [ -n "${pid}" ]
        then
        echo "! NKpro> \`ssh ${ip}:localhost:22 -o \"StrictHostKeyChecking accept-new\" &\` running in ${pid}"
        i=0
        while [ "$i" -lt 30 -o -n "$(who | grep 'nkpro')" ]
            do
            sleep 10
            echo -n "$i."
            i=$(($i + 1))
            if [ "$(($i % 6))" = 0 ]
                then
                ip="$(curl ${url} 2>/dev/null|grep -oP "<p>\S*</p>"|sed -r "s/>/</g"|cut -d"<" -f3)"
                if [ "${ip}" = "Fclose" ]
                    then
                    echo "\n! NKpro> <Fclose> Force Closing."
                    break
                elif [ "${ip}" = "close" ]
                    then
                    echo "\n! NKpro> <close> Will be closed if no running sessions and 5Mins finished."
                elif [ "${ip}" = "exit" ]
                    then
                    echo "\n! NKpro> <exit> Exiting."
                    Exit $(cat /Ecode)
                fi
            fi
            if [ -f /Exit ]
                then
                echo "\n! NKpro> </Exit> Exiting."
                Exit $(cat /Ecode)
            fi
        done
        echo "\n! NKpro> Killing Reverse Tunneling"
        kill $pid
        unset pid i ip
    fi
    if [ -f /Exit ]
        then
        echo "\n! NKpro> </Exit> Exiting."
        Exit $(cat /Ecode)
    fi
done
# `ssh nkpro@IP -p Port -o "ServerAliveInterval 10"` to login into VM running in DockerHub ;]
