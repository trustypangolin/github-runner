#!/bin/bash
### every exit != 0 fails the script
set -e

mycode=$(echo $RANDOM)
./config.sh --unattended \
            --url https://github.com/${gitorg} \
            --name ghr{$mycode} \
            --token $(curl -s -X POST -H "Accept: application/vnd.github.v3+json" -H "authorization:token ${githubtoken}" https://api.github.com/orgs/${gitorg}/actions/runners/registration-token | jq -r .token)
