#!/bin/bash

sleep 10
CURRENT_DIR=$(cd $(dirname $0);pwd)
echo "Exec script load_data.sh directory is $CURRENT_DIR."
cd $CURRENT_DIR
USER="root"
TABLE="refGene"
MYSQL_ROOT_PASSWORD=$1
MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD:=togerme}
MYSQL_DATABASE=$2
MYSQL_DATABASE=${MYSQL_DATABASE:=hg38}
ls $CURRENT_DIR
CREATE_TABLE_SQL=`cat ${CURRENT_DIR}/refGene.sql`
# echo $CREATE_TABLE_SQL
echo "user:pass | $USER:$MYSQL_ROOT_PASSWORD" 

mysql  -u $USER -p$MYSQL_ROOT_PASSWORD  --database hg38<<EOF 2> /dev/null 
$CREATE_TABLE_SQL
EOF
refGene_DATA_FILE=$CURRENT_DIR/refGene.txt

LOAD_refGene_DATA="LOAD DATA  LOCAL INFILE '$refGene_DATA_FILE' IGNORE INTO TABLE $MYSQL_DATABASE.$TABLE LINES TERMINATED by '\n'"
echo $LOAD_refGene_DATAs
mysql  -u $USER -p$MYSQL_ROOT_PASSWORD  <<EOF 
$LOAD_refGene_DATA
EOF
if  [[ $? ==  "0" ]];then
   echo "Load data successfully!"
fi
#echo $load_sql
