#!/bin/bash

# CONFIG ======================

# Directory to save files to
video_directory="$HOME/Videos"
audio_directory="$HOME/Sounds"

# youtube-dl codes

# Webm video of best quality in 30fps
webm_video='248/247/244/243/242/278'

# Webm video of best quality in 60fps
webm_60fps_video='303/302'

# Webm audio of best quality
webm_audio='251/250/249'

# M4a audio
m4a_audio='140'

# =============================

download_video () {
    title="$(youtube-dl --get-title "$link")"

    youtube-dl -f "$video_codes" \
               -o "$video_directory/temporary-video.webm" \
               "$link"

    youtube-dl -f "$audio_codes" \
               -o "$video_directory/temporary-audio.webm" \
               "$link"

    ffmpeg -i "$video_directory/temporary-video.webm" \
           -i "$video_directory/temporary-audio.webm" \
           -c copy "$video_directory/RENAME_$title.mp4"

    rm "$video_directory/temporary-video.webm"
    rm "$video_directory/temporary-audio.webm"    
}

download_audio () {
    title="$(youtube-dl --get-title "$link")"

    youtube-dl -f "$audio_codes" \
               -o "$audio_directory/temporary-audio.webm" \
               "$link"

    ffmpeg -i "$audio_directory/temporary-audio.webm" \
           -vn -ab 128k -ar 44100 \
           -y "$audio_directory/RENAME_$title.mp3"

    rm "$audio_directory/temporary-audio.webm"
}

case "$1" in
   '-f')
        link="$2"
        video_codes="$webm_60fps_video/$webm_video"
        audio_codes="$webm_audio"

        download_video
        ;;
   '-a')
        link="$2"
        audio_codes="$m4a_audio"

        download_audio        
        ;;
   *)
        link="$1"
        video_codes="$webm_video"
        audio_codes="$webm_audio"

        download_video
        ;;
esac
