#!/bin/bash
if [ -f .env ]; then
    echo ".env file found, sourcing it"
	set -o allexport
	source .env
	set +o allexport
fi

export PATH="$(cat PATH)"
if [[ -n $RCLONE_CONFIG && -n $RCLONE_DESTINATION ]]; then
	echo "Rclone config detected"
	echo -e "[DRIVE]\n$RCLONE_CONFIG" > rclone.conf
	echo "on-download-stop=./on-stop.sh" >> aria2c.conf
	echo "on-download-complete=./on-complete.sh" >> aria2c.conf
	chmod +x on-stop.sh
	chmod +x on-complete.sh
fi
#echo "$(cat aria2c.conf)"
echo "rpc-secret=$ARIA2C_SECRET" >> aria2c.conf
aria2c -q --conf-path=aria2c.conf&
npm start
