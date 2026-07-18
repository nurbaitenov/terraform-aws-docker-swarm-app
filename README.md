# Docker Swarm on AWS with Terraform & Ansible

## Overview

This project automates the deployment of a Docker Swarm cluster on AWS using **Terraform** for infrastructure provisioning and **Ansible** for server configuration. The goal is to create a production-style, reproducible environment where a Docker Swarm cluster is configured automatically and ready for application deployment.

## Project Goal

- Provision AWS infrastructure automatically.
- Configure Docker on all EC2 instances.
- Initialize a Docker Swarm manager.
- Automatically join worker nodes to the cluster.
- Prepare the environment for deploying containerized applications.


## What Has Been Achieved

- Automated AWS infrastructure provisioning.
- Automated Docker installation and configuration.
- Automated Docker Swarm initialization.
- Automated worker node joining using AWS Systems Manager Parameter Store.
- Prepared the cluster for Docker Stack deployment.

## Technologies Used

| Technology | Purpose |
|------------|---------|
| **Terraform** | Infrastructure as Code (VPC, EC2, IAM, Auto Scaling Group, SSM Parameter Store) |
| **Ansible** | Server configuration and Docker Swarm automation |
| **Docker Swarm** | Container orchestration across multiple EC2 instances |
| **AWS EC2** | Hosts manager and worker nodes |
| **AWS Systems Manager Parameter Store** | Securely stores the manager IP and worker join token |

## Current Workflow

```text
Terraform
    ↓
Provision AWS Infrastructure
    ↓
Ansible
    ↓
Install & Configure Docker
    ↓
Initialize Docker Swarm
    ↓
Store Manager IP & Join Token in SSM
    ↓
Workers Join Automatically
    ↓
Ready to Deploy Applications
```


# Run
```
terraform init
terraform apply --var-file dev.tfvars

ansible-inventory -i aws_ec2.yml --graph
ansible-playbook -i aws_ec2.yml playbook.yml
```