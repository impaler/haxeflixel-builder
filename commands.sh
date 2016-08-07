#!/bin/bash

# loosley based on code form http://ypereirareis.github.io/

NORMAL="\\033[0;39m"ø
RED="\\033[1;31m"
BLUE="\\033[1;34m"

CONTAINER_NAME='haxeflixel-docker-00'
IMAGE_NAME='haxeflixel-docker'

if [ -z "$*" ]; then
    echo "This script contains utilities for working with the haxeflixel-docker image."
    echo "You need to provide at least one command for this script:"
    echo "   > shell - Run the docker container and enter a bash shell."
    echo "   > run - Run the docker container $CONTAINER_NAME detached, and remove any previous one."
    echo "   > build-image - Build the docker image $IMAGE_NAME."
    echo "   > build-demos - Build the haxeflixel demos to a server folder in the cwd."
fi

log() {
  echo -e "$BLUE > $1 $NORMAL"
}

error() {
  echo ""
  echo -e "$RED >>> ERROR - $1$NORMAL"
}

build-image() {
  log "Building the Dockerfile to an image called $IMAGE_NAME"
  docker build -t $IMAGE_NAME . 
  
  [ $? != 0 ] && error "Failed to build docker image $IMAGE_NAME" && exit 100
}

build-demos() {
  log "Building demos with a new container"
  run
  
  docker exec $CONTAINER_NAME haxelib run flixel-tools bp html5 -server

  log "Built the demos now copying them to your cwd"

  docker cp $CONTAINER_NAME:/root/demos/server/ .
  
  log "Completed, check your cwd for a server folder"
}

shell() {
  log "Running image $IMAGE_NAME and entering a bash shell:"
  docker run -it --rm $IMAGE_NAME /bin/bash
}

run() {
  remove
  log "Starting docker $CONTAINER_NAME"

  CID=$(docker run -it --name="$CONTAINER_NAME" -d $IMAGE_NAME)
  log "container started $CID"

  [ $? != 0 ] && error "Failed to start docker $CONTAINER_NAME" && exit 105
}

remove() {
  log "Removing the container with name $CONTAINER_NAME" && \
      docker rm -f $CONTAINER_NAME &> /dev/null || true
}

stop() {
  log "Attempting to stop container with name $CONTAINER_NAME"
  docker stop $CONTAINER_NAME
  
   [ $? != 0 ] && error "Unable to stop the container with name $CONTAINER_NAME.\n \
   Make sure you have you have already ran the build and run commands." && exit 105
}
  
start() {
  log "Attempting to start container with name $CONTAINER_NAME"
  docker start $CONTAINER_NAME
  
  [ $? != 0 ] && error "Unable to start the container with name $CONTAINER_NAME.\n \
  Make sure you have you have already ran the build and run commands." && exit 105
  
  docker ps -aqf "name=$CONTAINER_NAME" 
}

# Allow bash to run functions with arguments
$*