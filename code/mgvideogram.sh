#!/bin/bash

duration="$(ffprobe "$1" 2>&1 | grep Duration | awk  '{ print $2 }')"
seconds="$(echo $duration \
         | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }' \
         | cut -d '.' -f 1)"
fps="$(ffprobe "$1" 2>&1 \
      | sed -n 's/.*, \(.*\) fps,.*/\1/p' \
      | awk '{printf("%d\n",$1 + 0.5)}')"
frames="$(( seconds*fps ))"


ffmpeg -y -i pianist2.mp4-frames 1 -vf f'scale=1:{height}:sws_flags=area,normalize,tile={framecount}x1', '-aspect', f'{framecount}:{height}', target_name_y

1280 720

# Check number of frames
ffprobe -v error -select_streams v:0 -count_packets -show_entries stream=nb_read_packets -of csv=p=0 input.mp4


#Rendering horizontal videogram
ffmpeg -y -i pianist2.mp4 -frames 1 -vf scale=1:720:sws_flags=area,normalize,tile=230x1 -aspect 230:720 out_horizontal.png

#Rendering vertical videogram
ffmpeg -y -i pianist2.mp4 -vf scale=1280:1:sws_flags=area,normalize,tile=1x230 -aspect 1280:230 -frames 1 out_vertical.png

