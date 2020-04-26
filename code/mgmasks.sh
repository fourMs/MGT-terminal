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

for i in *.tiff;
do
name=`echo $i | cut -d'.' -f1`;
convert background.tiff $i -compose difference -composite -threshold 5% -blur 0x3 -threshold 20% -blur 0x3 "$name-mask.tiff"
convert $i "$name-mask.tiff" -compose multiply -flatten "$name-clean.jpg"
done
