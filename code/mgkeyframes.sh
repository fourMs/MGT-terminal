#!/bin/bash
# ------------------------------------------------------------------
# Description:
#     Extracts keyframes from a video file and stores them as TIFF files
#     for further processing. This is useful for making history images, etc.
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
#     0.1 - 2020-03-01
# ------------------------------------------------------------------

if [ -z "$1" ]; then
    echo "usage: ./mgkeyframes.sh VIDEO"
    exit
fi

filename=$1
namestring=`echo $filename | cut -d'.' -f1`;
echo $namestring

ffmpeg -skip_frame nokey -i $filename -vsync 0 -r 30 -f image2 ${namestring}_%02d.tiff
