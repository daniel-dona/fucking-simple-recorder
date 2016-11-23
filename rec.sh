#!/bin/bash

trap 'kill -TERM $PID' TERM INT

avconv -f x11grab -s 1366x768+0+0 -r 25 -i :0.0 \
 -f pulse -ac 2 -i alsa_input.pci-0000_00_1b.0.analog-stereo \
 -f pulse -ac 2 -i alsa_output.pci-0000_00_1b.0.analog-stereo.monitor -filter_complex amix \
 -itsoffset 1.0 \
 -c:v libx264 -preset slow -c:a mp3 -f mp4 $1 &

#avconv -f x11grab -s 1366x768+0+0 -r 25 -i :0.0 \
# -f pulse -ac 2 -i alsa_input.pci-0000_00_1b.0.analog-stereo \
# -f pulse -ac 2 -i alsa_output.pci-0000_00_1b.0.analog-stereo.monitor\
# -filter_complex amix \
# -itsoffset 1.0 \
#  -c:v libx264 -preset slow -c:a mp3 -f mp4 $1 &


#avconv -f x11grab -s 1366x768+0+0 -r 5 -i :0.0 \
# -f pulse -ac 2 -i alsa_input.pci-0000_00_1b.0.analog-stereo \
# -f pulse -ac 2 -i alsa_output.pci-0000_00_1b.0.analog-stereo.monitor -filter_complex amix \
#  -c:v libx264 -preset ultrafast -c:a mp3 -f mp4 $1 &
 
PID=$!
wait $PID
trap - TERM INT
wait $PID
EXIT_STATUS=$?
