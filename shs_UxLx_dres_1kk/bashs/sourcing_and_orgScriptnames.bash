#!/bin/bash

##--II- dot.sourcing of scripts and original names of the invoked script:
#- problem: ususally u get "bash" OR "sh" as $0 instead of the original script-name, if the script was dot.sourced.
#- solution: ${BASH_SOURCE[0]}  always shows the original-script-name invoked!!:
#- invokation: call this script dot.sourced and not dot.source with a few params as:
#	. $0 aa bb cc  #AND  $0 aa bb cc 

echo "============== BASH_SOURCE : ============"
echo "=== ${BASH_SOURCE[0]}"
echo "=== ${BASH_SOURCE[*]}"
echo "=== ${#BASH_SOURCE[*]}"
echo "=== ${BASH_SOURCE[@]}"
echo "=== ${#BASH_SOURCE[@]}"

echo "============== std-params : ok if NOT dot.sourcing ==========="
echo "=== $0"
echo "=== $@"
echo "=== $*"
echo "=== $@"

