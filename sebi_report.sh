#!/bin/sh

## usage /bin/sh sebi_report.sh NETCORE_SEBI_DLR_20151225_test.txt SEBI_Srinagar.csv

echo `date "+%d-%m-%Y %H:%M:%S"`
NANO=`date '+%s%N'`

## some random number as suffix for file names 
RANDOM=`echo $NANO | openssl dgst -whirlpool | sed 's/(stdin)= //g' | cut -c 1-16`
RAW_FILE=$1
MOBILE_LIST_FILE=$2
export LC_ALL=C

## extract date from first file in the raw file
RPT_DATE=`head -n1 $RAW_FILE | awk -F'|' '{print $4}'| awk -F' ' '{print $1}'`
RPT_UNIQ_MOB=0
## total records in raw file = total SMS sent whether failed or delivered
RPT_TOTAL_SMS=`cat $RAW_FILE | wc -l`
RPT_DELV=0

## prepare a file with only unique mobile number from raw file
cat $RAW_FILE | awk -F'|' '{print $2}' | sed 's/^91//g' | sort -n | uniq -u > $RAW_FILE.sorted.$RANDOM

## prepare a file with only unique mobile number but delivered ones only
cat $RAW_FILE | awk -F'|' '{print $2" "$6}' | grep "DELIVERD" |  sed 's/^91//g' |  awk -F' ' '{print $1}' | sort -n > $RAW_FILE.sorted.Delivered.$RANDOM

## sort mobile list file for fast comparison
cat $MOBILE_LIST_FILE | sort -n  > $MOBILE_LIST_FILE.sorted.$RANDOM

## get intersection of both files (items present in both files)
comm -12 $RAW_FILE.sorted.$RANDOM $MOBILE_LIST_FILE.sorted.$RANDOM > city_nos_in_raw.txt.$RANDOM

## count of city mobile nos to whom SMS was sent
RPT_UNIQ_MOB=`cat city_nos_in_raw.txt | wc -l`

echo `date "+%d-%m-%Y %H:%M:%S"`

## get count of SMS with delivered status for mobile nos found in city_nos_in_raw.txt against list of delivered nos

RPT_DELV=`join city_nos_in_raw.txt.$RANDOM $RAW_FILE.sorted.Delivered.$RANDOM | uniq -c | awk '{sum+=$1} END {print sum}'`
#RPT_DELV=`grep  -Fxf city_nos_in_raw.txt.$RANDOM $RAW_FILE.sorted.Delivered.$RANDOM | uniq -c | awk '{sum+=$1} END {print sum}'`

## output report
echo "\n\n+++++++++++++Generating report+++++++"
echo "Date,File_name/City,Unique mobile number to whom msg pushed,Total sms pushed count,SMS Delivered count"
echo $RPT_DATE","$RAW_FILE","$RPT_UNIQ_MOB","$RPT_TOTAL_SMS","$RPT_DELV
echo "+++++++++++++++++++++++++++++++++++++"
echo "\n\n"
echo `date "+%d-%m-%Y %H:%M:%S"`

rm -rf *.$RANDOM
