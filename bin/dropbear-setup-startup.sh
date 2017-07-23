#!/bin/bash

echo "INSTALLING and SETTING DROPBEAR SSH SERVER on $(hostname)"

# Install Dropbear server
apk --update add --no-cache dropbear

# Setup directories
mkdir /etc/dropbear && touch /var/log/lastlog

# Add vagrant:vagrant SSH user (username:password)
adduser -D vagrant && echo "vagrant:vagrant" | chpasswd

# Start SSH server on port 22 in background mode
dropbear -REmwg -p 22

echo "DROPBEAR SERVER IS RUNNING"
