#!/bin/sh


export PGPASSWORD=XXXXX
dir=`date  --date="1 days ago" "+%d-%m-%Y"`
mkdir -p FB_reports/$dir
cd FB_reports/$dir
current=`pwd`

##P# Date_Hour_Total_Missed_calls.csv
psql -UXXXXX -hXXXXX -p6644 XXXXX -c "COPY (SELECT EXTRACT(day FROM missed_call_time) as day,EXTRACT(hour FROM missed_call_time) as hour,count(id) as \"Total-Missed-calls\", count(DISTINCT(mobile)) as \"Unique-Missed-Calls\" FROM XXXXX_missedcall_log  WHERE missed_call_time BETWEEN TIMESTAMP '2015-05-15 09:00:00' AND TIMESTAMP 'today'  GROUP BY day,hour ORDER BY day,hour) TO STDOUT With CSV HEADER" > A.csv
echo "created Date_Hour_Total_Missed_calls-Unique_Missed_calls.csv"

### Date_Hour_Unique_Missed_Calls.csv
#psql -UXXXXX -hXXXXX -p6644 XXXXX -c "COPY (SELECT  	EXTRACT(day FROM missed_call_time) as day,  	EXTRACT(hour FROM missed_call_time) as hour,   	count(DISTINCT(mobile)) as \"Unique Missed Calls\" FROM XXXXX_missedcall_log  WHERE missed_call_time BETWEEN TIMESTAMP '2015-05-15' AND TIMESTAMP 'today'  GROUP BY day,hour ORDER BY hour) TO STDOUT With CSV HEADER" >  Date_Hour_Unique_Missed_Calls.csv
#echo "created Date_Hour_Unique_Missed_Calls.csv"

### Date_Hour_First_time_Missed_calls.csv
psql -UXXXXX -hXXXXX -p6644 XXXXX -c "COPY (SELECT  	EXTRACT(day FROM first_missed_call_time) as day,  	EXTRACT(hour FROM first_missed_call_time) as hour,   	count(id) as \"First-time-Missed-Calls\" FROM XXXXX_user_master  WHERE first_missed_call_time BETWEEN TIMESTAMP '2015-05-15 09:00:00' AND TIMESTAMP 'today'  GROUP BY day,hour ORDER BY day,hour) TO STDOUT With CSV HEADER" >  B.csv
echo "created Date_Hour_First_time_Missed_calls.csv"

awk -F',' 'NR==FNR {h[FNR] = $3; next} {print $1","$2","$3","$4","h[FNR]}' B.csv A.csv > Date_Hour.csv
echo "created Date_Hour.csv"

############P##########
### Date_Circle_Operator_Total_Missed_calls.csv
psql -UXXXXX -hXXXXX -p6644 XXXXX -c "COPY (SELECT  	EXTRACT(day FROM missed_call_time) as day,  	circle as Circle, 	replace(replace(operator,',',''),' ','-') as operator,   	count(id) as \"Total-Missed-calls\", count(DISTINCT(mobile)) as \"Unique-Missed-Calls\" FROM XXXXX_missedcall_log  WHERE missed_call_time BETWEEN TIMESTAMP '2015-05-15 09:00:00' AND TIMESTAMP 'today'  GROUP BY day,circle,operator ORDER BY day,circle,operator) TO STDOUT With CSV HEADER" >  A.csv
echo "created Date_Circle_Operator_Total_Missed_calls.csv"


### Date_Circle_Operator_Unique_calls.csv
#psql -UXXXXX -hXXXXX -p6644 XXXXX -c "COPY (SELECT  	EXTRACT(day FROM missed_call_time) as day,  	circle as Circle, 	operator as Operator,   	count(DISTINCT(mobile)) as \"Unique Missed Calls\" FROM XXXXX_missedcall_log  WHERE missed_call_time BETWEEN TIMESTAMP '2015-05-15 09:00:00' AND TIMESTAMP 'today'  GROUP BY day,circle,operator ORDER BY circle,operator) TO STDOUT With CSV HEADER" >  Date_Circle_Operator_Unique_calls.csv
#echo "created Date_Circle_Operator_Unique_calls.csv"


### Date_Circle_Operator_First_time_Missed_calls.csv
psql -UXXXXX -hXXXXX -p6644 XXXXX -c "COPY (SELECT  	EXTRACT(day FROM first_missed_call_time) as day,  	circle as Circle, 	replace(replace(operator,',',''),' ','-') as operator,   	count(id) as \"First-time-Missed-Calls\" FROM XXXXX_user_master  WHERE first_missed_call_time BETWEEN TIMESTAMP '2015-05-15 09:00:00' AND TIMESTAMP 'today'  GROUP BY day,circle,operator ORDER BY day,circle,operator) TO STDOUT With CSV HEADER" >  B.csv
echo "created Date_Circle_Operator_First_time_Missed_calls.csv"

awk -F',' 'NR==FNR {h[FNR] = $4; next} {print $1","$2","$3","$4","$5","h[FNR]}' B.csv A.csv > Date_Circle_Operator.csv

echo "Date_Circle_Operator.csv"



###########P#############
## DATE_CIRCLE
### date_circle_total_Missed_Calls.csv
psql -UXXXXX -hXXXXX -p6644 XXXXX -c "COPY (SELECT  	EXTRACT(day FROM missed_call_time) as day,  	circle as Circle, count(id) as \"Total-Missed-Calls\", count(DISTINCT(mobile)) as \"Unique-Missed-Calls\" FROM XXXXX_missedcall_log  WHERE missed_call_time BETWEEN TIMESTAMP '2015-05-15 09:00:00' AND TIMESTAMP 'today'  GROUP BY day,circle ORDER BY day,circle) TO STDOUT With CSV HEADER" > A.csv
echo "created date_circle_unique_Missed_Calls.csv"

### date_circle_unique_Missed_Calls.csv
#psql -UXXXXX -hXXXXX -p6644 XXXXX -c "COPY (SELECT  	EXTRACT(day FROM missed_call_time) as day,  	circle as Circle, count(DISTINCT(mobile)) as \"Unique Missed Calls\" FROM XXXXX_missedcall_log  WHERE missed_call_time BETWEEN TIMESTAMP '2015-05-15 09:00:00' AND TIMESTAMP 'today'  GROUP BY day,circle ORDER BY day,circle) TO STDOUT With CSV HEADER" >  date_circle_unique_Missed_Calls.csv
#echo "created date_circle_unique_Missed_Calls.csv"

### date_circle_first_Missed_Calls.csv
psql -UXXXXX -hXXXXX -p6644 XXXXX -c "COPY (SELECT  	EXTRACT(day FROM first_missed_call_time) as day,  	circle as Circle, count(id) as \"First-time-Missed-Calls\" FROM XXXXX_user_master  WHERE first_missed_call_time BETWEEN TIMESTAMP '2015-05-15 09:00:00' AND TIMESTAMP 'today'  GROUP BY day,circle ORDER BY day,circle) TO STDOUT With CSV HEADER" >  B.csv
echo "created date_circle_first_Missed_Calls.csv"

awk -F',' 'NR==FNR {h[FNR] = $3; next} {print $1","$2","$3","$4","h[FNR]}' B.csv A.csv > Date_Circle.csv

echo "created Date_Circle.csv"



############### Date_Operator
### date_operator_total_Missed_Calls.csv
psql -UXXXXX -hXXXXX -p6644 XXXXX -c "COPY (SELECT  	EXTRACT(day FROM missed_call_time) as day, replace(replace(operator,',',''),' ','-') as operator, count(id) as \"Total-Missed-Calls\",count(DISTINCT(mobile)) as \"Unique Missed Calls\" FROM XXXXX_missedcall_log  WHERE missed_call_time BETWEEN TIMESTAMP '2015-05-15 09:00:00' AND TIMESTAMP 'today'  GROUP BY day,operator ORDER BY day,operator) TO STDOUT With CSV HEADER" >  A.csv
echo "created date_circle_unique_Missed_Calls.csv"


### date_operator_unique_Missed_Calls.csv
#psql -UXXXXX -hXXXXX -p6644 XXXXX -c "COPY (SELECT  	EXTRACT(day FROM missed_call_time) as day,  	operator as Operator, count(DISTINCT(mobile)) as \"Unique Missed Calls\" FROM XXXXX_missedcall_log  WHERE missed_call_time BETWEEN TIMESTAMP '2015-05-15 09:00:00' AND TIMESTAMP 'today'  GROUP BY day,operator ORDER BY day,operator) TO STDOUT With CSV HEADER" >  date_operator_unique_Missed_Calls.csv
#echo "created date_operator_unique_Missed_Calls.csv"


### date_operator_first_Missed_Calls.csv
psql -UXXXXX -hXXXXX -p6644 XXXXX -c "COPY (SELECT  	EXTRACT(day FROM first_missed_call_time) as day, replace(replace(operator,',',''),' ','-') as operator, count(id) as \"First-time-Missed-Calls\" FROM XXXXX_user_master  WHERE first_missed_call_time BETWEEN TIMESTAMP '2015-05-15 09:00:00' AND TIMESTAMP 'today'  GROUP BY day,operator ORDER BY day,operator) TO STDOUT With CSV HEADER" >  B.csv
echo "created date_operator_first_Missed_Calls.csv"

awk -F',' 'NR==FNR {h[FNR] = $3; next} {print $1","$2","$3","$4","h[FNR]}' B.csv A.csv > Date_Operator.csv

echo "created Date_Operator.csv"


##################### Date_Total
### Date_Total_Missed_calls.csv
psql -UXXXXX -hXXXXX -p6644 XXXXX -c "COPY (SELECT  	EXTRACT(day FROM missed_call_time) as day,   	count(id) as \"Total-Missed-calls\",count(DISTINCT(mobile)) as \"Unique-Missed-calls\" FROM XXXXX_missedcall_log WHERE missed_call_time BETWEEN TIMESTAMP '2015-05-15 09:00:00' AND TIMESTAMP 'today'  GROUP BY day  ORDER BY day) TO STDOUT With CSV HEADER" >  A.csv
echo "created Date_Total_Missed_calls.csv"


### Date_Unique_Missed_calls.csv
#psql -UXXXXX -hXXXXX -p6644 XXXXX -c "COPY (SELECT  	EXTRACT(day FROM missed_call_time) as day,   	count(id) as \"Unique Missed calls\" FROM XXXXX_missedcall_log WHERE missed_call_time BETWEEN TIMESTAMP '2015-05-15' AND TIMESTAMP 'today'  GROUP BY day  ORDER BY day) TO STDOUT With CSV HEADER" >  Date_Unique_Missed_calls.csv
#echo "created Date_Unique_Missed_calls.csv"


### Date_First_time_Missed_calls.csv
psql -UXXXXX -hXXXXX -p6644 XXXXX -c "COPY (SELECT  	EXTRACT(day FROM first_missed_call_time) as day,   	count(DISTINCT(mobile)) as \"First-time-Missed-calls\" FROM XXXXX_user_master WHERE first_missed_call_time BETWEEN TIMESTAMP '2015-05-15 09:00:00' AND TIMESTAMP 'today'  GROUP BY day  ORDER BY day) TO STDOUT With CSV HEADER" >  B.csv
#echo "created Date_First_time_Missed_calls.csv"

awk -F',' 'NR==FNR {h[FNR] = $2; next} {print $1","$2","$3","h[FNR]}' B.csv A.csv > Date_Total.csv

echo "created Date_Total.csv"



#################### Date-Hour-Min-Sec
## date-hour-min-sec_Total_missed_calls.csv
psql -UXXXXX -hXXXXX -p6644 XXXXX -c "COPY (SELECT EXTRACT(day FROM missed_call_time) as day,  EXTRACT(hour FROM missed_call_time) as hour,  EXTRACT(minute FROM missed_call_time) as minute,  to_char(EXTRACT(second FROM missed_call_time),'99D') as second,   count(id) as \"Total-Missed-calls\",count(DISTINCT(mobile)) as \"Unique-Missed-calls\" FROM XXXXX_missedcall_log  WHERE missed_call_time BETWEEN TIMESTAMP '2015-05-15 09:00:00' AND TIMESTAMP 'today'  GROUP BY day,hour,minute,second ORDER BY day,hour,minute,second) TO STDOUT With CSV HEADER" > A.csv
echo "created date-hour-min-sec_Total_missed_calls.csv"

## date-hour-min-sec_Unique_missed_calls.csv
#psql -UXXXXX -hXXXXX -p6644 XXXXX -c "COPY (SELECT EXTRACT(day FROM missed_call_time) as day,  EXTRACT(hour FROM missed_call_time) as hour,  EXTRACT(minute FROM missed_call_time) as minute,  to_char(EXTRACT(second FROM missed_call_time),'99D') as second,   count(DISTINCT(mobile)) as \"Unique Missed calls\" FROM XXXXX_missedcall_log  WHERE missed_call_time BETWEEN TIMESTAMP '2015-05-15 09:00:00' AND TIMESTAMP 'today'  GROUP BY day,hour,minute,second ORDER BY day,hour,minute,second) TO STDOUT With CSV HEADER" > date-hour-min-sec_Total_missed_calls.csv
#echo "created date-hour-min-sec_Total_missed_calls.csv"

## date-hour-min-sec_first_time_calls.csv
psql -UXXXXX -hXXXXX -p6644 XXXXX -c "COPY (SELECT EXTRACT(day FROM first_missed_call_time) as day,  EXTRACT(hour FROM first_missed_call_time) as hour,  EXTRACT(minute FROM first_missed_call_time) as minute,  to_char(EXTRACT(second FROM first_missed_call_time),'99D') as second,   count(id) as \"First-time-Missed-calls\" FROM XXXXX_user_master WHERE first_missed_call_time BETWEEN TIMESTAMP '2015-05-15 09:00:00' AND TIMESTAMP 'today'  GROUP BY day,hour,minute,second ORDER BY day,hour,minute,second) TO STDOUT With CSV HEADER" > B.csv
echo "created date-hour-min-sec_first_time_calls.csv"

awk -F',' 'NR==FNR {h[FNR] = $5; next} {print $1","$2","$3","$4","$5","$6","h[FNR]}' B.csv A.csv > Date-Hour-Min-Sec.csv
echo "created Date-Hour-Min-Sec.csv"


#################### Overall_counts
## overall_total_missed_calls.csv
psql -UXXXXX -hXXXXX -p6644 XXXXX -c "COPY (SELECT COUNT(b.id) as \"Total-Missed-calls\",COUNT(DISTINCT(b.mobile)) as \"Unique-Missed-calls\" FROM XXXXX_missedcall_log as b WHERE b.missed_call_time BETWEEN TIMESTAMP '2015-05-15 09:00:00' AND TIMESTAMP 'today') TO STDOUT With CSV HEADER" > A.csv
echo "created overall_total_missed_calls.csv"


## overall_total_unique_calls.csv
#psql -UXXXXX -hXXXXX -p6644 XXXXX -c "COPY (SELECT COUNT(b.mobile) as \"Unique Missed calls\" FROM XXXXX_missedcall_log as b) TO STDOUT With CSV HEADER" > overall_total_unique_calls.csv
#echo "created overall_total_unique_calls.csv"

## overall_first_time_calls.csv
psql -UXXXXX -hXXXXX -p6644 XXXXX -c "COPY (SELECT COUNT(b.id) as \"First-time-Missed-calls\" FROM XXXXX_user_master as b WHERE b.first_missed_call_time BETWEEN TIMESTAMP '2015-05-15 09:00:00' AND TIMESTAMP 'today') TO STDOUT With CSV HEADER" > B.csv
echo "created overall_first_time_calls.csv"
awk -F',' 'NR==FNR {h[FNR] = $1; next} {print $1","$2","h[FNR]}' B.csv A.csv > Overall_counts.csv
echo "created Overall_counts.csv"



############## Overall_Circle_Operator

## overall_circle_operator_total_missed_calls.csv
psql -UXXXXX -hXXXXX -p6644 XXXXX -c "COPY (SELECT  	circle as Circle, replace(replace(operator,',',''),' ','-') as operator, count(id) as \"Total-Missed-calls\",count(DISTINCT(mobile)) as \"Unique-Missed-calls\" FROM XXXXX_missedcall_log  WHERE missed_call_time BETWEEN TIMESTAMP '2015-05-15 09:00:00' AND TIMESTAMP 'today'  GROUP BY circle,operator ORDER BY circle,operator) TO STDOUT With CSV HEADER" > A.csv
echo "created overall_circle_operator_total_missed_calls.csv"


## overall_circle_operator_unique_missed_calls.csv
#psql -UXXXXX -hXXXXX -p6644 XXXXX -c "COPY (SELECT  	circle as Circle, 	operator as Operator,   	count(DISTINCT(mobile)) as \"Unique Missed calls\" FROM XXXXX_missedcall_log  WHERE missed_call_time BETWEEN TIMESTAMP '2015-05-15 09:00:00' AND TIMESTAMP 'today'  GROUP BY circle,operator ORDER BY circle,operator) TO STDOUT With CSV HEADER" > overall_circle_operator_unique_missed_calls.csv
#echo "created overall_circle_operator_unique_missed_calls.csv"



## overall_circle_operator_first_missed_calls.csv
psql -UXXXXX -hXXXXX -p6644 XXXXX -c "COPY (SELECT  	circle as Circle, replace(replace(operator,',',''),' ','-') as operator,count(id) as \"Total-First-Missed-calls\" FROM XXXXX_user_master  WHERE first_missed_call_time BETWEEN TIMESTAMP '2015-05-15 09:00:00' AND TIMESTAMP 'today'  GROUP BY circle,operator ORDER BY circle,operator) TO STDOUT With CSV HEADER" > B.csv
echo "created overall_circle_operator_first_missed_calls.csv"

awk -F',' 'NR==FNR {h[FNR] = $3; next} {print $1","$2","$3","$4","h[FNR]}' B.csv A.csv > Overall_Circle_Operator.csv
echo "created Overall_Circle_Operator.csv"



##############################P Overall_Hour
### overall_Hour_Total_Missed_calls.csv
psql -UXXXXX -hXXXXX -p6644 XXXXX -c "COPY (SELECT EXTRACT(hour FROM missed_call_time) as hour,count(id) as \"Total-Missed-calls\",count(DISTINCT(mobile)) as \"Unique-Missed-calls\" FROM XXXXX_missedcall_log  WHERE missed_call_time BETWEEN TIMESTAMP '2015-05-15 09:00:00' AND TIMESTAMP 'today'  GROUP BY hour ORDER BY hour) TO STDOUT With CSV HEADER" > A.csv
echo "created overall_Hour_Total_Missed_calls.csv"


### overall_Hour_Unique_Missed_calls.csv
#psql -UXXXXX -hXXXXX -p6644 XXXXX -c "COPY (SELECT EXTRACT(hour FROM missed_call_time) as hour,count(DISTINCT(mobile)) as \"Unique Missed calls\" FROM XXXXX_missedcall_log  WHERE missed_call_time BETWEEN TIMESTAMP '2015-05-15 09:00:00' AND TIMESTAMP 'today'  GROUP BY hour ORDER BY hour) TO STDOUT With CSV HEADER" > overall_Hour_Unique_Missed_calls.csv
#echo "created overall_Hour_Unique_Missed_calls.csv"


### overall_Hour_first_Missed_Calls.csv
psql -UXXXXX -hXXXXX -p6644 XXXXX -c "COPY (SELECT  EXTRACT(hour FROM first_missed_call_time) as hour,   	count(id) as \"Total-First-Missed-Calls\" FROM XXXXX_user_master  WHERE first_missed_call_time BETWEEN TIMESTAMP '2015-05-15 09:00:00' AND TIMESTAMP 'today'  GROUP BY hour ORDER BY hour) TO STDOUT With CSV HEADER" >  B.csv
echo "created overall_Hour_first_Missed_Calls.csv"


awk -F',' 'NR==FNR {h[FNR] = $2; next} {print $1","$2","$3","h[FNR]}' B.csv A.csv > Overall_Hour.csv
echo "created Overall_Hour.csv"


####################P
## Users_Vs_Missed_calls.csv
psql -UXXXXX -hXXXXX -p6644 XXXXX -c "COPY (SELECT cnt as \"Times-MC-given\",count(cnt) as \"No-of-users\"   FROM (select count(1) as cnt, mobile from XXXXX_missedcall_log WHERE missed_call_time BETWEEN TIMESTAMP '2015-05-15 09:00:00' AND TIMESTAMP 'today'  group by mobile) as temp group by cnt order by cnt asc) TO STDOUT With CSV HEADER" > Users_Vs_Missed_calls.csv
echo "created Users_Vs_Missed_calls.csv"


zip FB_report_$dir.zip *.csv -x A.csv -x B.csv

echo "PFA reports" | mail -s "FB_report - $dir"  -a FB_report_$dir.zip email1 email2


