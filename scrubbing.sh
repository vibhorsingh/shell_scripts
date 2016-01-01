#!/bin/sh

INFILE=$1
TODAY=`date "+%d-%m-%Y"`
DB_DUMP_FILE="DB_DUMP.csv"
SCRUBBED_FILE="${TODAY}_scrubbed_${INFILE}"

##check if incoming file exists
if [ -f "$INFILE" ] 
then
    echo "File present..processing..";

    ## append the data from other table
    psql -UXXXXXX -hXXXXXX -p6644 XXXXXX -c "COPY (SELECT mobile FROM XXXXXXXXXXXX ) TO STDOUT With CSV" > $DB_DUMP_FILE

    echo "Copied data from response table"

    echo "created dump file"
    echo "count in dump file: `wc -l $DB_DUMP_FILE`"

    ## sort the dump file
    sort -n $DB_DUMP_FILE > $DB_DUMP_FILE.sorted
    echo "sorting completed for DB dump file"
	
	## sort the file:
	sed -i 's/ //g' $INFILE
	sort -n $INFILE > $INFILE.sorted
	echo "sorting completed for infile"	

	## now take the diff
	## DUMP FILE will always be having lower count
	echo "scrub process running..plz wait"
	comm -32 $INFILE.sorted $DB_DUMP_FILE.sorted > $SCRUBBED_FILE
	echo "scrub process completed"
	echo "count in scrubbed file: `wc -l $SCRUBBED_FILE`"
	echo "outfile name:$SCRUBBED_FILE"

else
	echo "File $INFILE does not exists"

fi
