#!/bin/bash

hg38_storage="hg38/"
sql="refGene.sql"
txt_gz="refGene.txt.gz"
hg38_base_url="http://hgdownload.soe.ucsc.edu/goldenPath/hg38/database"
wget -c  $hg38_base_url"/"$sql
wget -c  $hg38_base_url"/"$txt_gz
mv  $sql $hg38_storage
gunzip  $txt_gz 
mv refGene.txt $hg38_storage
