#!/bin/bash
# ------------------------------------------------------------------
# Description:
#     Will resample the video. Useful to run before other functions.
#
# Usage:
#     Place in folder with video files
#     Make executable: chmod u+x [scriptname]
#     Run script: sh [scriptname]
#
# Dependency:
#      Uses FFmpeg
#
# Author:
#     Alexander Refsum Jensenius
#     University of Oslo
#
# Version:
#     0.2 - 2022-01-09
#     0.1 - 2020-03-01
# ------------------------------------------------------------------


if [ -z "$1" ]; then
    echo "usage: ./mgresample.sh VIDEO [FRAMES_TO_SKIP=4]"
    exit
fi

FILENAME=$1
NAMESTRING=`echo $FILENAME | cut -d'.' -f1`;

FRAMES=$2

ffmpeg -i $FILENAME -r 30 -filter:v "setpts=PTS/$FRAMES" -an ${NAMESTRING}_resample.mp4
