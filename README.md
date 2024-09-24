# Description
This repository contains cloudformation templates, Terraform configuration files and bashscript codes that will launches an amazon Linux 2 and Ubuntu EC2 instance in a custom VPC. The files will include an IAM assume role attached to them
for SSM connect. And with the user data of each files will allow installation of Docker and Jenkins in ne server. It also install Eksctl and Kubectl on Ubuntu and Amazon linux 2 servers.

## Prerequisites
1. To install Jenkins on a server you must have minimum hardware requirements:

256 MB of RAM
1 GB of drive space (although 10 GB is a recommended minimum if running Jenkins as a Docker container)
Recommended hardware configuration for a small team:
4 GB+ of RAM
50 GB+ of drive space

2. To install Docker on server you must have minimum hardware requirements:

OS: 64-bit version of Ubuntu
RAM: At least 2 GB, but Docker recommends more for larger deployments or resource-intensive applications
Disk space: 100 GB of free space
CPU: Sufficient amount, depending on the applications
Kernel: 64-bit kernel with support for virtualization
Virtualization: Support for KVM virtualization technology
QEMU: Version 5.2 or later
Init system: systemd init system
Desktop environment: Gnome, KDE, or MATE
Firewall: Firewall rulesets created with iptables or iptables6, and added to the DOCKER-USER chai
   
## Requirements
1. Docker work  will be install on server if you at least Python3 is install.
2. Jenkins is written in Java. So for Jenkins to work you must have the latest version of Jenkins install
3. EKS to work you must install AWS CLi on the server. 
   
## CloudFormation

Linux-Docker-Jenkins.yml 
ubuntu-docker-jenkins.yml
Linux-eksctl-kubectl.yml
Ubuntu-eksctl-kubectl.yml

Open your account and go to CloudFormation. From there you can launch each stack.

## Bash Scripting
Linux_docker_jenkins.sh
Linux-eksctl-kubectl.sh
Ubuntu_docker_jenkins.sh
Ubuntu-eksctl-kubectl.sh

After the script written we have to save them on a file with extension .sh
Make the script executable by changing the modification with the command 
   ```
   chmod +x file_name.sh
   ```
Run the script with sudo privilege
   ```
   sudo ./file_name.sh
   ```

## Terraform

Linux-main.tf
ubuntu-main.tf
Linux-eksctl-kubectl.tf
Ubuntu-eksctl-kubectl.tf
Linux-main.tf
Ubuntu-main.tf

Put the each file in a folder then follow steps to run 

1. Initialise the folder
```
terraform init
```

2. Check the correct syntax of the file
```
terraform fmt
```

3. Valid the status of the file
```
terraform validate
```
4. Plan to see which resources will be create
```
terraform plan
```
5. Create the resources with command
```
terraform apply
```
## Checking

After each resouces create you can connect to the server via SSM connect and from there you  can type command to check if installation went well .

1. Docker

   Docker version
   ```
   docker --version
   ```
   Docker information
   ```
   docker info
   ```

2. Jenkins

   Jenkins version
   ```
   jenkins --version
   ```
   Java version
   ```
   java --version
   ```


With these files you are now capable to run quickly a server with Docker and Jenkins install directly inside. You can run them via CloudFormation or Terraform. You can also onnect directly via SSM 
connection or you can SSH to  the server. 

## Bash Scripting

### Jenkins and Docker Installation Scripts

This repository contains bash scripts to automate the installation of Jenkins and Docker on different Linux distributions.

## Scripts Overview

1. `Linux_docker_jenkins.sh`: Installs Jenkins and Docker on Amazon Linux 2
   
What it does:

Updates the system
Installs Java (required for Jenkins)
Installs Jenkins
Installs Docker
Starts and enables Jenkins and Docker services
Adds the current user to the Docker group

## Usage:

Run the folowwing command to make the file executable nd give permission to be execute

```bash
chmod +x Linux_docker_jenkins.sh
```
Then run this command to have application install

```bash
./Linux_docker_jenkins.sh
```

2. `ubuntu_docker_jenkins.sh`: Installs Jenkins and Docker on Ubuntu Server

What it does:

Updates the system
Installs Java (required for Jenkins)
Installs Jenkins
Installs Docker
Starts and enables Jenkins and Docker services
Adds the current user to the Docker group

## Usage 

Run the folowwing command to make the file executable nd give permission to be execute

```bash
chmod +x ubuntu_docker_jenkins.sh
```
Then run this command to have application install

```bash
./ubuntu_docker_jenkins.sh
```

After the installation completed you can use the command listed ion top to check the version of each open source installed. 




