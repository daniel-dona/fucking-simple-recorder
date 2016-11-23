#!/bin/bash

trap 'kill -TERM $PID' TERM INT

# Hard coded to my env, feel free to change options
# See https://trac.ffmpeg.org/wiki/Capture/Desktop
# See https://ubuntuforums.org/showthread.php?t=1392026&s=f2e1d8bead1ba55629a627c1c4c2000f

avconv -f x11grab -s 1366x768+0+0 -r 25 -i :0.0 \
 -f pulse -ac 2 -i alsa_input.pci-0000_00_1b.0.analog-stereo \
 -f pulse -ac 2 -i alsa_output.pci-0000_00_1b.0.analog-stereo.monitor -filter_complex amix \
 -itsoffset 1.0 \
 -c:v libx264 -preset slow -c:a mp3 -f mp4 $1 &

#avconv -f x11grab -s 1366x768+0+0 -r 25 -i :0.0 \
# -f pulse -ac 2 -i alsa_input.pci-0000_00_1b.0.analog-stereo \
# -f pulse -ac 2 -i alsa_output.pci-0000_00_1b.0.analog-stereo.monitor\
# -filter_complex amix -itsoffset 1.0 \
#  -c:v libx264 -preset slow -c:a mp3 -f mp4 $1 &


#avconv -f x11grab -s 1366x768+0+0 -r 5 -i :0.0 \
# -f pulse -ac 2 -i alsa_input.pci-0000_00_1b.0.analog-stereo \
#  -c:v libx264 -preset ultrafast -c:a mp3 -f mp4 $1 &
 
PID=$!
wait $PID
trap - TERM INT
wait $PID
EXIT_STATUS=$?
