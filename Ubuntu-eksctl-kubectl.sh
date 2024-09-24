#!/bin/bash

#Install kubectl
install_kubectl() {
    echo "Installing kubectl..."
    # Update the system and install dependencies
    sudo apt-get update -y
    sudo apt-get install -y apt-transport-https ca-certificates curl

    # Download the Google Cloud public signing key
    sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg

    # Add the Kubernetes APT repository
    echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

    # Update the package list and install kubectl
    sudo apt-get update
    sudo apt-get install -y kubectl
    
    echo "kubectl installed successfully"
}
#install eksctl
install_eksctl() {
    echo "Installing eksctl..."
    # Download and extract eksctl
    curl -s --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp

    # Move eksctl to /usr/local/bin
    sudo mv /tmp/eksctl /usr/local/bin/
    
    echo "eksctl installed successfully"
}
# Run the installation functions
install_kubectl
install_eksctl
#install Docker
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
   $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
   sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl start docker.service
sudo systemctl enable docker.service
sudo usermod -aG docker ubuntu