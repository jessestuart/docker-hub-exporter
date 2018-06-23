#!/bin/bash
echo 'export DIR=`pwd`' >> $BASH_ENV
echo 'export GITHUB_REPO=infinityworks/docker-hub-exporter' >> $BASH_ENV
echo 'export GOPATH=/root/go' >> $BASH_ENV
echo 'export GOROOT=/usr/local/go' >> $BASH_ENV
echo 'export IMAGE=docker-hub-exporter' >> $BASH_ENV
echo 'export REGISTRY=jessestuart' >> $BASH_ENV
echo 'export QEMU_VERSION=v2.12.0' >> $BASH_ENV
echo 'export VERSION=latest' >> $BASH_ENV
echo 'export IMAGE_ID="${REGISTRY}/${IMAGE}:${VERSION}-${TAG}"' >> $BASH_ENV

source $BASH_ENV
