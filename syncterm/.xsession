#!/bin/sh
xsetroot -solid blue -cursor_name left_ptr
~/stws/bin/syncterm
vncserver -kill :1
