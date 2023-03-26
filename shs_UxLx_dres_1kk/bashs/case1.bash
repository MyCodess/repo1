#!/bin/bash
##--I-  diff ;;  <->  ;&   <->   ;;&  at the end of each match.cmd.list!!
## ;;	: continue with next loop.run
## ;&	: keep.on current.loop.run with cmd.lis in the next xx)
## ;;&	: keep.on current.loop.run the next possible match, if any! basically eith *) then defining a always.run.cmd.list !!


cd ${usersVarTestsDP}
dirlist1=$(ls)

for ii in $dirlist1 ; do
	case $ii in
		varau) echo "======= $ii ---" ;;&
		varsys) echo "__ $ii ---" ;;
		*) echo "== $ii --" ;;
	esac
done

