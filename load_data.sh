#!/bin/bash

USER="root"
PWD=$MYSQL_ROOT_PASSWORD
echo $PWD
#PWD="12345678"
DB=$MYSQL_DATABASE
TABLE="refGene"
ls /tulip/hg38
create_table=`cat /tulip/hg38/refGene.sql`
echo $USER" pwd "$PWD 

#DROP DATABASE  IF  EXISTS `$DB`;
mysql  -u $USER -p$PWD  <<EOF 2> /dev/null 
CREATE DATABASE IF NOT EXISTS $DB;
EOF

mysql  -u $USER -p$PWD  $DB <<EOF 2> /dev/null
$create_table
EOF

data_file="/tulip/hg38/refGene.txt"
load_sql="LOAD DATA  LOCAL INFILE '$data_file' IGNORE INTO TABLE $DB.$TABLE LINES TERMINATED by '\n'"
mysql -u $USER -p$PWD  $DB <<EOF 2> /dev/null
$load_sql
EOF
echo "Load data successfully!"
#echo $load_sql
