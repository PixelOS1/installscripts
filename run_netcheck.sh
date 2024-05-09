#!/bin/bash

flagFile="/opt/pixelos/installscripts/ip_check_flag.txt"

# Function to check if the response contains the error message
check_error() {
    echo "$1" | jq -e '.error' &>/dev/null
}

# Function to fetch IP address
fetch_ip() {
    curl -s https://checkip.amazonaws.com/
}

# Function to fetch response from PHP script
fetch_response() {
    local ip_address=$1
    curl -s "https://www.pixelos.com/scripts/checkip.php?ip_to_check=$ip_address"
}

# Start timestamp for tracking time
start_time=$(date +%s)

while true; do
    # Check if the flag file exists and is not empty
    if [ -s "$flagFile" ]; then
        break
    fi

    # Fetch the public IP address of the server
    ipAddress=$(fetch_ip)

    # Fetch response from PHP script
    response=$(fetch_response "$ipAddress")

    # Check for error message
    if check_error "$response"; then
        echo "Error: IP address not found in the data. Retrying..."
    else
		# Install netdata
		/bin/bash /opt/pixelos/installscripts/netdata.sh
		
		# Set hostname
        name=$(echo "$response" | jq -r '.name')
        
        if [ "$name" != "null" ]; then
            sudo hostnamectl set-hostname "$name"

            touch "$flagFile"
            echo "Flag file created."

            # Write a message to a file
            echo "Server hostname updated to $name" > "$flagFile"
            break  # Exit the loop once the flag is created
        fi
    fi
done
