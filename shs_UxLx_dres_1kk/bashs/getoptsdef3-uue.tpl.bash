#!/bin/bash
##-- see the latest version in uue-etc/funcs.sh , here just only a copy but not always uptodate !!

##=================getoptsdef3 ========================
##-- read-in/process default-cmdline-options [-vlsi] ,if implemented, AND also additiona caller-defined-options !! otherwise not OK!!:
##-- try/test-it (try following eg to see its output):
	#-  opt11=m arg11=g   $0  -lsvmi -g aa
	#-  opt12=m arg13=g   $0  -lsvmi -g aa
	#-  opt12=m arg13=g   $0  -lsvkmi -g aa
	#-  opt11=k   opt12=m arg13=g   $0  -lsvkmi -g aa
##-- USAGE:
	#- if ONLY the uue--standard-options (now -lsvi ) are needed then just:   getoptsdef3 $@ ; shift $(($OPTIND - 1)) ;
	#- but if additional cmdline-options are needed then preset the caller-added-opts before calling the above line, as eg for [-fg -w <arg1>]: export opt11=f  opt12=g  opt11_val=0  opt12_val=0 arg11=w arg11_val="nothing" ...; #and then:
	#- /OR preset the  "optstr11" completely before invoking getoptsdef3  $@  ,as eg:  export optstr11="lgwt" ; getoptsdef3 $@ ; shift $(($OPTIND - 1)) ;
	#- then the values for the above added options are saved in:   opt11_val  opt12_val  arg11_val  ...
	#-!!-  the shift command MUST happen in the CALLER-script and not here inside the function!
	#-!!-  do NOT use additional getopts-call in your script, because a recursive call of getopts is too complicated und error-prone!! so if needed, thenuse your own getopts only!!
##--!!- here ONLY the FLAGS are set and NOTHING else happens! so eg creating/handling logfiles, doing simulation or making verbose are the 2do tasks of the CALLING-script and NOT this func!!
##--II- define your $USAGE1 in your script. it is included here in the error-msg!
getoptsdef3(){
	optstr11_def="lsvi"
	optstr11_def_user="lsvi${opt11}${opt12}${opt13}${arg11:+${arg11}:}${arg12:+${arg12}:}${arg13:+${arg13}:}"
	optstr11=${optstr11:-"${optstr11_def_user}"}
	##--II- do NOT use declare here!! When used in a function, `declare' makes NAMEs local, as with the `local' command!! help declare
	usage11="optional-standard-params, if implemented are [-${optstr11_def}] as:  -l create-log-file , -s only-simulate-dry-run , -v verbose , -i interactive";
	myFN11=${myFN11:-${0##*/}}
	tstamp11="${tstamp11:-$($cudts)}"
	logFN11="${logFN11:-/dev/null}"
	logit11=${logit11:-0}
	simulit11=${simulit11:-0}         ##--I-  0==NOT-set /NOT-simulation, real-executing
	verboseit11=${verboseit11:-0}     ##--I-  0==NOT-set /NOT-verbose
	interact11=${interact11:-0}   ##--I-  0==NOT-set /NOT-interactive
	##============ cmdline-params-readin with getopts : =========================
	while getopts "${optstr11}" optparam ; do
		##__ echo "$optparam  ====== $OPTARG ";
		case $optparam in
			##-?- e) simulit11=0   ;; ##-I- execute.it / NO.simulation, NO.test
			l  ) logFN11="${tstamp11}-${myFN11}.log" ; logit11=1 ;; ##--I- logit11 to a logfile
			s  ) simulit11=1 ; echo "==========!! SIMULATION ! this is ONLY a dry run !!=========="  ;; ##-I- only.simulation , dry, NO.real.execution!
			v  ) verboseit11=1 ;;
			i  ) interact11=1 ;;
			$opt11  ) export opt11_val=1 ;;   ##__ echo opt11-set==$opt11 ;;
			$opt12  ) export opt12_val=1 ;;   ##__ echo opt12-set==$opt12 ;;
			$opt13  ) export opt13_val=1 ;;   ##__ echo opt13-set==$opt13 ;;
			$arg11  ) arg11_val="$OPTARG";;   ##-I- place-holder-1 for any individaul-additional-params for the caller-script. argument-value saved in para11 accessible to the caller-script.
			$arg12  ) arg12_val="$OPTARG";;   ##-I- place-holder-2 for any individaul-additional-params for the caller-script. argument-value saved in para11 accessible to the caller-script.
			$arg13  ) arg13_val="$OPTARG";;   ##-I- place-holder-3 for any individaul-additional-params for the caller-script. argument-value saved in para11 accessible to the caller-script.
			##__prev:  z | $opt11  ) export opt11_val=1 ;;   ##__ echo opt11-set==$opt11 ;;
			##__prev: y | $arg13  ) arg13_val="$OPTARG";;   ##-I- place-holder-3 for any individaul-additional-params for the caller-script. argument-value saved in para11 accessible to the caller-script.
			\? ) echo "==##== Error: wrong parameters. $USAGE1 , $usage11" ; exit 3  ;;
		esac
	done
	##=====-END-== cmdline-params-readin with getopts : =========================
##--!!-  makes NO use here:  "shift $(($OPTIND - 1))" ; It MUST happen in the CALLER-script! here it works ONLY on this function params and NOT on caller-script params!!
##__ (( $verboseit11 > 0 )) && echo "__ logFN11: $logFN11 -- logit11: $logit11 --  simulit11: $simulit11 -- verboseit11: $verboseit11 -- para11: $para11  __"
##--I- echo "now process the normal cmdline-arguments of the script ..."
}
##=====--END--=====getoptsdef3 ========================


getoptsdef3 $@
##--I  setting OPTIND to the index of the first non-option argument(start of the script-values):
shift $(($OPTIND - 1)) ##--II- MUST be outside the func, otherwise the shift works on func-params bur NOT real original script-params!!
(( $verboseit11 > 0 )) && echo "__ logFN11: $logFN11 -- logit11: $logit11 --  simulit11: $simulit11 -- verboseit11: $verboseit11  -- interactive: $interact11 -- opt11: $opt11_val -- opt12: $opt12_val -- opt13: $opt13_val -- arg11: $arg11_val -- arg12: $arg12_val -- arg13: $arg13_val  __________"
##--I- echo "now process the normal cmdline-arguments of the script ..."
echo "$1 -- $2 -----All-Rest-Params: $*"

