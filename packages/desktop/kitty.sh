#!/bin/bash
if ! command -v kitty &> /dev/null
then
  curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
fi


