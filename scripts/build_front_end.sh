#/bin/bash


CURRENT_DIR=$(pwd)
FILE_DIR=$CURRENT_DIR/$(dirname $0)
UI=$FILE_DIR/../static/ui
rm -rf $UI
mkdir -p $UI
FRONT_END_APP=$1
FRONT_END_APP=${FRONT_END_APP:=front-end-app}
echo "$FILE_DIR"
cd  $FILE_DIR/../$FRONT_END_APP
pwd
ng build
cd dist/$FRONT_END_APP
UI_PKG=static.tgz
tar -zcf $UI_PKG *
mv $UI_PKG $FILE_DIR/../static/ui
cd $UI
tar zxf $UI_PKG 
rm $UI_PKG