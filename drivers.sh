#!/bin/bash
sudo rmmod nvidia_drm nvidia_modeset nvidia_uvm nvidia
mkdir -p /opt/nvidia/drivers/
wget http://169.254.169.254/latest/nvidia_linux_driver_url -O /opt/nvidia/drivers/nvidia_manual_driver.run
chmod +x /opt/nvidia/drivers/nvidia_manual_driver.run
/opt/nvidia/drivers/nvidia_manual_driver.run --ui=none --no-questions
