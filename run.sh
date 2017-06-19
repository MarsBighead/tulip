#!/bin/bash
TULIP=$HOME/go/src/tulip
docker rm -vf gene_db
MYSQL_LVM=$TULIP/var/lib/mysql
GENE_DB=$(docker create -it \
    -v $MYSQL_LVM:/var/lib/mysql   \
    -v $TULIP:/tulip \
	-e MYSQL_DATABASE=hg \
	-e MYSQL_ROOT_PASSWORD=example \
    --name gene_db mysql:5.7 
)
docker start $GENE_DB

docker rm -vf tulip 
TULIP_RUN_CID=$(docker create -it \
	-p 8002:8002 \
	-v $TULIP:/service \
    --link gene_db:gene_db \
    --name tulip ubuntu:16.04 \
	/bin/bash)

docker start $TULIP_RUN_CID


docker exec -it gene_db /bin/bash /tulip/load_data.sh
#docker create -it  \
#	-p 8050:80 \
#-v /Users/paul.duan/application/elk:/service  \
#-v /Users/paul.duan/application/data:/data  \
#--name ubuntu-local ubuntu:16.04 /bin/bash 
