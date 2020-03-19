#!/bin/bash
# Generate stylised animation from video macroblock motion vectors,
# and present in a side-by-side comparison with original video.
# version: 2018.03.28.21.08.16
# source: https://oioiiooixiii.blogspot.com

cropSize="640:ih:480:0" # Adjust area and dimensions of interest

ffplay \
   -flags2 +export_mvs \
   -i "$1" \
   -vf \
      "
         split [original][vectors];
         [vectors] codecview=mv=pf+bf+bb,
                   crop=$cropSize [vectors];
         [original] crop=$cropSize,
                    split=3 [original][original1][original2];
         [vectors][original2] blend=all_mode=difference128,
                              eq=contrast=7:brightness=-0.3,
                              split [vectors][vectors1];
         [vectors1] colorkey=0xFFFFFF:0.9:0.2 [vectors1];
         [original1][vectors1] overlay,
                               smartblur,
                               dilation,dilation,dilation,dilation,dilation,
                               eq=contrast=1.4:brightness=-0.09 [pixels];
         [vectors][original][pixels] hstack=inputs=3
      "
