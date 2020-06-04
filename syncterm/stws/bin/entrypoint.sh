#!/bin/sh
rm -rf /tmp/.X11-unix/
rm -f /tmp/.X1-lock
if [ ! -f '~/.vnc/passwd' ]; then
    echo "${PASSWD:-syncterm}" | vncpasswd -f > ~/.vnc/passwd
    chmod 600 ~/.vnc/passwd
fi
vncserver :1 -geometry 640x400 -depth 15 -name SyncTERM
cd /home/syncterm/stws/noVNC
./utils/launch.sh --vnc localhost:5901 
