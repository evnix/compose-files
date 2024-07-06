#!/bin/bash

# Store the version number in a variable
FOLDER="php83"
IMAGE_NAME="php83"

# Read the version from a file in the specified folder
VERSION_FILE="$FOLDER/version.txt"
if [ ! -f "$VERSION_FILE" ]; then
    echo "0" > $VERSION_FILE 
fi

VERSION=$(cat "$VERSION_FILE")

# Increment the version number
NEW_VERSION=$((VERSION + 1))

# Update the version file
echo "$NEW_VERSION" > "$VERSION_FILE"

TAG="php8.3-alpine-$VERSION"

# Build the Docker image
docker build --progress=plain -t ghcr.io/evnix/$IMAGE_NAME:$TAG $FOLDER

# Get the image ID of the newly built image
IMAGE_ID=$(docker images -q ghcr.io/evnix/$IMAGE_NAME:$TAG)

# Tag and push the main image
docker tag $IMAGE_ID ghcr.io/evnix/$IMAGE_NAME:$TAG
docker push ghcr.io/evnix/$IMAGE_NAME:$TAG

# Tag and push the Laravel variant
docker tag $IMAGE_ID ghcr.io/evnix/$IMAGE_NAME:$TAG-laravel
docker push ghcr.io/evnix/$IMAGE_NAME:$TAG-laravel

# Tag and push the WordPress variant
docker tag $IMAGE_ID ghcr.io/evnix/$IMAGE_NAME:$TAG-wordpress
docker push ghcr.io/evnix/$IMAGE_NAME:$TAG-wordpress