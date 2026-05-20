#!/bin/bash
set -e

apt-get update -y

apt-get install -y docker.io docker-compose
apt-get install -y awscli

systemctl start docker
systemctl enable docker

usermod -aG docker ubuntu

