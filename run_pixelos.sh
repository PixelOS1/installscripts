#!/bin/bash

#Then check for docker and then start the PixelOS image.

while true; do
    # Check if Docker daemon is running
    if pgrep -x "dockerd" > /dev/null; then
        echo "Docker daemon is running."

                # Run docker with local user credentials
                /usr/bin/docker run -e LOCAL_USER_ID=$USERID --network=host --privileged --gpus all -e TZ=America/New_York -e SIZEW=1920 -e SIZEH=1080 -e REFRESH=60 -e DPI=96 -e CDEPTH=24 -e VIDEO_PORT=DFP -e WATCHTOWER_REMOTE_IDENTITY=127.0.0.1 -e EXPERIENCEID=$EXPERIENCEID -e ORBIT_DNS_SIMPLE_ACCESS_TOKEN=$ORBIT_DNS_SIMPLE_ACCESS_TOKEN -e HTTP=8100 -e STREAMER=8200 -e SFU=8300 -e GAMEEXEPATH=$GAMEEXEPATH -e WEBRTC_VIDEO_BITRATE=2000 -e WEBRTC_FRAMERATE=30 -e WEBRTC_BLOCKSIZE=16384 -e WEBRTC_WM=1 -e NEWCERT=1 -e WEBRTC_ENCODER=x264enc -e WEBRTC_ENABLE_RESIZE=false -p 8080:8080 -p 80:80 -p 2222:2222 -p 443:443 $DOCKERIMAGE

        break  # Exit the loop once the Docker daemon is running
    else
        /usr/bin/docker ps
        echo "Docker daemon is not running. Waiting..."
        sleep 5  # Adjust the sleep time as needed
    fi
done
