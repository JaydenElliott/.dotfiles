#!/bin/bash

DIR="/home/jayden/Documents/obsidian/work-notes/scratchpads"
mkdir -p "$DIR"

# Find the largest n
latest=$(ls "$DIR"/scratchpad_*.md 2>/dev/null | grep -oP '\d+' | sort -n | tail -1)

if [ -z "$latest" ]; then
    latest=1
fi

kitty --class scratchpad --directory "$DIR" nvim "scratchpad_${latest}.md"
