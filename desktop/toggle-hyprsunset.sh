#!/bin/bash
if pgrep -x hyprsunset > /dev/null; then
    pkill -x hyprsunset
    sleep 0.3  # wait for it to fully release the CTM
else
    hyprsunset --temperature 4000 &
fi
