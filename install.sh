#!/bin/bash
set -e

SCHOOL_BELL_WORKDIR=~/school-bell

echo "School-bell workdir: $SCHOOL_BELL_WORKDIR"
mkdir -p "$SCHOOL_BELL_WORKDIR"

echo "Installing ring script..."
sudo cp ring.sh /usr/bin/ring

echo "Installing ringtones..."

cp ./ringtones/school-bell-2-seconds.mp3 "$SCHOOL_BELL_WORKDIR"/.default-ringtone.mp3
cp -r ./ringtones "$SCHOOL_BELL_WORKDIR"
cp -r ./schedules "$SCHOOL_BELL_WORKDIR"
cp ./README.md "$SCHOOL_BELL_WORKDIR"
cp -r ./uninstall.sh "$SCHOOL_BELL_WORKDIR"/.uninstall.sh

echo "Installation has finished."
echo "Exit"
exit 0

