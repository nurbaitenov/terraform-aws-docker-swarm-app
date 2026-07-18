#!/bin/bash
set -eux

# Update system
dnf update -y

# Install required packages
dnf install -y \
    docker \
    git \
    curl \
    unzip \
    python3 \
    python3-pip

# -----------------------------
# Docker
# -----------------------------
systemctl enable docker
systemctl start docker
usermod -aG docker ec2-user

# Wait until Docker is ready
until docker info >/dev/null 2>&1; do
    sleep 2
done

# -----------------------------
# Terraform
# -----------------------------
dnf install -y dnf-plugins-core

dnf config-manager --add-repo \
https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo

dnf install -y terraform

# -----------------------------
# Ansible
# -----------------------------
dnf install -y ansible

ansible-galaxy collection install amazon.aws   # install aws collection
ansible-galaxy collection list                 # verity aws collection 

sudo yum install -y python3-boto3                    # install boto3
python3 -c "import boto3; print(boto3.__version__)"         # verify install boto3


# -----------------------------
# Verify installations
# -----------------------------
docker --version
terraform -version
ansible --version