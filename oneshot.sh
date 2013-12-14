#!/bin/sh

INFILE="$1"
OUTFILE="$2"
INFO="`dirname "$OUTFILE"`/info"

if [ -z "$INFILE" -o ! -f "$INFILE" ]
then
    echo "$0: No infile: $INFILE"
    exit 127
fi

#if [ ! -f "$INFO" ]; then
#    echo "$0: No info file: $INFO"
#
#    # ffmpeg/avconv
#    getinfo_avprobe() {
#        avprobe "$1" > "$2" 2>&1 
#    }
#    # mkvtools
#    getinfo_mkvtools() {
#        mkvmerge -i "$1" > "$2"
#    }
#
#    echo getinfo_avprobe "$INFILE" "$INFO" || {
#        echo "$0: test.info: Error making info file: $INFO"
#        exit 1
#    }
#fi

ffmpeg \
    -i "$1" \
    -map 0:v -map 0:a \
    -c:v libx264 -crf 23 -profile:v high -preset medium -level 4.1 \
    -c:a aac -b:a 192k -strict experimental -ac 2 -af aresample=matrix_encoding=dplii \
    -sn \
    "$2"

