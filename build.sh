#!/usr/bin/env bash

docker buildx build --platform linux/amd64 -t papina/bitbucket-runner:latest -f Dockerfile-bitbucket . --push
docker buildx build --platform linux/amd64,linux/arm64 -t papina/github-runner:latest -f Dockerfile-github . --push
docker buildx build --platform linux/amd64,linux/arm64 -t papina/gitlab-runner:latest -f Dockerfile-gitlab . --push
