# docker-gnat-community

[![Docker Image](https://img.shields.io/docker/pulls/dgautherot/gnat-community.svg?maxAge=2592000)](https://hub.docker.com/r/dgautherot/gnat-community/)

## Prerequisites
Before attempting to build the docker images, one should have installed the following required tools and dependencies:
* docker-ce
* make

## Building locally the docker images
Just type the following command: ``` make images ```

## Publishing the docker image to docker hub
Just type the following command: ``` make push-to-github ```

## Using the docker image

Here is an example of a command (for the linux platform) to run the GPS IDE frrom the docker image:
```
docker run --rm --cap-add=SYS_PTRACE --security-opt seccomp=unconfined -u vscode -v /tmp/.X11-unix:/tmp/.X11-unix -v /etc/localtime:/etc/localtime -e DISPLAY=:0 -v $PWD:/home/dev -w /home/dev gnat-community:x86_64-linux.2019.1 sh -c "gps"
```
*Note: on linux platform, before executing the above command, user shall type the command ```xhost+```*
