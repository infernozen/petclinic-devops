#!/usr/bin/env bash

# update package
sudo apt update

# install git
sudo apt install git -y

# install ops-agent
curl -sSO https://dl.google.com/cloudagents/add-google-cloud-ops-agent-repo.sh
sudo bash add-google-cloud-ops-agent-repo.sh --also-install

#insall docker 
sudo apt install docker.io
sudo systemctl start docker
