#!/bin/ksh

#
# pn_month YYYYMM (+|-)mm -> YYYYMM
#
# Die Funktion pn_month berechnet Jahr u. Monat vom gegebenen Jahr u. Monat
# plus oder minus der gegebenen Monate
#
function pn_month {
  typeset ym=$1 pn=$2 x n
  (( x = ym % 100 + pn ))

  if (( x > 0 ))
  then (( n = (x-1) / 12 ))
  else (( n = - (12-x) / 12 ))
  fi
  
  printf "%s\n" $(( ym + pn + 88*n ))
}

#
# end_month YYYYMM -> YYYYMMDD
#
# Die Funktion end_month ermittelt den letzten Tag des gegebenen Monats
#
function end_month {
  typeset ym=$1 y m ld
  ((  y = ym  / 100 ))
  ((  m = ym  % 100 ))
  for ld in $(cal $m $y); do :; done
  printf "%s\n" $(( ym*100 + ld ))
}

#
# pn_day YYYYMMDD (+|-)dd -> YYYYMMDD
#
# Die Funktion pn_day berechnet Jahr, Monat u. Tag vom gegebenen Jahr, Monat
# u. Tag plus oder minus der gegebenen Tage
#
function pn_day {
  typeset ymd=$1 pn=${2:-0} ym y m d x

  ((  d = ymd % 100 ))
  (( ym = ymd / 100 ))
  ((  y = ym  / 100 ))
  ((  m = ym  % 100 ))

  if (( pn < 0 )); then
    if (( d > 1 )); then
      (( x = ymd - 1 ))
      (( x > 17520902 && x < 17520914 )) && (( x = 17520902 ))
      pn_day $x $(( pn + 1 ))
    else
      pn_day $(end_month $(pn_month $ym -1)) $(( pn + 1 ))
    fi
  elif (( pn > 0 )); then
    if (( ymd < $(end_month $ym) )); then
      (( x = ymd + 1 ))
      (( x > 17520902 && x < 17520914 )) && (( x = 17520914 ))
      pn_day $x $(( pn - 1 ))
    else
      pn_day $(( 100*$(pn_month $ym +1) + 1 )) $(( pn - 1 ))
    fi
  else
    printf "%s\n" $ymd
    return 0
  fi
}

#
# pn_day_nr YYYYMMDD (+|-)dd -> YYYYMMDD
#
# Die Funktion pn_day_nr berechnet Jahr, Monat u. Tag vom gegebenen Jahr, Monat
# u. Tag plus oder minus der gegebenen Tage
# Diese Funktion ist identisch zur Funktion pn_day, aber sie arbeitet nicht
# rekursiv
#
function pn_day_nr {
  typeset ymd=$1 pn=${2:-0}

  function pn_day1 {
    typeset ymd=$1 pn=$2 d ym x
    ((  d = ymd % 100 ))
    (( ym = ymd / 100 ))
    if (( pn == -1 )); then
      if (( d > 1 )); then
        (( x = ymd - 1 ))
        (( x > 17520902 && x < 17520914 )) && (( x = 17520902 ))
      else
        x=$(end_month $(pn_month $ym -1))
      fi
    elif (( pn == +1 )); then
      if (( d < 28 )) || (( ymd < $(end_month $ym) )); then
        (( x = ymd + 1 ))
        (( x > 17520902 && x < 17520914 )) && (( x = 17520914 ))
      else
        x=$(( 100*$(pn_month $ym +1) + 1 ))
      fi
    fi

    printf "%s\n" $x
    return 0
  }

  while (( pn != 0 )); do
    if (( pn < 0 ))
    then ymd=$(pn_day1 $ymd -1); (( pn = pn + 1 ))
    else ymd=$(pn_day1 $ymd +1); (( pn = pn - 1 ))
    fi
  done

  printf "%s\n" $ymd
  return 0
}

#
# days_between YYYYMMDD YYYYMMDD -> ddd
#
# Die Funktion days_between berechnet die Anzahl Tage zwischen zwei gegebenen
# Daten
#
function days_between {
  typeset a=$1 b=$2 days=0
  (( a > b )) && eval a=$b b=$a

  while (( a < b )); do
    b=$(pn_day_nr $b -1)
    (( days = days + 1 ))
  done

  printf "%s\n" $days
  return 0
}

#
# cur_weekday YYYYMMDD -> w (0-So, 1-Mo, 2-Di,..., 6-Sa)
#
# Die Funktion cur_weekday ermittelt den Wochentag fuer das gegebene Datum
# (0-So, 1-Mo, 2-Di, 3-Mi, 4-Do, 5-Fr, 6-Sa)
#
function cur_weekday {
  typeset ymd=$1 ym y m d i
  (( ymd >= 17520914 && ymd <= 17520930 )) && (( ymd = ymd - 11 ))
  ((  d = ymd % 100 ))
  (( ym = ymd / 100 ))
  ((  y = ym  / 100 ))
  ((  m = ym  % 100 ))
  cal $m $y | while read i; do
    set -- $i
    [[ $1 == 1 ]] && { 
      printf "%s\n" $(( ( 13 + d - $# ) % 7 ))
      break
    }
  done
}

#
# pn_weekday (+)YYYYMMDD w (+|-)x -> YYYYMMDD
#
# Die Funktion pn_weekday berechnet das Datum des x'ten Aufretens des gegebenen
# Wochentages w in Bezug auf das gegebene Datum. Ist x negativ, dann wird ein
# kleineres Datum gesucht, sonst ein groesseres. Ist dem gegebenen Datum ein
# + vorangestellt, dann kann es auch das gegebene Datum selbst sein.
# w hat die Werte 0-So, 1-Mo, 2-Di, 3-Mi, 4-Do, 5-Fr u. 6-Sa. 
#
function pn_weekday {
  typeset ymd=$1 weekday=$2 pn=${3:-0} i x found=0 IN=0
  [[ $ymd == +* ]] && IN=1

    if (( pn < 0 ))
  then (( sign = -1 ))
  elif (( pn > 0 ))
  then (( sign = +1 ))
  else (( sign =  0 ))
  fi

  (( i = pn*sign*7 ))

  while (( i > 0 )); do
    (( IN == 0 )) && ymd=$(pn_day $ymd $sign)

    if [[ -z $x ]]
    then x=$(cur_weekday $ymd)
    else (( x = (x+1) % 7 ))
    fi

    (( x == weekday )) && {
      (( found = ymd ))
    }

    (( IN == 1 )) && ymd=$(pn_day $ymd $sign)
    (( i = i -1 ))
  done

  printf "%s\n" $found
  return 0
}

#
# Main: Testrahmen der Zeitfunktionen
#
for i in -9 -8 -7 0 3 4 5; do pn_month 200508 $i; done      

pn_month 200508 -835
pn_month 200508 -836

end_month 200501
end_month 200502

pn_day 20050102 -1
pn_day 20050102 -2
pn_day 20050102 -3

pn_day 17520902 +1
pn_day 17520914 -1

pn_day_nr 20050102 -1
pn_day_nr 20050102 -2
pn_day_nr 20050102 -3

pn_day_nr 17520902 +1
pn_day_nr 17520914 -1

cur_weekday 20050815
cur_weekday 17520914

pn_weekday +20050801 1 3

days_between 20050801 20061215
days_between 20061215 20050801

