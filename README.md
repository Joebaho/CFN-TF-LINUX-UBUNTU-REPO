# Description
This repository contains cloudformation templates and Terraform configuration files that will launches an amazon Linux 2 and Ubuntu EC2 instance in a custom VPC. The files will include an IAM assume role attached to them
for SSM connect. And with the user data of each files will allow installation of Docker and Jenkins.

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
2. Jenkins is written in Java. So for Jenins to work you must have the latest version of Jenkins install
   
## CloudFormation
Linux-Docker-Jenkins.yml 
ubuntu-docker-jenkins.yml

Open your account and go to CloudFormation. From there you can launch each stack.

## Terraform
Linux-main.tf
ubuntu-main.tf

Put the file in a folder then follow steps to run 

1. Initialise the folder
```
terraform init
```

2. Check the correct syntax ofthe file
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

