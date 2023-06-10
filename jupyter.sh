#!/bin/bash

CONTAINER_NAME='jupyter-pytorch'
PASSWORD='passwd'
PORT='8888'
VOLUME='jupyter-volume'

DIR_PATH=$(dirname $0)
cd $DIR_PATH

docker rm "$CONTAINER_NAME" --force > /dev/null

docker build -t richteaman/pytorch-notebook .

docker run --rm -d  \
    -p "$PORT":8888  \
    -e JUPYTER_TOKEN="$PASSWORD" \
	-v "$(pwd)"/"$VOLUME":/app/host \
	--name "$CONTAINER_NAME" \
    richteaman/pytorch-notebook:latest

echo "Jupyter running at http://localhost:$PORT. Password is $PASSWORD"
