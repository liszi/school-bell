#!/bin/bash
set -e

export XDG_RUNTIME_DIR="/run/user/1000"

SCHOOL_BELL_WORKDIR=~/school-bell
LOG_PATH=$SCHOOL_BELL_WORKDIR/log.txt
RINGTONE_FOLDER=$SCHOOL_BELL_WORKDIR/ringtones

DEFAULT_RINGTONE_PATH=$SCHOOL_BELL_WORKDIR/.default-ringtone.mp3

mkdir -p $RINGTONE_FOLDER

echo "School-bell ring at $(date)." >> $LOG_PATH

if [ "$#" -eq 0 ]; then
    SOUND_ARG="$DEFAULT_RINGTONE_PATH"
elif [ "$#" -eq 1 ]; then
    SOUND_ARG="$1"
else
    echo "  ERROR: Illegal number of parameters" >> $LOG_PATH
    echo "    Usage with default ringtone: ring" >> $LOG_PATH
    echo "    Usage with specified ringtone: ring ringtone.mp3" >> $LOG_PATH
    exit 1

fi


if [ -f "$SOUND_ARG" ]; then
    sound_file_path="$SOUND_ARG"
elif [ -f $RINGTONE_FOLDER"/$SOUND_ARG" ]; then
    sound_file_path=$RINGTONE_FOLDER"/$SOUND_ARG"
elif [ -f $DEFAULT_RINGTONE_PATH ]; then
    sound_file_path=$DEFAULT_RINGTONE_PATH
    echo "  WARNING: no sound file found at $SOUND_ARG or $RINGTONE_FOLDER/$SOUND_ARG. Falling back to default sound."  >> $LOG_PATH
else
    echo "  ERROR: no default sound file found at $DEFAULT_RINGTONE_PATH. Nothing to play."  >> $LOG_PATH
    exit 2
fi

echo "  Playing $sound_file_path." >> $LOG_PATH

mplayer "$sound_file_path" >> /dev/null 2>&1

echo "  Playing $sound_file_path has finished at $(date)."  >> $LOG_PATH


