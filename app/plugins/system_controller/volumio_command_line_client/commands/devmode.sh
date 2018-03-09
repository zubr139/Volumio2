#!/bin/bash

NODEMON_DIR=/volumio/node_modules/nodemon/
ETH_IP=`ip addr show eth0 | grep "inet" | awk '{print $2}' | awk -F "/" '{print $1}' | sed '2d' | tr -d '\n'`
PORT=9229

echo "Stopping Volumio service"
/usr/bin/sudo /bin/systemctl stop volumio


if [ ! -d "$NODEMON_DIR" ]; then
  echo "Installing nodemon"
  cd /volumio
  /bin/npm install nodemon
fi


echo 'Starting Volumio with debugger at' $ETH_IP:$PORT
cd /volumio
./node_modules/.bin/nodemon --inspect="$ETH_IP":"$PORT" index.js


