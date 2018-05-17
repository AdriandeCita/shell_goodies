#!/bin/bash

cd ~/Downloads;
file=`ls | grep avocode | tail -1`;
url="https://avocode.com/download";
tempFolder='1';
avocodeDirectory='../soft/avocode';

if [[ ! -z $file ]]
then
    while [ -d $tempFolder ]
    do
        tempFolder="${tempFolder}1"
    done

    if [ -d $avocodeDirectory ]
    then
        unzip $file -d $tempFolder;
        cp -rf ./$tempFolder/* $avocodeDirectory/;
        rm -rf $tempFolder;
        rm -f $file;

        echo 'All OK';
        exit;

    else
        echo 'No destination found. Aborted';
        exit 1;
    fi

else
    echo 'No downloaded avocode versions found!'
    if which xdg-open > /dev/null
    then
      xdg-open $url
    elif which gnome-open > /dev/null
    then
      gnome-open $url
    fi
fi
