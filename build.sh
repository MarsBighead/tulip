#!/bin/bash


APP=$1
APP=${APP:=tulip}
echo "Build code in directory /go/src/$APP"
PLATFORM=$2
PLATFORM=${PLATFORM:=linux}
#cd /go/src/$APP
GOOS=$PLATFORM GOARCH=amd64 go build
