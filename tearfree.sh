#!/bin/bash

# Check if xorg.conf exists
if [ ! -f "/etc/X11/xorg.conf" ]; then
    touch /etc/X11/xorg.conf
fi

# Append NVIDIA settings to xorg.conf
bash -c 'cat << EOF >> /etc/X11/xorg.conf
Section "Device"
    Identifier "NVIDIA Card"
    Driver "nvidia"
    Option "metamodes" "nvidia-auto-select +0+0 { ForceFullCompositionPipeline = On }"
    Option "AllowIndirectGLXProtocol" "off"
    Option "TearFree" "true" # Add TearFree option
EndSection
EOF'
