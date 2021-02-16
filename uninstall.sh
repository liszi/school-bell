#!/bin/bash

SCHOOL_BELL_WORKDIR=~/school-bell

echo "Removing ring script..."
sudo rm /usr/bin/ring

echo "Removing bell schedules..."
crontab -r

echo "Uninstall process has been finished."

echo "School-bell workdir has not been deleted: $SCHOOL_BELL_WORKDIR. Delete it manually if you want."
echo "Exit"
exit 0

