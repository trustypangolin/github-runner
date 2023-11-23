#!/bin/bash
### every exit != 0 fails the script
set -e

mkdir actions-runner
cd /actions-runner

arch=$(uname -m)
if [ "$arch" == x86_64* ]; then
    echo "X64 Architecture"
    curl -o /tmp/actions-runner-linux-x64-2.288.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.288.0/actions-runner-linux-x64-2.288.0.tar.gz
    tar xzf /tmp/actions-runner-linux-x64-2.288.0.tar.gz
elif [ "$arch" == arm64 ] || [ $arch = aarch64 ]; then
    echo "ARM Architecture"
    curl -o /tmp/actions-runner-linux-arm64-2.288.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.288.0/actions-runner-linux-arm64-2.288.0.tar.gz
    tar xzf /tmp/actions-runner-linux-arm64-2.288.0.tar.gz
fi
