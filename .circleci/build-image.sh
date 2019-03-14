#!/bin/bash

export IMAGE_ID="$REGISTRY/$IMAGE:$VERSION-$TAG"
# ============
# <qemu-support>
if [ $GOARCH == 'amd64' ]; then
  touch qemu-amd64-static
else
  curl -sL "https://github.com/multiarch/qemu-user-static/releases/download/${QEMU_VERSION}/qemu-${QEMU_ARCH}-static.tar.gz" | tar xz
  docker run --rm --privileged multiarch/qemu-user-static:register
fi
# </qemu-support>
# ============

# Replace the repo's Dockerfile with our own.
cp -f $DIR/Dockerfile .
docker build -t $IMAGE_ID \
  --build-arg target=$TARGET \
  --build-arg goarch=$GOARCH .

# Login to Docker Hub.
echo $DOCKERHUB_PASS | docker login -u $DOCKERHUB_USER --password-stdin
# Push push push
docker push $IMAGE_ID
commit_hash=$(git rev-parse --short HEAD)
docker tag "$IMAGE_ID" "$REGISTRY/$IMAGE:$commit_hash-$TAG"
docker push "$REGISTRY/$IMAGE:$commit_hash-$TAG"
if [ $CIRCLE_BRANCH == 'master' ]; then
  docker tag "$IMAGE_ID" "$REGISTRY/$IMAGE:master-$TAG"
  docker push "$REGISTRY/$IMAGE:master-$TAG"
fi
