#!/bin/bash
# ------------------------------------------------------------------
# Description:
#     This script compresses a number of video files into three formats:
#     AVI file with MJPEG compression and uncompressed audio
#     WAV file with uncompressed audio
#     MP4 file with high quality compression
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
  ffmpeg -i "$i" -c:v mjpeg -q:v 3 -acodec pcm_s16le -ar 44100 "${name}_conv.avi";
  ffmpeg -i "$i" -acodec pcm_s16le "${name}_conv.wav";
  ffmpeg -i "$i" -c:v libx264 "${name}_conv.mp4";
done
