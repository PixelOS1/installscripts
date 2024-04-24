#!/bin/bash

flagFile="/opt/pixelos/installscripts/ip_check_flag.txt"

while true; do
    # Check if the flag file exists
    if [ ! -e "$flagFile" ]; then
        # Fetch the public IP address of the server using checkip.amazonaws.com
        ipAddress=$(curl -s https://checkip.amazonaws.com/)

        response=$(curl -s "https://www.pixelos.com/scripts/checkip.php?ip_to_check=$ipAddress")

        name=$(echo "$response" | jq -r '.name')

        if [ "$name" != "null" ]; then
            sudo hostnamectl set-hostname "$name"

            touch "$flagFile"
            echo "Flag file created."
            /bin/bash /opt/pixelos/netdata.sh
        fi
    else
        break
    fi
done
