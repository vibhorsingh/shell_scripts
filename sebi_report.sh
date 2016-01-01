#!/bin/sh


## usage /bin/sh sebi_report.sh RAW_REPORT_FILE MOBILE_LIST_FILE

echo `date "+%d-%m-%Y %H:%M:%S"`
RAW_FILE=$1
MOBILE_LIST_FILE=$2


RPT_DATE=`head -n1 $RAW_FILE | awk -F'|' '{print $4}'| awk -F' ' '{print $1}'`
RPT_UNIQ_MOB=0
RPT_TOTAL_SMS=`cat $RAW_FILE | wc -l`
RPT_DELV=`cat $RAW_FILE | grep "DELIVERD" | wc -l`



cat $RAW_FILE | awk -F'|' '{print $2}' | sed 's/^91//g' | sort -n | uniq -u > $RAW_FILE.sorted

cat $MOBILE_LIST_FILE | sort -n  > $MOBILE_LIST_FILE.sorted

RPT_UNIQ_MOB=`comm -12 $RAW_FILE.sorted $MOBILE_LIST_FILE.sorted | wc -l`

#while read line 
#do count=`grep $line $RAW_FILE | wc -l`; 
#    RPT_UNIQ_MOB=$((RPT_UNIQ_MOB+count));
#done < $MOBILE_LIST_FILE


echo "\n\n+++++++++++++Generating report+++++++"
echo "Date,File_name/City,Unique mobile number to whom msg pushed,Total sms pushed count,SMS Delivered count"
echo $RPT_DATE","$RAW_FILE","$RPT_UNIQ_MOB","$RPT_TOTAL_SMS","$RPT_DELV
echo "+++++++++++++++++++++++++++++++++++++"
echo "\n\n"
echo `date "+%d-%m-%Y %H:%M:%S"`
