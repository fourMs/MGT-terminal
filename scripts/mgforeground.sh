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

convert *.tiff -background white -compose darken -flatten foreground.jpg
