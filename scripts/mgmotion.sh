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
    echo "usage: ./mghistory.sh VIDEO [INVERT]"
    exit
fi

FILENAME=$1
NAMESTRING=`echo $FILENAME | cut -d'.' -f1`;

FRAMES=$2

ffmpeg -i $FILENAME tblend=c0_mode=difference -an ${NAMESTRING}_motion.mp4
