#!/bin/sh
export SDL_VIDEO_X11_VISUALID=
pkill -f looking-glass-client || looking-glass-client -s
