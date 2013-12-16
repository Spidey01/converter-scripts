#!/bin/sh

. "`dirname $0`/../master.sh"
INPUT_DIR=/srv/minidlna/content/Videos/Movies
OUTPUT_DIR=/srv/minidlna/content/


#
# these inputs are all 6 channel DTS features with a 2 channel AC3 commentary.
# make output:
#   - downmixed 2 channel AAC-LC
#   - 6-channel AAC-LC
#   - 2 channel AAC-LC (commentary)
#
# Quality needs to be lowered however to keep it within the Chromecast's margins :'(.
#

x264_crf=26
convert_simple_surround_with_commentary \
    "$INPUT_DIR/Army of Darkness (1992).mkv" \
    "$OUTPUT_DIR/Army of Darkness (1992).mp4"

x264_crf=24
convert_simple_surround_with_commentary \
    "$INPUT_DIR/Evil Dead II - Dead by Dawn (1987).mkv" \
    "$OUTPUT_DIR/Evil Dead II - Dead by Dawn (1987).mp4"

x264_crf=
