#!/bin/bash

scrot 'screen_%H-%M-%S.png' -e 'xclip -selection clipboard -target image/png -i $f && mv $f Screenshots/'
