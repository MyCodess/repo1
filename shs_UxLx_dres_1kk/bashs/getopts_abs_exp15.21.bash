#!/bin/bash
# Example 15-21. Using getopts to read the options/arguments passed to a script
# ex33.sh: Exercising getopts and OPTIND Script modified 10/09/03 at the suggestion of Bill Gradwohl.
##--II-  modified-kk


# Here we observe how 'getopts' processes command-line arguments to script.
# The arguments are parsed as "options" (flags) and associated arguments.

##-- kk: try also both following and compare:
##+  $0   -s -o -n -m -r -p -q qqqq aa bb
##+  $0   -sonmrpq qqqq aa bb              ##--I-here sou see the index-numbering depends on how also options are formatted on cmdline!
##+  $0   -s -o -n -m -q -p qqqq aa bb     ##--!!-here you see, next param to -p will be taken as argument, even if it is an option!! see bash-nts !
##+  $0   -s -o -n  aa bb  -m -p           ##--!!-here you see, getopts finishes parsing of cmdline by the FIRST non-option/non-option-argument! so any options after positional params are ignored/not-parsed!!

# Try invoking this script with:
#   'scriptname -mn'
#   'scriptname -oq qOption' (qOption can be some arbitrary string.)
#   'scriptname -qXXX -r'
#
#   'scriptname -qr'
#+      - Unexpected result, takes "r" as the argument to option "q"
#   'scriptname -q -r'
#+      - Unexpected result, same as above
#   'scriptname -mnop -mnop'  - Unexpected result
#   (OPTIND is unreliable at stating where an option came from.)
#
#  If an option expects an argument ("flag:"), then it will grab
#+ whatever is next on the command-line.

NO_ARGS=0
E_OPTERROR=85

if [ $# -eq "$NO_ARGS" ]    # Script invoked with no command-line args?
then
	echo "Usage: `basename $0` options (-mnopq<arg>rs)"
	exit $E_OPTERROR          # Exit and explain usage.
	# Usage: scriptname -options
	# Note: dash (-) necessary
fi


while getopts ":mnopq:rs" Option   ##--II-  silent error reporting!  If the first character of OPTSTRING is a colon, getopts uses silent error reporting-
do
	case $Option in
		m     ) echo "Scenario #1: option -$Option-   [OPTIND=${OPTIND}]";;
		n | o ) echo "Scenario #2: option -$Option-   [OPTIND=${OPTIND}]";;
		p     ) echo "Scenario #3: option -$Option-   [OPTIND=${OPTIND}]";;
		q     ) echo "Scenario #4: option -$Option-   with argument \"$OPTARG\"   [OPTIND=${OPTIND}]";;
		#  Note that option 'q' must have an associated argument, otherwise it falls through to the default.
		r | s ) echo "Scenario #5: option -$Option-   [OPTIND=${OPTIND}]";;
	*     ) echo "Unimplemented option chosen: -${OPTARG} (but silent-error-reporting-mode)";;   # Default.
	esac
done

shift $(($OPTIND - 1))
echo "______ OPTIND after handling getopts-options: $OPTIND _____________"
echo "______ positional params if any: $@            ____________________"
#  Decrements the argument pointer so it points to next argument.
#  $1 now references the first non-option item supplied on the command-line
#+ if one exists.

exit $?

#   As Bill Gradwohl states,
#  "The getopts mechanism allows one to specify:  scriptname -mnop -mnop
#+  but there is no reliable way to differentiate what came  from where by using OPTIND."
#  There are, however, workarounds.

