#!/bin/bash
# Temporal slice-stacking effect with FFmpeg (aka 'wibbly-wobbly' video).
# See 'NOTES' at bottom of script.

# Ver. 2017.10.01.22.14.08
# source: http://oioiiooixiii.blogspot.com

function cleanUp() # tidy files after script termination
{
   rm -rf "$folder" \
   && echo "### Removed temporary files and folder '$folder' ###"
}
trap cleanUp EXIT

### Variables
folder="$(mktemp -d)" # create temp work folder
duration="$(ffprobe "$1" 2>&1 | grep Duration | awk  '{ print $2 }')"
seconds="$(echo $duration \
         | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }' \
         | cut -d '.' -f 1)"
fps="$(ffprobe "$1" 2>&1 \
      | sed -n 's/.*, \(.*\) fps,.*/\1/p' \
      | awk '{printf("%d\n",$1 + 0.5)}')"
frames="$(( seconds*fps ))"
width="640" # CHANGE AS NEEDED (e.g. width/2 etc.)
height="360" # CHANGE AS NEEDED (e.g. height/2 etc.)

### Filterchains
stemStart="select=gte(n\,"
stemEnd="),format=yuv444p,split[horz][vert]"
horz="[horz]crop=in_w:1:0:n,tile=1x${height}[horz]"
vert="[vert]crop=1:in_h:n:0,tile=${width}X1[vert]"
merge="[0:v]null[horz];[1:v]null[vert]"
scale="scale=${width}:${height}"

#### Create resized video, or let 'inputVideo=$1'
clear; echo "### RESIZING VIDEO (location: $folder) ###"
inputVideo="$folder/resized.mkv"
ffmpeg -loglevel debug -i "$1" -vf "$scale" -crf 10 "$inputVideo" 2>&1 \
|& grep 'frame=' | tr \\n \\r; echo

### MAIN LOOP
for (( i=0;i<"$frames";i++ ))
do
   echo -ne "### Processing Frame: $i of $frames  ### \033[0K\r"
   ffmpeg \
   -loglevel panic \
      -i "$inputVideo" \
      -filter_complex "${stemStart}${i}${stemEnd};${horz};${vert}" \
      -map '[horz]' \
         -vframes 1 \
         "$folder"/horz_frame${i}.png \
      -map '[vert]' \
         -vframes 1 \
         "$folder"/vert_frame${i}.png
done

### Join images (optional sharpening, upscale, etc. via 'merge' variable)
echo -ne "\n### Creating output videos ###"
ffmpeg \
   -loglevel panic \
   -r "$fps" \
   -i "$folder"/horz_frame%d.png \
   -r "$fps" \
   -i "$folder"/vert_frame%d.png \
   -filter_complex "$merge" \
   -map '[horz]' \
      -r "$fps" \
      -crf 10 \
      "${1}_horizontal-smear.mkv" \
   -map '[vert]' \
      -r "$fps" \
      -crf 10 \
      "${1}_verticle-smear.mkv"

### Finish and tidy files
exit

### NOTES ######################################################################

# The input video is resized to reduce frames needed to fill frame dimensions
# (which can produce more interesting results).
# This is done by producing a separate video, but it can be included at the
# start of 'stemStart' filterchain to resize frame dimensions on-the-fly.
# Adjust 'width' and 'height' for alternate effects.

# For seamless looping, an alternative file should be created by looping
# the desired section of video, but set the number of processing frames to
# original video's 'time*fps' number. The extra frames are only needed to fill
# the void [black] area in frames beyond loop points.
