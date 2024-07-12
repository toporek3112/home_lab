#!/bin/bash

# Update package list and install Vim
apt update && apt install -y vim curl unzip

# Download and install Terraform
TERRAFORM_VERSION="1.5.3"
curl -O https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip
mv terraform /usr/local/bin/

# Cleanup
rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# Verify installation
terraform --version

echo "Vim and Terraform have been installed successfully."

