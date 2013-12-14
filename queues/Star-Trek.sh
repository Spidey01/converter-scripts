#!/bin/sh

. "`dirname $0`/../master.sh"
INPUT_DIR=/srv/minidlna/content/Videos/Movies
OUTPUT_DIR=/srv/minidlna/content/


#
# these inputs are all 6 channel AC3 features.
# make output:
#   - downmixed 2 channel AAC-LC
#   - 6-channel AAC-LC
#
convert_simple_surround \
    "$INPUT_DIR/Star Trek - The Motion Picture (1979).mkv" \
    "$OUTPUT_DIR/Star Trek - The Motion Picture (1979).mp4"

convert_simple_surround \
    "$INPUT_DIR/Star Trek V - The Final Frontier (1989).mkv" \
    "$OUTPUT_DIR/Star Trek V - The Final Frontier (1989).mp4"

convert_simple_surround \
    "$INPUT_DIR/Star Trek VI - The Undiscovered Country (1991).mkv" \
    "$OUTPUT_DIR/Star Trek VI - The Undiscovered Country (1991).mp4"




#
# these inputs are all 6 channel AC3 features with 2 x 2 channel AC3 comentaries.
# make output:
#   - downmixed 2 channel AAC-LC
#   - 6-channel AAC-LC
#   - 2-channel AAC-LC (first commentary)
#   - 2-channel AAC-LC (second commentary)
#

my_convert() {
    # $1 = in file
    # $2 = out file
    # $3 = first commentary comment
    # $4 = second commentary comment
    `get_ffmpeg` -i "$1" \
        -map 0:0 -map 0:1 -map 0:1 -map 0:2 -map 0:3 \
        -c:v `get_video_flags` \
        -c:a:1 `get_downmix_audio_flags 1` \
        -c:a:2 `get_surround_audio_flags 2` \
        -c:a:3 `get_stereo_audio_flags 3` -metadata:s:a:2 "comment=$3" \
        -c:a:4 `get_stereo_audio_flags 4` -metadata:s:a:3 "comment=$4" \
        "$2"
}


my_convert \
    "$INPUT_DIR/Star Trek II - The Wrath of Khan (1982).mkv" \
    "$OUTPUT_DIR/Star Trek II - The Wrath of Khan (1982).mp4" \
    Ronald_D_Moore_comentary \
    directors_commentary

my_convert \
    "$INPUT_DIR/Star Trek III - The Search for Spock (1984).mkv" \
    "$OUTPUT_DIR/Star Trek III - The Search for Spock (1984).mp4" \
    directors_commentary \
    Manny_Coto_comentary


my_convert \
    "$INPUT_DIR/Star Trek IV - The Voyage Home (1986).mkv" \
    "$OUTPUT_DIR/Star Trek IV - The Voyage Home (1986).mp4" \
    shatner_nimoy_and_directors_commentary \
    two_guys_comentary

