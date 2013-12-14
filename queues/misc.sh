#!/bin/sh

. "`dirname $0`/../master.sh"
INPUT_DIR=/srv/minidlna/content/Videos/Movies
OUTPUT_DIR=/srv/minidlna/content/


# Has 3 copies of 640kb/s AC3 surround and a DTS True HD as #2. Use that.
`get_ffmpeg` -i "$INPUT_DIR/Beetlejuice (1988).mkv" \
        -map 0:0 -map 0:2 -map 0:2 \
        -c:v `get_video_flags` \
        -c:a:1 `get_downmix_audio_flags 1` \
        -c:a:2 `get_surround_audio_flags 2` \
        "$OUTPUT_DIR/Beetlejuice (1988).mp4"


# Has surround DTS and two stereo AC3 comentaries
`get_ffmpeg` -i "$INPUT_DIR/Independence Day (1996).mkv" \
        -map 0:0 -map 0:1 -map 0:1 -map 0:2 -map 0:3 \
        -c:v `get_video_flags` \
        -c:a:1 `get_downmix_audio_flags 1` \
        -c:a:2 `get_surround_audio_flags 2` \
        -c:a:3 `get_stereo_audio_flags 3` -metadata:s:a:2 "comment=commentary" \
        -c:a:4 `get_stereo_audio_flags 4` -metadata:s:a:3 "comment=commentary" \
    "$OUTPUT_DIR/Independence Day (1996).mp4"


convert_simple_surround_with_commentary \
    "$INPUT_DIR/Labyrinth (1986).mkv" \
    "$OUTPUT_DIR/Labyrinth (1986).mp4"


# Has DTS and AC3 surround. This will use the DTS for downmix.
convert_simple_surround \
    "$INPUT_DIR/My Name Is Bruce (2007).mkv" \
    "$OUTPUT_DIR/My Name Is Bruce (2007).mp4"


# Has DTS-HD MA and DTS surround. This will use the lossless DTS-HD for downmix.
convert_simple_surround \
    "$INPUT_DIR/Planes, Trains & Automobiles (1987).mkv" \
    "$OUTPUT_DIR/Planes, Trains & Automobiles (1987).mp4"


# Has DTS+AC3 surround and a AC3 commentary.
`get_ffmpeg` -i "$INPUT_DIR/Predator (1987).mkv" \
        -map 0:0 -map 0:1 -map 0:1 -map 0:3 \
        -c:v `get_video_flags` \
        -c:a:1 `get_downmix_audio_flags 1` \
        -c:a:2 `get_surround_audio_flags 2` \
        -c:a:3 `get_stereo_audio_flags 3` -metadata:s:a:2 "comment=commentary" \
    "$OUTPUT_DIR/Predator (1987).mp4"


# Has DTS surround, AC3 stereo, and 2 x AC3 commentaries
`get_ffmpeg` -i "$INPUT_DIR/Predator 2 (1990).mkv" \
        -map 0:0 -map 0:2 -map 0:1 -map 0:3 -map 0:4 \
        -c:v `get_video_flags` \
        -c:a:1 `get_stereo_audio_flags 1` \
        -c:a:2 `get_surround_audio_flags 2` \
        -c:a:3 `get_stereo_audio_flags 3` -metadata:s:a:2 "comment=directors_commentary" \
        -c:a:4 `get_stereo_audio_flags 4` -metadata:s:a:3 "comment=writers_commentary" \
    "$OUTPUT_DIR/Predator 2 (1990).mp4"


convert_surround_and_stereo_with_commentary \
    "$INPUT_DIR/Spaceballs (1987).mkv" \
    "$OUTPUT_DIR/Spaceballs (1987).mp4"


convert_simple_surround \
    "$INPUT_DIR/Stargate (1994).mkv" \
    "$OUTPUT_DIR/Stargate (1994).mp4"


convert_simple_surround_with_commentary \
    "$INPUT_DIR/Stargate (1994) (Unrated Extended).mkv" \
    "$OUTPUT_DIR/Stargate (1994) (Unrated Extended).mp4"
exit


# Has a DTS surround and the original mono track in AC3. This will just use the DTS.
convert_simple_surround \
    "$INPUT_DIR/The Wizard of Oz (1939).mkv" \
    "$OUTPUT_DIR/The Wizard of Oz (1939).mp4"

