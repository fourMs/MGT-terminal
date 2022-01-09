#!/bin/bash
# ------------------------------------------------------------------
# Description:
#     Will create a motion video
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
    echo "usage: ./mghistory.sh VIDEO [INVERT]"
    exit
fi

FILENAME=$1
NAMESTRING=`echo $FILENAME | cut -d'.' -f1`;

FRAMES=$2

#ffmpeg -i $FILENAME -filter_complex "tblend=all_mode=difference" -an ${NAMESTRING}_motion.mp4

# The above function ends up with a green background. It turns out that it is necessary to convert from YUV to RGB as the first part of the filter chain:

ffmpeg -i $FILENAME -filter_complex "format=gbrp,tblend=all_mode=difference"  ${NAMESTRING}_motion.mp4
