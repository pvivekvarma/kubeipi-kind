#!/usr/bin/bash

USER=pi

docker build --rm --no-cache -t  kind-pi --build-arg USER=${USER} .
# docker build -t  kind-pi --build-arg USER=${USER} .
