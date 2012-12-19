#!/bin/bash
if [ ! $1 ]; then exit 1; fi
VER="$1"
sed -i "s|develop|$1|" Modulefile
sed -i 's|develop|master|' README.md
