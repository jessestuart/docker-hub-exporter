#!/bin/sh

echo "Building repo: $GITHUB_REPO"
echo "Version: $VERSION"
echo "Architecture: $GOARCH"

mkdir -p $GOPATH/src/github.com/${IMAGE}
git clone https://github.com/${GITHUB_REPO} --depth=1 $GOPATH/src/github.com/${GITHUB_REPO} &>/dev/null
cd $GOPATH/src/github.com/${GITHUB_REPO}
