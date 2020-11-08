#!/usr/bin/bash

REGISTRY=ghcr.io
NAMESPACE=playwithansible
PWA_VERSION=0.2.4

versions="2.7.18 2.8.16 2.9.14 2.10.0"
for version in $versions
do
    docker build --build-arg ansible_version=${version} -t ${REGISTRY}/${NAMESPACE}/ansible-${version}:${PWA_VERSION} ansible
done