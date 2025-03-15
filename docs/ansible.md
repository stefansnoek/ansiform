# Ansible Documentation

## Overview
This document outlines how Ansible is used to configure and manage the Azure infrastructure. The primary use case for Ansible in this architecture is to configure the web server (Nginx) on the Azure Virtual Machine.

## Prerequisites
Before running Ansible, ensure you have the following:
- Ansible installed on your local machine
- Azure CLI configured and authenticated
- SSH access to the Azure Virtual Machine
- A properly defined Ansible inventory file

## Folder Structure
```sh
ansible/
├── inventory.ini
└── webserver.yml
```

## Inventory File (inventory.ini)
```sh
[webserver]
webserver-vm ansible_host=<VM_PUBLIC_IP> ansible_user=azureuser ansible_ssh_private_key_file=~/.ssh/id_rsa
```

## Ansible Playbooks
### Install Nginx
```sh
- name: Install and configure Nginx
  hosts: webserver
  become: yes
  tasks:
    - name: Update APT cache
      apt:
        update_cache: yes

    - name: Install Nginx
      apt:
        name: nginx
        state: present

    - name: Start Nginx
      systemd:
        name: nginx
        state: started
        enabled: yes
```

## Running Ansible
Execute the playbooks using:
```sh
ansible-playbook -i inventory.ini webserver.yml
```
