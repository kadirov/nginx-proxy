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
    echo "Cron is already installed."
fi

# Set crontab
CRON_COMMAND="/bin/bash /root/nginx-proxy/update.sh"

if crontab -l | grep -q "$CRON_COMMAND"; then
    echo "Cron job already exists."
else
    # cron job to run on the 15th of every month at midnight (00:00)
    (crontab -l ; echo "0 0 15 * * $CRON_COMMAND") | crontab -
    echo "Cron job added to run on the 15th of every month at midnight."
fi
