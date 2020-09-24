#!/bin/bash
echo "Installing stress tools and remove unattended-upgrades"
DEBIAN_FRONTEND=noninteractive,TZ="America/Central" \
apt-get remove unattended-upgrades && \
apt-get update && \
apt-get install -y \
tzdata \
git \
stress-ng \
sysstat \
psmisc \
netsniff-ng && \
git clone https://github.com/jonschipp/gencfg.git
