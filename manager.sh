#!/bin/bash
set -xe

dnf update -y
dnf install -y docker

systemctl enable docker
systemctl start docker

usermod -aG docker ec2-user

until docker info >/dev/null 2>&1; do
  sleep 2
done

PRIVATE_IP=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)
docker swarm init --advertise-addr "$PRIVATE_IP"