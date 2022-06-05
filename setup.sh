#!/bin/bash

# Install rclone static binary
wget -q https://github.com/Kwok1am/rclone-ac/releases/download/gclone/gclone.gz
gunzip gclone.gz
export PATH=$PWD:$PATH
chmod 777 /app/gclone

#Inject Rclone config
wget -q https://github.com/Kwok1am/rclone-ac/raw/main/accounts.rar
wget -q https://www.rarlab.com/rar/rarlinux-x64-5.9.0.tar.gz
tar xf rarlinux-x64-5.9.0.tar.gz
export PATH=$PWD/rar:$PATH
unrar -p"${SA_SECRET}" e accounts.rar /app/accounts/

# Install aria2c static binary
#wget -q https://github.com/q3aql/aria2-static-builds/releases/download/v1.35.0/aria2-1.35.0-linux-gnu-64bit-build1.tar.bz2
#tar xf aria2-1.35.0-linux-gnu-64bit-build1.tar.bz2
#export PATH=$PWD/aria2-1.35.0-linux-gnu-64bit-build1:$PATH

# Create download folder
mkdir -p downloads

# DHT
wget -q https://github.com/P3TERX/aria2.conf/raw/master/dht.dat
wget -q https://github.com/P3TERX/aria2.conf/raw/master/dht6.dat

# Tracker
tracker_list=$(wget -qO- https://trackerslist.com/all.txt |awk NF|sed ":a;N;s/\n/,/g;ta")
echo "bt-tracker=$tracker_list" >> aria2c.conf
