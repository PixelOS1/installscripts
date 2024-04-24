#!/bin/bash

# Check if nvidia-smi can communicate with the NVIDIA driver
if nvidia-smi &> /dev/null; then
    echo "NVIDIA driver is installed and working."
else
    echo "NVIDIA-SMI has failed to communicate with the NVIDIA driver. Installing the driver..."
    # Run the driver installation script
    /opt/pixelos/installscripts/drivers.sh
    # Check if nvidia-smi works after installation
    if nvidia-smi &> /dev/null; then
        echo "NVIDIA driver installation successful."
    else
        echo "NVIDIA driver installation failed."
        exit 1
    fi
fi
