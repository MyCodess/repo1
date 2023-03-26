#! /bin/ksh
# sort inputfile-line based on line-length
# USAGE: $0 <filenames....>

USAGE1="USAGE:  $0  <filenames....>"

[[ $# = 0 ]] && echo "---!!! Sorry, too few parameters,  $USAGE1" && return 1

nawk 'BEGIN { FS=RS } { print length, $0 }' $* |
# Sort the lines numerically
sort +0n -1 |
# Remove the length and the space and print each line
sed 's/^[0-9][0-9]* //'

