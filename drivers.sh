#!/bin/bash
mkdir -p /opt/nvidia/drivers/
wget https://www.pixelos.com/downloads/drivers/linux_nvidia_client.run -O /opt/nvidia/drivers/nvidia_manual_driver.run
chmod +x /opt/nvidia/drivers/nvidia_manual_driver.run
/opt/nvidia/drivers/nvidia_manual_driver.run --ui=none --no-questions
/opt/pixelos/installscripts/tearfree.sh
reboot
