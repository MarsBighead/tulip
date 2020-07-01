#!/bin/bash

PROJECT_DIR=$(cd $(dirname $0);pwd)
printf "#####\n* Stage#1 Prepare database\n######\n\n"
cd $PROJECT_DIR/hg38
docker build -f Dockerfile -t hg38:1.0.1  .
cd  ..
printf "#####\n* Stage#2 Prepare application tulip\n######\n\n"
docker build -f Dockerfile -t tulip:0.2.1  .


printf "#####\n* Stage#3 Clean containers with docker-compose\n######\n\n"
docker-compose down


printf "#####\n* Stage#4 Start all services with docker-compose\n######\n\n"
docker-compose up -d

printf "#####\n* Stage#5 Load data to dtabase services\n######\n\n"
docker exec  -it mysql-1 /bin/bash /home/tulip/createDB.sh