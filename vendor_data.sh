#!/bin/sh
export PGHOST="XXXX"
export PGPORT=XXXX
export PGDATABASE="XXXX"
export PGUSER="XXXXX"
export PGPASSWORD=XXXXXX
#dir=`date  --date="1 days ago" "+%d-%m-%Y"`
#mkdir -p FB_reports/$dir
#cd FB_reports/$dir
#current=`pwd`

## copy argument file to 
#cp $1 ./



### get circle/operator data
getCircleOperatorData() {
	
	psql --echo-all --set ON_ERROR_STOP=on -c "COPY (SELECT c.id as circle_id, o.id as operator_id   
FROM series_circles as c, series_operators as o, series_5 as m
where m.prefix = cast(substring('$1' from 1 for 5) as int) AND m.circle=c.id AND m.operator=o.id) TO STDOUT With CSV" > phn_details.csv
	d=$(cat phn_details.csv)
	echo $d	
}

parseStatus() {
	case $1 in 
		"success")
			return "1";
		;;
		"failed")
			return "0";
		;;
	esac
}



## read each line->get individual data -> transform individual data -> get circle/operator -> save to DB

## we dont want the headers
awk 'NR>1' $1 | while read line 
do
	#circle_operator=getCircleOperatorData $2
	
	mobile=$(echo $line | cut -d',' -f2)
	call_start_time=$(echo $line | cut -d',' -f3)
	call_end_time=$(echo $line | cut -d',' -f4)
	call_duration=$(echo $line | cut -d',' -f5)
	parseStatus $(echo $line | cut -d',' -f6)
	status=$?
	key_pressed=$(echo $line | cut -d',' -f7)
	key_press_time=$(echo $line | cut -d',' -f8)
	getCircleOperatorData $(echo $mobile | cut -d',' -f1)
	circleOp=$(getCircleOperatorData $(echo $mobile | cut -d',' -f1))	
	circle_id=$(echo $circleOp | cut -d',' -f1)
	operator_id=$(echo $circleOp | cut -d',' -f2)
	
	
	sql=$( cat <<EOF
INSERT INTO XXXXXXXXX (mobile,call_start_time,call_end_time,call_duration,status,key_pressed,key_press_time,circle_id,operator_id,created_time) VALUES ($mobile,to_timestamp('$call_start_time','DD-MM-YYYY HH:MI:SS'),to_timestamp('$call_end_time','DD-MM-YYYY HH:MI:SS'),$call_duration,$status,$key_pressed,to_timestamp('$key_press_time','DD-MM-YYYY HH:MI:SS'),$circle_id,$operator_id,TIMESTAMP 'now');
EOF
)
	echo $sql
	#psql --echo-all --set ON_ERROR_STOP=on <<EOF
#$sql
#EOF
done 
