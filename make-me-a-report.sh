#!/bin/bash

cd ~/work/styleguide/;

author='Mykola';
if [ -z "$1" ] ;
  then
    nextSunday=`date -I -d "next Sunday"`;
    lastWorkingDay=`date -d "last Sunday"`;
  else
    w=$(date -d"$1" +%w)
    diffForward=$(( (7-$w)%7 ))
    diffBackward=$(( $w%7 ))
    nextSunday=`date -I -d "+$diffForward day $1"`;
    lastWorkingDay=`date -d "-$diffBackward day $1"`;
fi

reportFile="${HOME}/Desktop/$(date +%m-%d-%y)_elif-tech-report.txt"

if [[ $(date +%u) -gt 6 ]] ; then
    nextSunday=`date -I -d`;
fi

# Set date to Monday
lastWorkingDay=$(date -I -d "$lastWorkingDay + 1 day")

# Reset file content
echo '' > ${reportFile};

while [[ "$lastWorkingDay" != ${nextSunday} ]]; do
  echo ${lastWorkingDay} >> ${reportFile};
  git log --author=Mykola --no-merges --after="$(date -d "$lastWorkingDay" +%m-%d-%y) 00:00" --before="$(date -d "$lastWorkingDay + 1 day" +%m-%d-%y) 00:00" >> ${reportFile};
  echo "======================================================" >> ${reportFile};
  echo "" >> ${reportFile};
  lastWorkingDay=$(date -I -d "$lastWorkingDay + 1 day")
done
