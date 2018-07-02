#!/bin/bash

PROJECT_DIR=$(cd $(pwd)/$(dirname $0);pwd)
PROJECT=tulip
export MYSQL_ROOT_PASSWORD=togerme
export MYSQL_DATABASE=hg38
echo "Project $PROJECT's directory is $PROJECT_DIR"

if cid=$(docker ps -a|grep -o -E "gene_db$"); then
    echo "Docker container $cid is removing...."
    docker rm -vf $cid
fi
GENE_DB=$(docker create -it \
    -v $PROJECT_DIR/hg38:/hg38   \
	-e MYSQL_DATABASE=$MYSQL_DATABASE \
	-e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD \
    --name gene_db mysql:5.7 
)
docker start $GENE_DB
docker cp $PROJECT_DIR/scripts/load_data.sh gene_db:/home/load_data.sh
echo "Create database contaioner $GENE_DB successfully."

echo "Start build project $PROJECT"
sh $PROJECT_DIR/build.sh 
echo "End build project $PROJECT"
echo "Wait 10 seconds before load data to prepare MySQL env"
sleep 10
docker exec -it $GENE_DB /bin/bash /home/load_data.sh $MYSQL_ROOT_PASSWORD $MYSQL_DATABASE 

if cid=$(docker ps -a|grep -o -E "tulip$"); then
    echo "Docker container $cid is removing...."
    docker rm -vf $cid
fi
TULIP_RUN_CID=$(docker create -it \
	-p 8010:8010 \
	-v $PROJECT_DIR:/service \
    --link gene_db:gene_db \
    --name tulip ubuntu:16.04 \
	/bin/bash)

docker start $TULIP_RUN_CID
