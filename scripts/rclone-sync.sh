#!/bin/bash

# Sync from google cloud first
rclone sync -P --drive-skip-gdocs schwartzit: /home/sam/schwartzit
echo "Sync from Google Drive complete."

while true
do
	# Once per minute copy changes to the cloud
	sleep 1m
	rclone sync -P --drive-skip-gdocs /home/sam/schwartzit schwartzit:
	echo "Sync to Google Drive complete."
done
