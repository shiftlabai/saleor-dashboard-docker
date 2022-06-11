#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

SALEOR_VERSION=${1:-3.0}
IMAGE_NAME=saleor-dashboard
echo "Building $IMAGE_NAME:$SALEOR_VERSION"

pushd saleor-dashboard
git checkout "$SALEOR_VERSION"
popd

docker build -t "$IMAGE_NAME:$SALEOR_VERSION" .
