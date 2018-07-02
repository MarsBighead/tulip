#!/bin/bash

CURRENT_DIR=$(cd $(pwd)/$(dirname $0);pwd)
echo "Exec script load_data.sh directory is $CURRENT_DIR."
cd $CURRENT_DIR

USER="root"
TABLE="refGene"
MYSQL_ROOT_PASSWORD=$1
MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD:=togerme}
MYSQL_DATABASE=$2
MYSQL_DATABASE=${MYSQL_DATABASE:=hg38}
ls $FILE_DIR/../hg38
HG38=$(cd $FILE_DIR/../hg38; pwd)
echo $HG38
CREATE_TABLE_SQL=`cat $HG38/refGene.sql`
# echo $CREATE_TABLE_SQL
echo "user:pass | $USER:$MYSQL_ROOT_PASSWORD" 

#DROP DATABASE  IF  EXISTS `$DB`;
mysql  -u $USER -p$MYSQL_ROOT_PASSWORD  <<EOF 2> /dev/null 
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
EOF


mysql  -u $USER -p$MYSQL_ROOT_PASSWORD  --database hg38<<EOF 2> /dev/null 
$CREATE_TABLE_SQL
EOF
refGene_DATA_FILE=$HG38/refGene.txt
LOAD_refGene_DATA="LOAD DATA  LOCAL INFILE '$refGene_DATA_FILE' IGNORE INTO TABLE $MYSQL_DATABASE.$TABLE LINES TERMINATED by '\n'"
mysql  -u $USER -p$MYSQL_ROOT_PASSWORD  <<EOF 2> /dev/null 
$LOAD_refGene_DATA
EOF
echo "Load data successfully!"
#echo $load_sql
