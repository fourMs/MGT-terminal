#!/bin/bash
# ------------------------------------------------------------------
# Description:
#     This script rotates and compresses a number of video files.
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


for i in *.avi;
do
  name=`echo $i | cut -d'.' -f1`;
  ffmpeg -i "$i" -vf "transpose=2" -c:v mjpeg -q:v 3 -c:a pcm_s16le -ar 44100 "${name}_conv.avi";
  ffmpeg -i "$i" -vf "transpose=2" -c:v libx264 "${name}_conv.mp4";
done
