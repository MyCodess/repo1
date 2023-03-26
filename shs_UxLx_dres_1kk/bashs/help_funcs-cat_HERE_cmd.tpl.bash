#!/bin/bash

export var11="__Test_Variable_1__"

##==========================================================================================
echo;
cat <<-'nts1'
	----------------------------------------------------------------------------------------
	Explanation (from: bash Quick Reference , OReilly, 2006) of HERE document / HERE String:

	cmd << text
	The contents of the shell script up to a line identical to text become the standard input
	for cmd (text can be stored in a shell variable). This command form is sometimes called
	a here document. Input is usually typed at the keyboard or in the shell program. Com-
	mands that typically use this syntax include cat, ex, and sed. (If <<- is used, leading
	tabs are stripped from the contents of the here document, and the tabs are ignored
	when comparing input with the end-of-input text marker.) If any part of text is quoted,
	the input is passed through verbatim. Other wise, the contents are processed for variable,
	command, and arithmetic substitutions.
	
	cmd <<< word
	Supply text of word, with trailing newline, as input to cmd. (This is known as a here
	string, from the free version of the rc shell.)
	----------------------------------------------------------------------------------------
nts1


##==========================================================================================
show_help1(){
cat <<TXT11

------------ help1 : ----------------------------
HERE-doc-with-shell-replacements
cat-without-any-modifications:
line1 aaa bbb $var11
line2 aaa bbb \$var11
line3 \
	tabbed-line-1
	tabbed-line-2
------------ help1-END --------------------------

TXT11
}

show_help1;

##==========================================================================================
show_help3(){
cat <<"TXT11"

------------ help3 : ----------------------------
HERE-doc-withOUT-shell-replacements
cat-with-"...":
line1 aaa bbb $var11
line2 aaa bbb \$var11
line3 \
	tabbed-line-1
	tabbed-line-2
------------ help3-END --------------------------

TXT11
}

show_help3;

##==========================================================================================
show_help5(){
cat <<-TXT11

------------ help5 : ----------------------------
HERE-doc-ignore-TABS-...
cat-with-"-" :
line1 aaa bbb $var11
line2 aaa bbb \$var11
line3 \
	tabbed-line-1
	tabbed-line-2
------------ help5-END --------------------------

TXT11
}

show_help5;

##==========================================================================================

