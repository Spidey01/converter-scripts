#!/bin/sh

. "`dirname $0`/../master.sh"
INPUT_DIR=/srv/minidlna/content/Videos/Movies
OUTPUT_DIR=/srv/minidlna/content/


convert_surround_and_stereo \
    "$INPUT_DIR/Die Hard (1988).mkv" \
    "$OUTPUT_DIR/Die Hard (1988).mp4"

convert_surround_and_stereo_with_commentary \
    "$INPUT_DIR/Die Hard 2 - Die Harder (1990).mkv" \
    "$OUTPUT_DIR/Die Hard 2 - Die Harder (1990).mp4"

convert_simple_surround_with_commentary \
    "$INPUT_DIR/Die Hard - With a Vengeance (1995).mkv" \
    "$OUTPUT_DIR/Die Hard - With a Vengeance (1995).mp4"

# There's two surround tracks, 1.5 Mbit/s DTS and 448 Kbit/s AC3.T his will use
# the DTS for the downmix.
convert_simple_surround \
    "$INPUT_DIR/Live Free or Die Hard (2007).mkv" \
    "$OUTPUT_DIR/Live Free or Die Hard (2007).mp4"

