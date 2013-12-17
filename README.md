converter-scripts
=================

These are my helper scripts and shell library for converting videos.

    - master.sh
        + The shell library. Numerous functions to do conversion.
    - oneshot.sh
        + Test script doing one video transcode.
    - examples/\*.sh
        + Contain scripts used for converting my collection.
    - all-infos.sh 
        + Compile ffprobe outputs into a big file.
    - ffmpeg.helpfull
        + Output from ffmpeg --help full.
    - README.md
        + You're reading it, d'uh.

Except for master.sh, most of these are not made to be run without editing. I.e. be wary of finding hard coded paths in the other scripts (like examples/\*.sh).

## Goals ##

    1. Convert my Blu-ray rips to play on Chromecast, via Avira Media Player app.

    2. Not have to deal with device X being unable to handle the intense video decode.

## Input Description ##

My videos are ripped from Blu-rays using MakeMKV. This basically remuxes the selected content streams into a Matroska (.mkv) file. Typical content is H.264 and VC-1 videos in the range of 20 Mbit/s to just over 30 Mbit/s.

Audios are often in some form of Digital Theatre Surround (DTS) or Dolby formats. There's a few common themes with how I rip my movies:

    - Surround sound only.

    - Surround sound with stereo commentary.

    - Surround sound and stereo feature with commentaries in stereo.

## Output Description ##

Outputs are H.264 videos with AAC(-LC) audios. One reason the MP4 container was chosen over Matroska, is because my high quality rips are already in Matroska.

H.264 is the most widely compatible video format that is also available on Chromecast. Just about everything will play some kind of H.264 video now're days, even a toaster oven. Chromecast also gives us the choice of AAC or Vorbis audios. AAC was chosen for greater compatibility.


Experiments have shown Chromecast can only handle H.264 high profile 1.1 up to 5~6 Mbit/s. Video is transcoded using libx264 and a Constant Rate Factor (--crf) of 23. This usually generates acceptible output in a low enough bitrate.

Audios generally take one of the following forms based on the input:


    INPUT Streams   OUTPUT Streams

    Surround        Downmix (576 Kbit/s)
                    Surround (640 Kbit/s)

    Surround        Stereo (192 Kbit/s)
    Stereo          Surround (640 Kbit/s)

    Surround        Downmix (576 Kbit/s)
    Commentary      Surround (640 Kbit/s)
                    Stereo (192 Kbit/s) (commentary)

    Surround        Stereo (192 Kbit/s)
    Stereo          Surround (640 Kbit/s)
    Commentaries    Stereo (192 Kbit/s) (commentary)


Downmixes are done using the aresample audio filter and Dolby Pro Logic II matrix encoding. In theory this offers a Stereo audio stream that retains much of the surround sound information, when played on capable hardware. 576 Kbit/s is as high as I could get ffmpeg 2.1.1. to use with its aac codec. That amounts to head room of 96 Kbit/s per channel on 5.1 surround and 72 Kbit/s on 7.1 surround.

Stereo audio is always put first, to deal with devices that can't downmix. While my Android devices generally downmix DTS and AC3 audio perfectly fine, Chromecast and VLC doesn't seem to do this with AAC.


The surround tracks at 640 Kbit/s amount to head room for 106 Kbit/s (5.1) to 80 Kbit/s (7.1) per channel, depending on the form of surround sound used.

The Stereo tracks where available, are used in place of a downmix: on the assumption that the studio engineer did a better job than ffmpeg will. 192 Kbit/s amounts to 96 Kbit/s per channel.

Metadata is attached to identify the audio. E.g. comment=downmixed, comment=stereo, comment=surround, comment=commentary, etc.
