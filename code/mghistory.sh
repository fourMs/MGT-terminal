#!/bin/bash
# ------------------------------------------------------------------
# Description:
#     Will add all tiff files in folder into one combined image
#
# Usage:
#     Place in folder with video files
#     Make executable: chmod u+x [scriptname]
#     Run script: sh [scriptname]
#
# Dependency:
#      Uses ImageMagick
#
# Author:
#     Alexander Refsum Jensenius
#     University of Oslo
#
# Version:
#     0.1 - 2020-03-01
# ------------------------------------------------------------------


if [ -z "$1" ]; then
    echo "usage: ./mghistory.sh VIDEO [FRAMES=30]"
    exit
fi

FILENAME=$1
NAMESTRING=`echo $FILENAME | cut -d'.' -f1`;

FRAMES=$2

ffmpeg -i $FILENAME -filter:v tmix=frames=30:weights="10 1 1" ${NAMESTRING}_history.mp4
