#!/bin/bash

directory="${HOME}/Screenshots"

# Display --help page
display_help() {
    cat << end_of_message

    screenshot.sh [-h, --help | -a, --area]

    Default behavior is to make screenshot of the screen, copy it to clipboard 
    and save it as a file to directory specified in the variable 'directory' in 
    the script.

    -a, --area makes that you can select area of the screen to be captured with mouse.

    Dependencies: scrot, xclip.

    Exit codes:
        1 - Print --help and exit
        2 - Wrong option
        3 - 'scrot' return non-zero exit code

end_of_message
}

case "${1}" in
    -h | --help )
        display_help
        exit 1 ;;

    '' )
        # Make screenshot of the whole screen and copy in to clipboard
        scrot --quality 100 --exec 'xclip -selection clipboard -t image/png -i $f' \
              "${directory}/screenshot_%Y-%m-%d_%H-%m-%S.png" || exit 3
        exit ;;

    -a | --area )
        # Make screenshot of screen area selected by mouse and copy it to clipboard
        scrot --quality 100 --line style=solid,width=2,color="cyan" \
              --freeze --select --exec 'xclip -selection clipboard -t image/png -i $f' \
              "${directory}/screenshot_%Y-%m-%d_%H-%m-%S.png" || exit 3
        exit ;;

    * )
        echo 'ERROR: Unknown option'
        exit 2 ;;
esac
