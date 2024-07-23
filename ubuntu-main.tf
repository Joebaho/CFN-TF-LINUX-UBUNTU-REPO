# Terraform required providers definition..
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
#Configure the AWS Provider
provider "aws" {
  region = var.aws_region
}
variable "aws_region" {
  type        = string
  description = "region where to launch"
  default = "us-west-2"
}
variable "instance_type" {
  type        = string
  description = "instance type of the instance"
  default = "ansible-key"
}

variable "key_name" {
  type        = string
  description = "rkey name of the instance"
  default = "t2.micro"
}

#Data source for latest Amazon Linux 2 AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}
data "aws_vpc" "custom_vpc" {
  filter {
    name   = "tag:Name"
    values = ["c@licost-vpc"] # Replace with your VPC's name tag
  }
}
data "aws_subnet" "custom_subnet" {
  vpc_id = data.aws_vpc.custom_vpc.id

  filter {
    name   = "tag:Name"
    values = ["c@licost-subnet-public2-us-west-2b"] # Replace with your subnet's name tag
  }
}

# IAM Role
resource "aws_iam_role" "ec2_ssm_role" {
  name = "Ec2RoleForSSM"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ssm_policy_attachment" {
  role       = aws_iam_role.ec2_ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "Ec2RoleForSSM"
  role = aws_iam_role.ec2_ssm_role.name
}

# Security Group
resource "aws_security_group" "web_server_sg" {
  name        = "WebServerSecurityGroup"
  description = "Enable HTTP access via port 80 SSH access"
  vpc_id      = data.aws_vpc.custom_vpc.id

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance
resource "aws_instance" "web_server" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = data.aws_subnet.custom_subnet.id
  vpc_security_group_ids      = [aws_security_group.web_server_sg.id]
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name
  associate_public_ip_address = "true"

  user_data = base64encode(<<-EOF
    #!/bin/bash
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
    sudo apt-get update -y
    sudo apt-get install openjdk-17-jdk -y
    sudo curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee   /usr/share/keyrings/jenkins-keyring.asc > /dev/null
    sudo echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]   https://pkg.jenkins.io/debian-stable binary/ | sudo tee   /etc/apt/sources.list.d/jenkins.list > /dev/null
    sudo apt-get update  
    sudo apt-get install jenkins -y
    sudo systemctl start jenkins
    sudo systemctl enable jenkins
    sudo usermod -aG jenkins ubuntu
    sudo ufw allow 8080
    sudo ufw allow OpenSSH
    sudo ufw enable
  EOF
  )

  tags = {
    Name = "Ubuntu-Docker-jenkins-server"
  }
}
output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.web_server.id
}

output "public_dns" {
  description = "Public DNS name of the EC2 instance"
  value       = aws_instance.web_server.public_dns
}

output "public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.web_server.public_ip
}