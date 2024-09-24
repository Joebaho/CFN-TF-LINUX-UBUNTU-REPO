#!/bin/bash

# install kubectl
install_kubectl() {
    echo "Installing kubectl..."
    # Update and install dependencies
    sudo yum update -y
    sudo yum install -y curl jq

    # Download the latest version of kubectl
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    
    # Make kubectl executable and move it to /usr/local/bin
    chmod +x kubectl
    sudo mv kubectl /usr/local/bin/
    
    echo "kubectl installed successfully"
}
#install eksctl
install_eksctl() {
    echo "Installing eksctl..."
    # Download and extract the latest version of eksctl
    curl -s --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
    
    # Move eksctl to /usr/local/bin
    sudo mv /tmp/eksctl /usr/local/bin/
    
    echo "eksctl installed successfully"
}
# Run the installation functions
install_kubectl
install_eksctl
#install Docker
sudo yum update -y
sudo yum install python3-pip
sudo amazon-linux-extras install docker
sudo yum install -y docker
sudo service docker start
sudo systemctl enable docker
sudo systemctl restart docker
sudo usermod -aG docker ec2-user