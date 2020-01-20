#!/bin/sh

if [[ $1 ]];
then
    input_file=$1;
else
    echo "Usage:";
    echo "$0 input_file [ output_file ]";
    exit 1;
fi

if [[ $2 ]];
then
    output_file="$1";
else
    output_file="export.fin.csv"
fi

if [ -f $output_file ];
then
    echo "Output file already exists. Please specify another output location or clean the current one up.";
    exit 1;
fi

iconv -f CP1251 -t UTF8 $input_file  | awk -F ";" '{
if (FNR == 1) 
    print $3,"/",$4,";",$5,";","МФО та назва банку",";",$9,";","ЄДРПОУ та найменування кореспондента",";",$12,";",$13,";",$14,";",$15,";",$16,";",$17;
else 
    print $3,"/",$4,";",$5,";",$7,",",$8,";",$9,";",$10,",",$11,";",$12,";",$13,";",$14,";",$15,";",$16,";",$17
}' | awk '{gsub(/ ,/,","); print;}' | awk '{gsub(/\s;\s?/,";"); print;}' > $output_file;
libreoffice $output_file;
