#!/bin/bash
### every exit != 0 fails the script
set -e

curl -fsSL https://apt.releases.hashicorp.com/gpg       | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

arch=$(uname -m)
if [ "$arch" == x86_64* ]; then
    echo "X64 Architecture"
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" > /etc/apt/sources.list.d/hashicorp.list
    apt-get -yq update
    apt-get -yq install terraform packer
elif  [ "$arch" == arm* ] || [ "$arch" = aarch64 ]; then
    echo "ARM Architecture"
    echo "deb [arch=arm64 signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" > /etc/apt/sources.list.d/hashicorp.list
    curl https://releases.hashicorp.com/terraform/1.1.6/terraform_1.1.6_linux_arm64.zip -o /tmp/terraform.zip
    unzip -q /tmp/terraform.zip -d /bin
    apt-get -yq update
    apt-get -yq install packer
fi
