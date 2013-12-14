#!/bin/sh

. "`dirname $0`/../master.sh"
INPUT_DIR=/srv/minidlna/content/Videos/Movies
OUTPUT_DIR=/srv/minidlna/content/


#
# these inputs are all 6 channel DTS.
# make output downmixed 2 channel AAC-LC and 6-channel AAC-LC.
#

convert_simple_surround \
    "$INPUT_DIR/Alien (1979) (Director's Cut).mkv" \
    "$OUTPUT_DIR/Alien (1979) (Director's Cut).mp4"

convert_simple_surround \
    "$INPUT_DIR/Alien (1979).mkv" \
    "$OUTPUT_DIR/Alien (1979).mp4" 

convert_simple_surround \
    "$INPUT_DIR/Alien³ (1993) (Assembly Cut).mkv" \
    "$OUTPUT_DIR/Alien³ (1993) (Assembly Cut).mp4"

convert_simple_surround \
    "$INPUT_DIR/Alien³ (1993).mkv" \
    "$OUTPUT_DIR/Alien³ (1993).mp4"

convert_simple_surround \
    "$INPUT_DIR/Alien - Resurrection (1997).mkv" \
    "$OUTPUT_DIR/Alien - Resurrection (1997).mp4"

convert_simple_surround \
    "$INPUT_DIR/Alien - Resurrection (1997) Special Edition.mkv" \
    "$OUTPUT_DIR/Alien - Resurrection (1997) Special Edition.mp4"

convert_simple_surround \
    "$INPUT_DIR/Aliens (1986).mkv" \
    "$OUTPUT_DIR/Aliens (1986).mp4"

convert_simple_surround \
    "$INPUT_DIR/Aliens (1986) Special Edition.mkv" \
    "$OUTPUT_DIR/Aliens (1986) Special Edition.mp4"

