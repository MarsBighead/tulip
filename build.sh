#!/bin/bash


APP=$1
APP=${APP:=tulip}
echo "Build code in directory /go/src/$APP"
PLATFORM=$2
PLATFORM=${PLATFORM:=linux}
APP_DIR=$(pwd)/$(dirname $0)
echo "Local file directory "$APP_DIR
GOLANG=${GOLANG:=1.9.3}
#cd /go/src/$APP
#GOOS=$PLATFORM GOARCH=amd64 go build
if cid=$(docker ps -a|grep -o -E "build$"); then
    echo "Docker container $cid is removing...."
    docker rm -f $cid
fi
BUILD_CID=$(docker create  -it \
	-v $APP_DIR:/go/src/$APP \
	--name build golang:$GOLANG \
	/bin/bash /go/src/$APP/scripts/build_backend.sh $APP $PLATFORM)

docker start $BUILD_CID
exit

