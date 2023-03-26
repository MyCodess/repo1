#!/bin/bash
##-- see the latest version in uue-etc/funcs.sh , here just only a copy but not always uptodate !!

##--USAGE:  test this with eg:  $0  -lsv -p ppp -w www aa bb cc dd 
getoptsdef1(){
	##--II- do NOT use declare here!! When used in a function, `declare' makes NAMEs local, as with the `local' command!! help declare
	##--II- the main usage will be declared by the caller-script saved in $USAGE1 before calling this func!
	usage11="optional-standard-params:  -l create-log-file , -s only-simulate-dry-run , -v verbose , -p and -w [optional-param-str with one expected argument, forwarded to the caller]" ;
	myFN=${myFN:-${0##*/}}
	tstamp="${tstamp:-$($cudts)}"   ##--OR- $(date  +%Y-%m-%d)
	logFN="${logFN:-/dev/null}"
	logit=${logit:-0}
	simulit=${simulit:-0}  ##-I- simulation or real.execution??
	verboseit=${verboseit:-0}

	##============ cmdline-params-readin with getopts : =========================
	while getopts "lsvp:w:" optparam ; do
		##__ echo "$optparam  ====== $OPTARG ";
		case $optparam in
			##-?- e) simulit=0   ;; ##-I- execute.it / NO.simulation, NO.test
			l  ) logFN="${tstamp}_${myFN}.log" ; logit=1 ;; ##--I- logit to a logfile
			s  ) simulit=1 ;  echo "==========!! SIMULATION ! this is ONLY a dry run !!=========="  ;; ##-I- only.simulation , dry, NO.real.execution!
			v  ) verboseit=1 ;;
			p  ) param1="$OPTARG";; ##-I- just exp here. dummy for any individ-script-opt
			w  ) param2="$OPTARG";; ##-I- test-params and their indexes!
			\? ) echo "==##== Error: wrong parameters. $USAGE1 , $usage11" ; exit 3 
		esac
	done
##=============END-cmdline-params-readin-- now process normal cdmline-arguments ========##########
}

##__ myFN=nnnn ; tstamp=110823 ; logFN=log111 ; logit=21 ; simulit=25 ; verboseit=27;
getoptsdef1 $@
##--I  setting OPTIND to the index of the first non-option argument(start of the script-values):
shift $(($OPTIND - 1)) ##--II- MUST be outside the func, otherwise the shift works on func-params bur NOT real original script-params!!
(( $verboseit > 0 )) && echo "__ logFN: $logFN -- logit: $logit --  simulit: $simulit -- verb: $verboseit -- p-param1: $param1  -- w-param2: $param2 __"
##--I- echo "now process the normal cmdline-arguments of the script ..."
echo "$1 -- $2 -----All-Rest-Params: $*" 

