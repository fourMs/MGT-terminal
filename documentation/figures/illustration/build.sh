#!/bin/bash

fn=mgt-terminal-illustration.odg
namestring=`echo $fn | cut -d'.' -f1`;
echo $namestring

# This trick is used to export the LibreOffice document as PDF
libreoffice --headless --convert-to pdf $fn

# Since the exported PDF has a lot of whitespace, we remove that before proceeding
pdfcrop ${namestring}.pdf

# Then we move on to convert to lower-resolution JPEG files.
# If you have issues with the permissions on Ubuntu, here is a way to solve it: 
# https://askubuntu.com/questions/1181762/imagemagickconvert-im6-q16-no-images-defined

convert -density 300                   -quality 90 ${namestring}-crop.pdf ${namestring}_full.jpg
convert -density 300 -resize 1024x1024 -quality 90 ${namestring}-crop.pdf ${namestring}_1024.jpg
convert -density 300 -resize  640x640  -quality 90 -unsharp 0x0.75+0.75+0.008 ${namestring}-crop.pdf ${namestring}_640.jpg
convert -density 300 -resize  320x320  -quality 90 -unsharp 0x0.75+0.75+0.008 ${namestring}-crop.pdf ${namestring}_320.jpg
