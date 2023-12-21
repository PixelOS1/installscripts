#!/bin/bash
mkdir kernel
cd kernel
wget https://www.pixelos.com/downloads/kernel/6.4.11/debian/debs/linux-headers-6.4.11-tkg-pixelos_6.4.11-1_amd64.deb
wget https://www.pixelos.com/downloads/kernel/6.4.11/debian/debs/linux-image-6.4.11-tkg-pixelos-dbg_6.4.11-1_amd64.deb
wget https://www.pixelos.com/downloads/kernel/6.4.11/debian/debs/linux-image-6.4.11-tkg-pixelos_6.4.11-1_amd64.deb
wget https://www.pixelos.com/downloads/kernel/6.4.11/debian/debs/linux-libc-dev_6.4.11-1_amd64.deb
dpkg -i *
reboot
