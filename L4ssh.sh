unset pid i ip url
url="https://write.as/nkpro/hackdok" # Change this with your url
echo 0 > /Ecode
Exit () {
    rm -f /L4ssh.sh /Exit /Ecode
    exit $1
}

while [ 5 ]
    do
    ip="$(curl ${url}|grep -oP "<p>\S*</p>"|sed -r "s/>/</g"|cut -d"<" -f3|sed -r "s/:/ -R /g;s/\|/ -p /g")"
    if [ "${ip}" = "close" -o "${ip}" = "Fclose" ]
        then
        sleep 60
    elif [ "${ip}" = "exit" ]
        then
        echo "!> <exit> Exiting."
        Exit $(cat /Ecode)
    elif [ -z "${pid}"  ]
        then
        echo "!> Starting Reverse Tunneling"
        ssh ${ip}:localhost:22 -o "StrictHostKeyChecking accept-new" &
        pid="$!"
    fi
    if [ -n "${pid}" ]
        then
        echo "!> \`ssh ${ip}:localhost:22 -o \"StrictHostKeyChecking accept-new\" &\` running in ${pid}"
        i=0
        while [ "$i" -lt 30 -o -n "$(who | grep 'user')" ]
            do
            sleep 10
            echo -n "$i."
            i=$(($i + 1))
            if [ "$(($i % 6))" = 0 ]
                then
                ip="$(curl ${url} 2>/dev/null|grep -oP "<p>\S*</p>"|sed -r "s/>/</g"|cut -d"<" -f3)"
                if [ "${ip}" = "Fclose" ]
                    then
                    echo "\n!> <Fclose> Force Closing."
                    break
                elif [ "${ip}" = "close" ]
                    then
                    echo "\n!> <close> Will be closed if no running sessions and 5Mins finished."
                elif [ "${ip}" = "exit" ]
                    then
                    echo "\n!> <exit> Exiting."
                    Exit $(cat /Ecode)
                fi
            fi
            if [ -f /Exit ]
                then
                echo "\n!> </Exit> Exiting."
                Exit $(cat /Ecode)
            fi
        done
        echo "\n!> Killing Reverse Tunneling"
        kill $pid
        unset pid i ip
    fi
    if [ -f /Exit ]
        then
        echo "\n!> </Exit> Exiting."
        Exit $(cat /Ecode)
    fi
done
# `ssh user@IP -p Port -o "ServerAliveInterval 10"` to login into VM running in DockerHub ;]
