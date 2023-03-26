#!/bin/bash

##--I- see: http://forums.opensuse.org/english/get-help-here/multimedia/447599-mmcheck-check-your-multimedia-10-steps-script-file-proposed-reddwarf.html   AND http://forums.opensuse.org/english/get-help-here/multimedia/400119-check-your-multimedia-problem-ten-steps.html#post1898049
#: Title       : /home/james/bin/mmcheck
#: Date Created: Sun Oct 3 15:42:01 CDT 2010
#: Last Edit   : Mon Oct 4 19:54:00 CDT 2010
#: Author      : by RedDwarf & J. McDaniel
#: Version     : 1.00
#: Description : Check Your Installed Files for Mutimedia
#: Options     : none

# Written for the openSUSE forums on Sunday October 4, 2010

# Copy and paste this text as the file mmcheck into the ~/bin folder.
# Run the terminal command: chmod +x ~/bin/mmcheck, to make the file executable
# Open up a terminal session and type: mmcheck, to start the program

PROG="MultiMedia Check Version 1.00  -  Check for multimedia problems in just 10 steps  "

# Determine program user, save home folder location, request root password

USER="$HOME"

# Menu Disply System function
# Display up to 10 menu items and 0 is always Exit 
# Menu must have at least two choices plus exit

function print_menu {

# You can adjust the starting position of the mmcheck menu.  
# Using s_line=0 & s_col=0 would place the menu in the top left corner of your screen"

# Starting Terminal Line Number for menu
s_line=1
# Starting Terminal Column Number for Menu
s_col=1

# Display Program Title
tput clear
tput cup $(( s_line )) $(( s_col ))
tput setf 7
tput setb 2
tput bold
echo "$1"

# Fetch kernel version to display
# uname -r > ~/kernel.dat
# read kernel < ~/kernel.dat
# rm ~/kernel.dat

kernel=$(uname -r)

# Display Menu, Present User home, kernel version
tput sgr0
tput cup $(( s_line + 2 )) $(( s_col ))
tput setf 7
tput setb 1
tput bold
echo "$2" "USER:$USER" " Kernel:$kernel" " "

# Display Option for Line 1 (required)
tput sgr0
tput cup $(( s_line + 4 )) $(( s_col ))
echo "$5"

# Display Option for Line 2 (required)
if [ $4 -ge 2 ] ; then
  tput cup $(( s_line + 5 )) $(( s_col ))
  echo "$6"
  tput cup $(( s_line + 6 )) $(( s_col ))
  echo "$3"
  tput cup $(( s_line + 8 )) $(( s_col ))
fi


# Display Option for Line 3 (optional)
if [ $4 -ge 3 ] ; then
  tput cup $(( s_line + 6 )) $(( s_col ))
  echo "$7"
  tput cup $(( s_line + 7 )) $(( s_col ))
  echo "$3"
  tput cup $(( s_line + 9 )) $(( s_col ))
fi

# Display Option for Line 4 (optional)
if [ $4 -ge 4 ] ; then
  tput cup $(( s_line + 7 )) $(( s_col ))
  echo "$8"
  tput cup $(( s_line + 8 )) $(( s_col ))
  echo "$3"
  tput cup $(( s_line + 10 )) $(( s_col ))
fi

# Display Option for Line 5 (optional)
if [ $4 -ge 5 ] ; then
  tput cup $(( s_line + 8 )) $(( s_col ))
  echo "$9"
  tput cup $(( s_line + 9 )) $(( s_col ))
  echo "$3"
  tput cup $(( s_line + 11 )) $(( s_col ))
fi

# Display Option for Line 6 (optional)
if [ $4 -ge 6 ] ; then
  tput cup $(( s_line + 9 )) $(( s_col ))
  echo "${10}"
  tput cup $(( s_line + 10 )) $(( s_col ))
  echo "$3"
  tput cup $(( s_line + 12 )) $(( s_col ))
fi

# Display Option for Line 7 (optional)
if [ $4 -ge 7 ] ; then
  tput cup $(( s_line + 10 )) $(( s_col ))
  echo "${11}"
  tput cup $(( s_line + 11 )) $(( s_col ))
  echo "$3"
  tput cup $(( s_line + 13 )) $(( s_col ))
fi

# Display Option for Line 8 (optional)
if [ $4 -ge 8 ] ; then
  tput cup $(( s_line + 11 )) $(( s_col ))
  echo "${12}"
  tput cup $(( s_line + 12 )) $(( s_col ))
  echo "$3"
  tput cup $(( s_line + 14 )) $(( s_col ))
fi

# Display Option for Line 9 (optional)
if [ $4 -ge 9 ] ; then
  tput cup $(( s_line + 12 )) $(( s_col ))
  echo "${13}"
  tput cup $(( s_line + 13 )) $(( s_col ))
  echo "$3"
  tput cup $(( s_line + 15 )) $(( s_col ))
fi

# Display Option for Line 10 (optional)
if [ $4 -ge 10 ] ; then
  tput cup $(( s_line + 13 )) $(( s_col ))
  echo "${14}"
  tput cup $(( s_line + 14 )) $(( s_col ))
  echo "$3"
  tput cup $(( s_line + 16 )) $(( s_col ))
fi

# Display menu option request and get user input
tput setaf 2
tput bold
read -p "Enter your choice [0-"$4"] " CHOICE
tput clear
tput sgr0
tput rc
return $CHOICE
}

# Main Program Loop starts here ...

while true ; do

# Setup Menu string Fields displayed for your menu

MENU=" Mutimedia Test Selection - M E N U "
EXIT=" 0 . Exit Mutimedia Test Selection Menu                                           "
TOTL="10" 
TST1=" 1 . Check if there are any missing dependencies for installed packages ...       "
TST2=" 2 . Check if there are packages installed from the VideoLAN repository ...       "
TST3=" 3 . Check your basic installed multimedia packages ...                           "
TST4=" 4 . Verify you have xine installed and installed from Packman ...                "
TST5=" 5 . Check your xine packages ...                                                 "
TST6=" 6 . Verify you have all the gstreamer plugins (codecs) installed from Packman ..."
TST7=" 7 . Check your gstreamer packages ...                                            "
TST8=" 8 . Check your MPlayer package ...                                               "
TST9=" 9 . Check your VLC packages ...                                                  "
TSTA=" 10. Check your w32codec package ...                                              "

# Call Menu and get user input selection

print_menu "$PROG" "$MENU" "$EXIT" "$TOTL" "$TST1" "$TST2" "$TST3" "$TST4" "$TST5" "$TST6" "$TST7" "$TST8" "$TST9" "$TSTA"
choice="$?"

# Execute User Command Here

case "$choice" in

  "1") tput setf 3
  echo $TST1
  tput sgr0
  echo 
  LC_ALL=C zypper ve
  echo
  read -p "Press <enter> to continue..." ;;

  "2") tput setf 3
  echo $TST2
  tput sgr0
  echo  
  rpm -qa --queryformat '%{NAME} -> %{VENDOR}\n' | grep -i VideoLAN
  echo
  echo "Only libdvdcss should be installed from the VideoLAN repository."
  echo
  read -p "Press <enter> to continue..." ;;

  "3") tput setf 3
  echo $TST3
  tput sgr0
  echo 
  rpm --verify --query --all 'libav*' 'libpostproc*' 'libswscale*'
  echo
  echo "No report is good, though not all problems are bad."
  echo
  read -p "Press <enter> to continue..." ;;

  "4") tput setf 3
  echo $TST4
  tput sgr0
  echo 
  rpm --query --queryformat '%{NAME}-%{VERSION}-%{RELEASE}-%{ARCH} -> %{VENDOR}\n' libxine1 libxine1-codecs
  echo
  read -p "Press <enter> to continue..." ;;
 
  "5") tput setf 3
  echo $TST5
  tput sgr0
  echo 
  rpm --verify --query --all '*xine*'
  echo
  read -p "Press <enter> to continue..." ;;

  "6") tput setf 3
  echo $TST6
  tput sgr0
  echo 
  rpm --query --queryformat '%{NAME}-%{VERSION}-%{RELEASE}-%{ARCH} -> %{VENDOR}\n' gstreamer-0_10-ffmpeg gstreamer-0_10-fluendo-mp3 gstreamer-0_10-fluendo-mpegdemux gstreamer-0_10-fluendo-mpegmux gstreamer-0_10-plugins-bad gstreamer-0_10-plugins-base gstreamer-0_10-plugins-good gstreamer-0_10-plugins-good-extra gstreamer-0_10-plugins-ugly
  echo
  read -p "Press <enter> to continue..." ;;

  "7") tput setf 3
  echo $TST7
  tput sgr0
  echo 
  rpm --verify --query --all '*gst*'
  echo
  echo "No report is good, though not all problems are bad."
  echo
  read -p "Press <enter> to continue..." ;;

  "8") tput setf 3
  echo $TST8
  tput sgr0
  echo 
  rpm --verify MPlayer
  echo
  echo "No report is good, though not all problems are bad."
  echo
  read -p "Press <enter> to continue..." ;;

  "9") tput setf 3
  echo $TST9
  tput sgr0
  echo 
  rpm --verify --query --all '*vlc*'
  echo
  echo "No report is good, though not all problems are bad."
  echo
  read -p "Press <enter> to continue..." ;;

  "10") tput setf 3
  echo $TSTA
  echo 
  rpm --verify w32codec-all
  tput sgr0
  echo
  echo "Note that this package only adds support for some rare formats, and only"
  echo "works on 32bits systems.  On a x86-64 system it will not make any difference."
  echo
  read -p "Press <enter> to continue..." ;;

  "0") tput clear
  tput setf 2
  tput bold
  echo
  echo "To avoid problems... the most important thing I can say to you: even if YaST/zypper/updater gives you such an option...  ***NEVER*** "
  echo "ignore a dependency. Change vendor is ok, ignore dependencies is never is a good idea. See the following forum post for more details."
  echo
  echo "http://forums.opensuse.org/english/get-help-here/multimedia/400119-check-your-multimedia-problem-ten-steps.html#post1898049"
  tput sgr0
  echo
  exit 0 ;;

  *) ;;

esac

done 

exit 0

# End of Bash File

