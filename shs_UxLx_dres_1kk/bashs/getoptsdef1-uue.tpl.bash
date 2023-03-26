##__  #!/bin/bash
##-- obsolete getoptsdef1  from evEnv!

#################### basic-readins/getopts-funcs: ... used also by other funcs/basicScripts,....: ###################
##=================getoptsdef1 : is now obsolete! use getoptsdef3 ! ========================
##--!!-obs-   !!Obsolete!! use getoptsdef3 instead!!  150426
##-- readin default-cmdline-options IF not ANY othter options neccessary!! otherwise not OK!!:
##--II-USAGE:  getoptsdef1 $@ ; shift $(($OPTIND - 1)) ;
##--  call the above line before your cmline-processing! if want, preset following vars in caller-script! the shift command MUST happen in the CALLER-script and not here inside the function!
##--  if more optstrings are needed, then do NOT use this, but their own getopts one! a recursive call of getopts is too complicated und error-prone!!
##--!!- here ONLY the FLAGS are set and NOTHING else happens! so eg creating/handling logfiles, doing simulation or making verbose are the 2do tasks of the CALLING-script and NOT this func!!
##--II- define your $USAGE1 in your script. it is included here in the error-msg!
getoptsdef1(){
	##--II- do NOT use declare here!! When used in a function, `declare' makes NAMEs local, as with the `local' command!! help declare
	usage11="optional-standard-params, if implemented:  -l create-log-file , -s only-simulate-dry-run , -v verbose , -p and -w [optional-param-str with one expected argument, forwarded to the caller]" ;
	myFN=${myFN:-${0##*/}}
	tstamp="${tstamp:-$($cudts)}"
	logFN="${logFN:-/dev/null}"
	logit=${logit:-0}
	simulit=${simulit:-0}         ##--I-  0==NOT-set /NOT-simulation, real-executing
	verboseit=${verboseit:-0}     ##--I-  0==NOT-set /NOT-verbose
	interact11=${interact11:-0}   ##--I-  0==NOT-set /NOT-interactive
	##============ cmdline-params-readin with getopts : =========================
	while getopts "lsvip:" optparam ; do
		##__ echo "$optparam  ====== $OPTARG ";
		case $optparam in
			##-?- e) simulit=0   ;; ##-I- execute.it / NO.simulation, NO.test
			l  ) logFN="${tstamp}-${myFN}.log" ; logit=1 ;; ##--I- logit to a logfile
			s  ) simulit=1 ;; ##__  echo "==========!! SIMULATION ! this is ONLY a dry run !!=========="  ;; ##-I- only.simulation , dry, NO.real.execution!
			v  ) verboseit=1 ;;
			i  ) interact11=1 ;;
			p  ) para11="$OPTARG";; ##-I- place-holder-1 for any individaul-additional-params for the caller-script. argument-value saved in para11 accessible to the caller-script.
			w  ) para12="$OPTARG";; ##-I- place-holder-2 for any individaul-additional-params for the caller-script. argument-value saved in para12 accessible to the caller-script.
			\? ) echo "==##== Error: wrong parameters. $USAGE1 , $usage11" ; exit 3  ;;
		esac
	done
	##=====-END-== cmdline-params-readin with getopts : =========================
}
##--!!-  makes NO use here:  "shift $(($OPTIND - 1))" ; It MUST happen in the CALLER-script! here it works ONLY on this function params and NOT on caller-script params!!
##__ myFN=nnnn ; tstamp=110823 ; logFN=log111 ; logit=21 ; simulit=25 ; verboseit=27;
##__ (( $verboseit > 0 )) && echo "__ logFN: $logFN -- logit: $logit --  simulit: $simulit -- verboseit: $verboseit -- para11: $para11  __"
##--I- echo "now process the normal cmdline-arguments of the script ..."
##===== __1END__ getoptsdef1 ---------------------------------

