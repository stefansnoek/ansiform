# **Automated Multi-Tier Web Application Deployment on Azure**

## Overview
This project automates the deployment of a **multi-tier web application** on **Azure** using:
- **Terraform** for Infrastructure as Code (IaC)
- **Ansible** for configuration management
- **Azure Services** for hosting the web application, the storage and the database

## Architecture
1. **Virtual Network & Subnet** - for secure communication.
2. **Virtual Machine (VM)** - hosts the web server.
3. **MySQL Database** - managed service on Azure.
4. **Azure Storage** - for static file storage.

## Prerequisites
Ensure you have the following installed:
- [Terraform](https://developer.hashicorp.com/terraform/downloads)
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
- SSH Key (`~/.ssh/id_rsa` and `~/.ssh/id_rsa.pub`)
