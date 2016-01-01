#!/bin/sh
export PGPASSWORD=Psuser321
psql -UXXXXX -hXXXXXXX -p6644 XXXXX -c "COPY (select mobile,count(1) from DDDDDDDDDD WHERE missed_call_time BETWEEN TIMESTAMP '2015-05-15' AND TIMESTAMP 'today' group by mobile) TO STDOUT With CSV" > user_count_raw.csv


awk -F',' 'BEGIN {bucket1=0;bucket2=0;bucket3=0;bucket4=0;bucket5=0;bucket6=0;} {
if($2 >=1 && $2 <=100) bucket1++;
if($2 >=101 && $2 <=200) bucket2++;
if($2 >=201 && $2 <=300) bucket3++;
if($2 >=301 && $2 <=400) bucket4++;
if($2 >=401 && $2 <=500) bucket5++;
if($2 >=501) bucket6++; } END {
	print "0-100,"bucket1;
	print "101-200,"bucket2;
	print "201-300,"bucket3;
	print "301-400,"bucket4;
	print "400-500,"bucket5;
	print ">501,",bucket6;
}' user_count_raw.csv > users_call_histogram.csv


awk -F',' 'BEGIN{buckets} {for(i=0;i<NR;i++) {switch($2) {
	case "$2":
	buckets[$2]=buckets[$2]+1;
	break;
}
}
}END {
	for(key in buckets) {
	    print key, buckets[key]
	  }
}' user_count_raw.csv
