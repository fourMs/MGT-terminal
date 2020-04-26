ffmpeg -i R0012298.MP4 -i xmap_thetaS_1920x960v3.pgm -i ymap_ThetaS_1920x960v3.pgm -q 0 -lavfi "format=pix_fmts=rgb24,remap" remapped.mp4
