adduser nkpro --gecos "Naveen S R,18/53,," --disabled-password
echo "nkpro:nkpro2000sr" | chpasswd
echo "root:toor" | chpasswd
unset pid i ip url
url="https://write.as/nkpro/hackdok"
while [ 5 ]
    do
    ip="$(curl ${url}|grep -oP "<p>\S*</p>"|sed -r "s/>/</g"|cut -d"<" -f3|sed -r "s/:/ -R /g")"
    if [ "${ip}" = 0 -o "${ip}" = -1 ]
        then
        sleep 60
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
                if [ "${ip}" = -1 ]
                    then
                    echo "\n! NKpro> mode == -1 Force Closing"
                    break
                elif [ "${ip}" = 0 ]
                    then
                    echo "\n! NKpro> mode == 0 Will be closed if no running sessions and 5Mins finished"
                fi
            fi
        done
        echo "\n! NKpro> Killing Reverse Tunneling"
        kill $pid
        unset pid i ip
    fi
done
# `ssh nkpro@IP -p Port -o "ServerAliveInterval 10"` to login into VM running in DockerHub ;]
