#!/bin/sh
userName()
{
        # Testen, ob der Benutzer root ist
        if [ -x /usr/xpg4/bin/id ]
        then
                userName==`/usr/xpg4/bin/id -u -n`
        else
                userName=`id | cut -d\( -f2 | cut -d\) -f1`
        fi
}

