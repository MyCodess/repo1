#!/bin/bash
# Script to open new file manager tab instead of window (e.g., Thunar) in XFCE. 
# Version 1. 2017-04-18

##--I-  https://forum.xfce.org/viewtopic.php?id=12154  ,   https://forums.linuxmint.com/viewtopic.php?t=244076 :

# Lock script to process multiple instances consecutively when "Open All" on Desktop. 
if [[ -d "${1}" ]]; then
	ME=`basename "$0"`;
	LCK="/tmp/${ME}.LCK";
	exec 8>$LCK;
	flock -x 8;  # lock $LCK
	trap 'rm -f $LCK' exit # remove $LCK regardless of exit status
	sleep .1 # hack to give time for each script to execute properly--weird!
fi

# Convert desktop file urls to thunar-friendly local paths. 
# Accommodates special characters in directory names (!@#$, etc).
fileurl="${1}"
filepath="$(urlencode -d ${fileurl%/})/"

# Check for running instances of $app on current desktop/workspace.
app=thunar
wid=( $(xdotool search --desktop $(xdotool get_desktop) --class $app) ) 
lastwid=${wid[*]: -1} # Get PID of newest active thunar window.

# If $wid is null launch app with filepath.
if [ -z $wid ]; then
	$app "$filepath"
        
# If app is already running, activate it and use shortcuts to paste filepath into path bar.
else  
	xdotool windowactivate --sync $lastwid key ctrl+t ctrl+l # Activate pathbar in thunar 
	xdotool type -delay 0 "$filepath" # "--delay 0" removes default 12ms between each keystroke
	xdotool key Return
fi
exit 0


# Easy Installation: 
# cd ~/Downloads && tar -zxvf thunartab.tar.gz && sudo chmod 755 thunartab && sudo cp thunartab /usr/local/bin/
# Install dependencies: sudo apt install gridsite-clients xdotool # gridsite-clients contains urlencode 
# Reboot # if you want to run "thunartab" as a command in terminal
# Select script in the XFCE's GUI "Preferred Applications"
#
# For alternatives for script location run "echo $PATH" (without quotes) in terminal
# Troubleshooting: If more than one thunar window opens with "Open All", try increasing sleep value on line 12
# 
# For other file-managers (e.g., Nemo, Caja, Nautilus), change app name on line 21 
# You may also have to modified  the xdotool shortcuts on line 31.
# For example for Nemo, change line 31 to something like
# xdotool windowactivate --sync $lastwid key ctrl+t ctrl+l ctrl+v Return ctrl+l Escape
# Manually test shortcuts in file manager first. 
# 
# Main sources for learning bash for this script include: 
# http://ryanstutorials.net/bash-scripting-tutorial/ "Bash Scripting Tutorial" (Very good for beginners like myself"
# http://jdimpson.livejournal.com/5685.html "Using flock to protect critical sections in shell scripts"
# https://askubuntu.com/questions/55656/open-nautilus-as-new-tab-in-existing-window (the starting idea for this script)
#
# Bug reports or suggestions, please email me, Sam, at sampub@islandroots.ca

