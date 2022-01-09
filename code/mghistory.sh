#!/bin/bash
# ------------------------------------------------------------------
# Description:
#     Create motion history (aka "blurring") from a video file.
#     Number of frames to include in the history can be specified.
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
    echo "usage: ./mghistory.sh VIDEO [FRAMES=10]"
    exit
fi

FILENAME=$1
NAMESTRING=`echo $FILENAME | cut -d'.' -f1`;

FRAMES=$2

if [ -z "$FRAMES" ]; then
    FRAMES=10
fi

# Creating weight sequence so that the first frames (the last in the sequence)
# get heigher weights and are more visible
WEIGHTS=`seq $FRAMES`

ffmpeg -i $FILENAME -filter:v tmix=frames=${FRAMES}:weights="${WEIGHTS}" ${NAMESTRING}_history.mp4
