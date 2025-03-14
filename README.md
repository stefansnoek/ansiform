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

## Deployment Steps
### 1. **Clone the Repository**
   ```sh
   git clone https://github.com/stefansnoek/ansiform.git
   cd ansiform
   ```
### 2. **Configure Azure Authentication**

   Login to Azure:
   ```sh
   az login
   ```
### 3. **Deploy Infrastructure with Terraform**
   ```sh
   cd terraform
   terraform init
   terraform apply
   ```
   This will create the required Azure resources, including the **VM, database, and storage account.**
### 4. **Configure the Web Server with Ansible**

   Once Terraform completes, Ansible will configure the web server
   ```sh
   cd ../ansible
   ansible-playbook -i inventory.ini playbook.yml
   ```
### 5. **Access the Web Application**

   After deployment, you can access the web server via:
   ```sh
   http://<your-public-ip>
   ```
   Find your public IP using:
   ```sh
   terraform output public_ip
   ```

## Additional Documentation
- Terraform Guide
- Ansible Guide

For detailed setup, see the ```/docs/``` folder.
