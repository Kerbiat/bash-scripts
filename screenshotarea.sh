#!/bin/bash

scrot -l width=2,color=#d2d6ff -fs 'screen_%H-%M-%S.png' -e 'xclip -selection clipboard -target image/png -i $f && mv $f Screenshots/'
