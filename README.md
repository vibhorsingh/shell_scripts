# shell_scripts
All the random shell scripts till date


sebi_report.sh
----------
This script is used to generate report by parsing two very large files. One file contains raw report while other contains mobile list
####raw report
SEBIED|918333067898|1192358100820310881|2015-12-25 10:08:20|2015-12-25 10:08:25|DELIVERD|0|BSNL|ANDHRA PRADESH
SEBIED|919550986555|2723581019140000000|2015-12-25 10:19:14|2015-12-25 10:22:39|DELIVERD|0|AIRTEL|ANDHRA PRADESH
SEBIED|919550986555|2723581019140000002|2015-12-25 10:19:14|2015-12-25 10:22:43|DELIVERD|0|AIRTEL|ANDHRA PRADESH
SEBIED|919550986555|2723581019140000001|2015-12-25 10:19:14|2015-12-25 10:22:48|DELIVERD|0|AIRTEL|ANDHRA PRADESH
SEBIED|919550986555|2713581019140000000|2015-12-25 10:19:14|2015-12-25 10:23:18|DELIVERD|0|AIRTEL|ANDHRA PRADESH
SEBIED|919869203129|2723581025370000003|2015-12-25 10:25:37|2015-12-25 10:25:37|FAILED|27|MTNL|MUMBAI
SEBIED|919869203129|2723581025370000004|2015-12-25 10:25:37|2015-12-25 10:25:37|FAILED|27|MTNL|MUMBAI
SEBIED|919869203129|2723581025370000005|2015-12-25 10:25:37|2015-12-25 10:25:37|FAILED|27|MTNL|MUMBAI

####mobile list
8333067898
9550986555
9869203123


####Reports Header :
Date 	File_name/City 	Unique mobile number to whom msg pushed 	Total sms pushed count 	SMS Delivered count
2015-12-25 SEBI_DLR_20151225.txt,3287200,32412065,15870428



user_count.sh
----------
This script generates a histogram of the number of hits
