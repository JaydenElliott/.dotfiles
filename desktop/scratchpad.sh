#!/bin/bash

DIR="/home/jayden/Documents/scratchpads"
mkdir -p "$DIR"

# Find the largest n
latest=$(ls "$DIR"/scratchpad_*.txt 2>/dev/null | grep -oP '\d+' | sort -n | tail -1)

if [ -z "$latest" ]; then
    latest=1
fi

kitty --class scratchpad nvim "$DIR/scratchpad_${latest}.txt"
