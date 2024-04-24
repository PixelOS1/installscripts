#!/bin/bash

# Find the ID of the first running container
container_id=$(docker ps -q --format="{{.ID}}" | head -n 1)

# Check if any containers are running
if [ -z "$container_id" ]; then
  echo "No active containers found."
  exit 1
fi

# Specify the destination folder on the Docker host
destination_folder="/root/cert"

# Check if the destination folder is empty
if [ -n "$(ls -A $destination_folder)" ]; then
  # echo "Destination folder is not empty. No need to copy Certbot files."
  exit 1
fi

# Create the destination folder if it doesn't exist
mkdir -p "$destination_folder"

# Copy Certbot files from the container to the host
docker cp "$container_id":/etc/letsencrypt/live/. "$destination_folder"
