#!/bin/bash
## uu1: src: Linux Cookbook, 11.2004, By Carla Schroder : http://tuxcomputing.com/cookbook/rpm-orphan-find
## rpm-orphan-find, a script that finds
## orphaned libs on an RPM-based system
## and rolls them into a virtual .rpm
## written by Paul Heinlein and Peter Samuelson
## Copyright 2003
## You may use, distribute or modify this
## program under the terms of the GPL.
OS=$(uname -s)
LIBS="/lib /usr/lib $(cat /etc/ld.so.conf)"
NAME=$(echo ${OS}-base-libs | tr '[A-Z]' '[a-z]')
VER=1.0; REL=1
TMPSPEC=$(mktemp /tmp/${NAME}.spec.XXXXXX)

exec 9>$TMPSPEC

cat <<__eof__ >&9
Summary: $OS Base Virtual Package
Name: $NAME
Version: $VER
Release: $REL
Group: System Environment/Base
License: None
__eof__

found=0; orphan=0;
echo "Scanning system libraries $NAME version $VER-$REL..."
find $LIBS -type f \( -name '*.so.*' -o -name '*.so' \) |
while read f
do
  ((found++))
  if ! rpm -qf $f >/dev/null 2>&1
  then
    ((orphan++))
    echo "Provides: $(basename $f)" >&9
  fi
  echo -ne "Orphans found: $orphan/$found...\r"
done
echo ''; echo ''

cat <<__eof__ >&9

%description
This is a virtual RPM package.  It contains no
actual files.  It uses the 'Provides' token from RPM 3.x and later to list many of the sharedlibraries that are part of the base operating system and associated subsets for this $OS environment.

%prep
# nothing to do

%build
# nothing to do

%install
# nothing to do

%clean
# nothing to do

%post
# nothing to do

%files

__eof__

exec 9>&-
rpmbuild -ba $TMPSPEC; rm $TMPSPEC

#Note that rpmbuild has replaced rpm. 
#The old RPM commands often still work,
#because they are aliased in /etc/popt.
#Run rpm --version to see what you have.
#If you have an older version of RPM,
#edit the last line of the script:
#rpm -bb $TMPSPEC; rm $TMPSPEC
