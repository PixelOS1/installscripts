#!/bin/bash

# Enable NVIDIA GPU monitoring for Netdata

# Check if Netdata is installed
if ! command -v netdata &> /dev/null; then
    sudo wget -O /tmp/netdata-kickstart.sh https://get.netdata.cloud/kickstart.sh && sh /tmp/netdata-kickstart.sh --stable-channel --claim-token $NETDATA_CLAIM_TOKEN --claim-rooms $NETDATA_CLAIM_ROOMS --claim-url https://app.netdata.cloud --dont-wait
fi

# Enable NVIDIA GPU monitoring
sudo tee -a /etc/netdata/python.d/nv.plugin <<END
update_every: 1
priority: 60000

jobs:
  - name: gpu
    url: http://127.0.0.1:{{ netdata_port }}/api/v1/data?chart=gpu.load
    update_every: 1
END

# Restart Netdata to apply changes
sudo systemctl restart netdata

# Define the path to the Netdata configuration directory
config_dir="/etc/netdata"

# Define the path to the specific configuration file
config_file="$config_dir/python.d.conf"

# Use sed to uncomment the line containing 'nvidia_smi: yes'
sed -i '/# nvidia_smi: yes/s/^# //' "$config_file"

# Restart Netdata to apply changes
sudo systemctl restart netdata

echo "NVIDIA GPU monitoring enabled for Netdata."
