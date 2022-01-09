#!/bin/bash
# ------------------------------------------------------------------
# Description:
#     Will create horizontal and vertical videograms of video
#
# Usage:
#     Place in folder with video files
#     Make executable: chmod u+x [scriptname]
#     Run script: sh [scriptname]
#
# Dependency:
#     Using FFmpeg
#
# Author:
#     Alexander Refsum Jensenius
#     University of Oslo
#
# Version:
#     0.1 - 2022-01-09
# ------------------------------------------------------------------

FILENAME=$1
# get video name without the path and extension
NAMESTRING=`basename $FILENAME`
OUT_DIR=`pwd`

echo "Reading file: $FILENAME"

HEIGHT=`ffmpeg -i $FILENAME 2>&1 | grep Video: | grep -Po '\d{3,5}x\d{3,5}' | cut -d'x' -f2`
WIDTH=`ffmpeg -i $FILENAME 2>&1 | grep Video: | grep -Po '\d{3,5}x\d{3,5}' | cut -d'x' -f1`
FRAMES=`ffmpeg -i $FILENAME -map 0:v:0 -c copy -f null -y /dev/null 2>&1 | grep -Eo 'frame= *[0-9]+ *' | grep -Eo '[0-9]+' | tail -1`
#The below frame counting is faster than the one above but does not work for
#all file types
#FRAMES=`ffprobe -select_streams v -show_streams $FILENAME 2>/dev/null | grep nb_frames | sed -e 's/nb_frames=//'`

echo "File info: $WIDTH x $HEIGHT - $FRAMES frames"

echo "Rendering horizontal videogram..."
ffmpeg -y -i $FILENAME -frames 1 -vf scale=1:${HEIGHT}:sws_flags=area,normalize,tile=${FRAMES}x1 -aspect ${FRAMES}:${HEIGHT} ${NAMESTRING%.*}_horizontal.jpg

echo "Rendering vertical videogram..."
ffmpeg -y -i $FILENAME -vf scale=${WIDTH}:1:sws_flags=area,normalize,tile=1x${FRAMES} -aspect ${WIDTH}:${FRAMES} -frames 1 ${NAMESTRING%.*}_vertical.jpg
