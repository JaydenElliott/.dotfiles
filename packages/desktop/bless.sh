#!/bin/bash
cd /tmp
meson setup build (-Dopt=val --buildtype=type ...)
git clone https://github.com/afrantzis/bless
ninja -C build
sudo ninja -C build install
