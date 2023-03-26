#!/bin/bash

USAGE1="USAGE   :  ${0##*/}  -a <a-option>  -b -c -d <d-option>   <script-params>"
USAGE1+="\nUSAGE eg:  ${0##*/}  -a 11  -b -c  -d44  p1 p2 p3"

readParams1(){
echo;
echo "_____________ Handling getopts Params: ____________________________"
	while getopts "a:bcd:" option1; do
		case $option1 in
			a  ) echo "__a:   optind== $OPTIND , optarg== $OPTARG"  ; avar="$OPTARG" ;;
			b  ) echo "__b:   optind== $OPTIND , optarg== $OPTARG"  ; bvar="$OPTARG" ;;
			c  ) echo "__c:   optind== $OPTIND , optarg== $OPTARG"  ; cvar="$OPTARG" ;;
			d  ) echo "__d:   optind== $OPTIND , optarg== $OPTARG"  ; dvar="$OPTARG" ;;
			\? ) echo -e "==##== Error: wrong parameters.\n$USAGE1" 1>&2 ; exit 3 ;;
		esac
	done
}

readParams1 $@ ;

echo "____ options-vars:   avar==$avar , bvar==$bvar , cvar==$cvar , dvar==$dvar"
echo;
echo "_____________ Handling Scripts Params: ____________________________"
echo "optind== $OPTIND :after finishing getopts-paring!"
##--I  setting OPTIND to the index of the first non-option argument(start of the script-values):
shift $(($OPTIND - 1))    ##--II- MUST be outside the func, otherwise the shift works on func-params bur NOT real original script-params!!
echo "Rest of params, after getopts: $@"
echo "___________________________________________________________________"

