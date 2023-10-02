#!/bin/bash

# Check if cron is installed
if ! command -v cron &>/dev/null; then
    echo "Cron is not installed. Installing..."
    
    if command -v apt-get &>/dev/null; then
        sudo apt-get update
        sudo apt-get install cron -y
    elif command -v yum &>/dev/null; then
        sudo yum install cronie -y
    elif command -v dnf &>/dev/null; then
        sudo dnf install cronie -y
    else
        echo "Unsupported package manager. Please install cron manually."
        exit 1
    fi
    
    sudo systemctl start cron
    sudo systemctl enable cron
    echo "Cron has been installed and started."
else
    echo "Cron is installed."
fi

# Set crontab
cp -f /root/nginx-proxy/scripts/cron-file /etc/cron.d/
sudo chmod 644 /etc/cron.d/cron-file
crontab /etc/cron.d/cron-file
crontab -l
