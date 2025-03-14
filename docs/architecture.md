This project uses Terraform and Ansible to host a web application on Microsoft Azure.

Overview of the architecture:
- **Azure Resource Group:** Groups all the resources
- **Azure Virtual Network & Subnet:** Network for the Virtual Machine
- **Azure VM:** Runs Nginx as web server
- **Azure MySQL Database:** Managed database for storage
- **Azure Storage Account:** Storage for static files

Network configuration:
- **Port 22 (SSH):** Open for Ansible management
- **Port 80 (HTTP):** Open for access to the web server
- **Virtual Network:** 10.0.0.0/16
- **Subnet IP-range:** 10.0.1.0/24
