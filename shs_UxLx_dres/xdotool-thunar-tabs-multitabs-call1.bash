#!/bin/bash
##--I-  wrapper for xdotool-thunar-tabs-multitabs.bash

##--USAGE1:   ./xdotool-thunar-tabs-multitabs.bash  'dir1' 'dir2'

for dir in "${@}"; do
  xdotool-thunar-tabs-multitabs.bash    "$dir"
done

