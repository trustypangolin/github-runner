#!/bin/bash
### every exit != 0 fails the script
set -e

arch=$(uname -m)
if [ "$arch" == x86_64* ]; then
    echo "X64 Architecture"
    curl https://s3.ap-southeast-2.amazonaws.com/amazon-ssm-ap-southeast-2/latest/debian_amd64/amazon-ssm-agent.deb -o /tmp/amazon-ssm-agent.deb
    dpkg -i /tmp/amazon-ssm-agent.deb
    # service amazon-ssm-agent stop

elif [ "$arch" == arm* ] || [ $arch = aarch64 ]; then
    echo "ARM Architecture"
    curl https://s3.ap-southeast-2.amazonaws.com/amazon-ssm-ap-southeast-2/latest/debian_arm64/amazon-ssm-agent.deb -o /tmp/amazon-ssm-agent.deb
    dpkg -i /tmp/amazon-ssm-agent.deb
    # service amazon-ssm-agent stop

fi