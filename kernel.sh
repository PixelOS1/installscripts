#!/bin/bash
mkdir kernel
cd kernel
wget https://www.pixelos.com/downloads/kernel/6.4.11/debian/debs/linux-headers-6.4.11-tkg-pixelos_6.4.11-1_amd64.deb
wget https://www.pixelos.com/downloads/kernel/6.4.11/debian/debs/linux-image-6.4.11-tkg-pixelos-dbg_6.4.11-1_amd64.deb
wget https://www.pixelos.com/downloads/kernel/6.4.11/debian/debs/linux-image-6.4.11-tkg-pixelos_6.4.11-1_amd64.deb
wget https://www.pixelos.com/downloads/kernel/6.4.11/debian/debs/linux-libc-dev_6.4.11-1_amd64.deb
dpkg -i *

# Install kdump
apt-get update
apt-get install -y kdump-tools

# Configure kdump
cat <<EOF >> /etc/default/kdump-tools
KDUMP_COMMANDLINE_APPEND="reboot"
EOF

# Enable kdump
systemctl enable kdump-tools
