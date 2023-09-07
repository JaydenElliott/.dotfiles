#!/bin/bash

function is_installed {
  builtin type -P "$1" &> /dev/null
}
