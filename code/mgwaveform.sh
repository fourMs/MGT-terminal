#!/bin/bash
# ------------------------------------------------------------------
# Description:
#     Will create a waveform of the audio from a video file
#
# Usage:
#     Place in folder with video files
#     Make executable: chmod u+x [scriptname]
#     Run script: sh [scriptname]
#
# Dependency:
#
# Author:
#     Alexander Refsum Jensenius
#     University of Oslo
#
# Version:
#     0.1 - 2020-03-19
# ------------------------------------------------------------------


if [ -z "$1" ]; then
    echo "usage: ./mghistory.sh VIDEO [WIDTH=1920]"
    exit
fi

FILENAME=$1
NAMESTRING=`echo $FILENAME | cut -d'.' -f1`;

FRAMES=$2

ffmpeg -i $FILENAME -filter_complex "showwavespic=s=1920x480" -frames:v 1  ${NAMESTRING}_waveform.png
