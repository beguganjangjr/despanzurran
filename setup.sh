#!/bin/bash

# Install rclone static binary
wget -q https://github.com/Kwok1am/rclone-ac/releases/download/gclone/gclone.gz
gunzip gclone.gz
export PATH=$PWD:$PATH
chmod 777 /app/gclone

#Inject Rclone config
curl -o accounts.zip "${SAURL}"
unzip -q accounts.zip
export PATH=$PWD:$PATH
chmod 777 /app/accounts

# Install aria2c static binary
wget -q https://github.com/P3TERX/Aria2-Pro-Core/releases/download/1.36.0_2021.08.22/aria2-1.36.0-static-linux-amd64.tar.gz
tar xf aria2-1.36.0-static-linux-amd64.tar.gz
rm aria2-1.36.0-static-linux-amd64.tar.gz
export PATH=$PWD:$PATH

# Create download folder
mkdir -p downloads

# DHT
wget -q https://github.com/P3TERX/aria2.conf/raw/master/dht.dat
wget -q https://github.com/P3TERX/aria2.conf/raw/master/dht6.dat

# Tracker
file="trackers.txt"
echo "$(curl -Ns https://newtrackon.com/api/stable)" > trackers.txt
echo "$(curl -Ns https://trackerslist.com/all.txt)" >> trackers.txt
sed -i '/^$/d' trackers.txt
sed -i ':a;N;s/\n/,/g;ta'  trackers.txt
tracker_list=$(cat trackers.txt)
if [ $file ] ; then
    rm -rf $file
fi
echo "adding trackers and set listen-port=$PORT,$XPORT"
echo "bt-tracker=$tracker_list" >> aria2c.conf
echo "listen-port=$PORT,$XPORT" >> aria2c.conf
#echo "dht-listen-port=$PORT,6881-6999" >> aria2c.conf

echo $PATH > PATH
