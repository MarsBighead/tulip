#!/bin/bash
PROJECT_DIR=$1
PROJECT_DIR=${PROJECT_DIR:=$(cd $(pwd)/$(dirname $0); pwd)}
echo "Project directory is $PROJECT_DIR ..."
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
	-v $PROJECT_DIR:/go/src/$PROJECT \
	--name build golang:$GOLANG \
	/bin/bash /go/src/$PROJECT/scripts/build_backend.sh $PROJECT $PLATFORM)

docker start $BUILD_CID
