#!/bin/bash
ROJECT_DIR=$1
ROJECT_DIR=${ROJECT_DIR:=$(pwd)/$(dirname $0)}
PROJECT=$2
PROJECT=${PROJECT:=tulip}
echo "Project $PROJECT's  directory is $PROJECT_DIR..."
PLATFORM=$3
PLATFORM=${PLATFORM:=linux}

echo "Build $PROJECT for platform $PLATFORM"
GOLANG=${GOLANG:=1.9.3}

#GOOS=$PLATFORM GOARCH=amd64 go build
if cid=$(docker ps -a|grep -o -E "build$"); then
    echo "Docker container $cid is removing...."
    docker rm -f $cid
fi
echo "Start build project $PROJECT"
BUILD_CID=$(docker create  -it \
	-v $APP_DIR:/go/src/$PROJECT \
	--name build golang:$GOLANG \
	/bin/bash /go/src/$PROJECT/scripts/build_backend.sh $PROJECT $PLATFORM)
docker start $BUILD_CID
