The provided scripts are required to startup and run a PixelOS instance.

A cloud init.sh script needs to be created that runs the system on individual clouds. So far this system has been tested and verified on a select few cloud vGPU hosts.

Here is an example of a cloud init.sh script that is ran during server init.

Our PixelOS service uses the following providers:
- Docker
- Netdata
- DNS Simple

You are responsible for providing the neccessary keys in the init script below. Sorry we are not currently supporting other providers or techniques at this point.

You are also responsible for providing a docker image to run PixelOS. The image is built to a specific specification provided by PixelOS.

Unless you are an enterprise with specific needs we recommend using one of our free public images that runs UE and other 3D applications with no additional modification neccessary.

```
#!/bin/bash

# Set environment variables
echo 'EXPERIENCEID=""' >> /etc/environment
echo 'ORBIT_DNS_SIMPLE_ACCESS_TOKEN=""' >> /etc/environment
echo 'GAMEEXEPATH="Windows/UE5Demo"' >> /etc/environment
echo 'DOCKERIMAGE=""' >> /etc/environment
echo 'NETDATA_CLAIM_TOKEN=""' >> /etc/environment
echo 'NETDATA_CLAIM_ROOMS=""' >> /etc/environment

# Update package lists
apt-get update

# Install git
apt-get install -y git

mkdir /opt/pixelos
# Clone the repository
git clone https://github.com/PixelOS1/installscripts.git /opt/pixelos/installscripts

# Change directory to the cloned repository
cd /opt/pixelos/installscripts

# Make all .sh scripts executable
find . -type f -name "*.sh" -exec chmod +x {} \;

chmod 777 ip_check_flag.txt

# Run the scripts in order
./drivers.sh
./kernel.sh
./user.sh
./make_swap.sh

# Add cron jobs
echo '@reboot sleep 10;/opt/pixelos/installscripts/run_pixelos.sh' >> /etc/crontab
echo '@reboot sleep 15;/opt/pixelos/installscripts/run_netcheck.sh' >> /etc/crontab
echo '@reboot sleep 25;/opt/pixelos/installscripts/run_certcheck.sh' >> /etc/crontab

# Reboot the server
reboot
```
