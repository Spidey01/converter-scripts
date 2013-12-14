#!/bin/bash

# input video => output H.264 high profile 4.1
get_video_flags() {
    echo libx264 -crf 23 -profile:v high -preset medium -level 4.1
}

get_stereo_audio_flags() { # input / output => stereo
    #
    # $1 = stream #
    #
    # 192k = 96k/ch.
    #
    echo aac "-ab:${1}" 192k \
        "-metadata:s:a:`expr $1 - 1`" "comment=stereo" \
        -strict experimental
}

get_surround_audio_flags() { # input / output => surround
    #
    # $1 = stream #
    #
    # 640k = 80k/ch for 8 channel (7.1).
    #       106k/ch for 6 channel (5.1).
    #
    echo aac \
        "-ab:${1}" 640k \
        "-metadata:s:a:`expr $1 - 1`" "comment=surround" \
        -strict experimental
}

get_downmix_audio_flags() { # input surround => output downmixed stereo
    #
    # $1 = stream # 
    #
    # We override the title metadata because we're downmixing and ffmpeg will
    # just copy the old, which would usually be like 3/2+1 for 6 channels.
    #
    # Seems ffmpeg can only go up to 576k here. Dunno why.  That's still 72k (8
    # channel) to 95k (6 channel) worth of head room per channel. So I'm sure
    # that's enough space to avoid ditching too much data.
    #
    echo aac \
        "-metadata:s:a:`expr $1 - 1`" "title=2/0" \
        "-metadata:s:a:`expr $1 - 1`" "comment=downmixed" \
        "-ab:${1}" 576k \
        "-filter:${1}" aresample=matrix_encoding=dplii \
        "-ac:${1}" 2 \
        -strict experimental
}

get_ffmpeg() {
    echo ffmpeg
}

#
# input is video + surround
# output is video + downmix + surround
#
# $1 = in file
# $2 = out file
#
convert_simple_surround() {
    `get_ffmpeg` -i "$1" \
        -map 0:0 -map 0:1 -map 0:1 \
        -c:v `get_video_flags` \
        -c:a:1 `get_downmix_audio_flags 1` \
        -c:a:2 `get_surround_audio_flags 2` \
        "$2"
}

#
# input is video + feature surround + commentary stereo
# output is video + downmix feature + surround feature + commentary stereo
#
# $1 = in file
# $2 = out file
#
convert_simple_surround_with_commentary() {
    `get_ffmpeg` -i "$1" \
        -map 0:0 -map 0:1 -map 0:1 -map 0:2 \
        -c:v `get_video_flags` \
        -c:a:1 `get_downmix_audio_flags 1` \
        -c:a:2 `get_surround_audio_flags 2` \
        -c:a:3 `get_stereo_audio_flags 3` -metadata:s:a:2 "comment=commentary" \
        "$2"
}

#
# input is video + feature surround + feature stereo.
# output is video + stereo + surround
#
# This is assuming that whoever did the stereo mix is gonna have done a better
# job than our ffmpeg powered magic!
#
# $1 = in file
# $2 = out file
#
convert_surround_and_stereo() {
    # XXX do we want the stereo or surround as first audio?
    `get_ffmpeg` -i "$1" \
        -map 0:0 -map 0:2 -map 0:1 \
        -c:v `get_video_flags` \
        -c:a:1 `get_stereo_audio_flags 1` \
        -c:a:2 `get_surround_audio_flags 2` \
        "$2"
}


#
# input is video + feature surround + feature stereo + commentary stereo
# output is video + stereo feature + surround feature + commentary stereo
#
# $1 = in file
# $2 = out file
#
convert_surround_and_stereo_with_commentary() {
    `get_ffmpeg` -i "$1" \
        -map 0:0 -map 0:2 -map 0:1 -map 0:3 \
        -c:v `get_video_flags` \
        -c:a:1 `get_stereo_audio_flags 1` \
        -c:a:2 `get_surround_audio_flags 2` \
        -c:a:3 `get_stereo_audio_flags 3` -metadata:s:a:2 "comment=commentary" \
        "$2"
}
        # -y -f mp4 \
        # /dev/null

