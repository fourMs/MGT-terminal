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
    echo "usage: ./mgtiles.sh IMAGENAME [INVERT] [WIDTH] [HEIGHT]"
    exit
fi

FILENAME=$1
NAMESTRING=`echo $FILENAME | cut -d'.' -f1`;

INVERT=$2
WIDTH=$3
HEIGHT=$4

if [ -z "$INVERT" ]; then
    INVERT="-negate"
fi
if [ -z "$WIDTH" ]; then
    WIDTH=1920
fi
if [ -z "$HEIGHT" ]; then
    HEIGHT=1080
fi

convert $FILENAME -crop ${WIDTH}x${HEIGHT} $INVERT +repage  +adjoin  ${NAMESTRING}_%02d.jpg
