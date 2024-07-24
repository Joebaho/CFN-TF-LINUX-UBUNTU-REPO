#!/bin/bash
# install Jenkins
sudo yum update -y
sudo sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum upgrade
sudo yum install java-17-amazon-corretto -y
sudo yum install jenkins -y
sudo systemctl start jenkins
sudo systemctl enable jenkins
sudo systemctl restart jenkins
sudo usermod -aG jenkins ec2-user
#install Docker
sudo yum update -y
sudo yum install python3-pip
sudo amazon-linux-extras install docker
sudo yum install -y docker
sudo service docker start
sudo systemctl enable docker
sudo systemctl restart docker
sudo usermod -aG docker ec2-user