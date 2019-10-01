#!/bin/bash
# A simple script to backup your MYSQL Database

# Set these variables
username="root"	# Database username
password="root"	# Database password
hostname="localhost"	# Database hostname or IP address

# Backup target_path directory
target_path="/home/daparis/Desktop"

# Enter the EMAIL id for notifictions to be sent
EMAIL="emaiid@yourdomain.com"

# in the below value we Are removing 5 days old backup. modify it accordingly as needed
DAYS=5

# Figure our the the version and bin paths in linux machine
MYSQL="$(which mysql)"
MYSQLDUMP="$(which mysqldump)"
GZIP="$(which gzip)"

# Below command helps us in getting the date in the dd-mm-yyyy formats
NOW="$(date +"%d-%m-%Y_%s")"

# Create Backup sub-directories as needed
sub_directory_path="$target_path/$NOW/mysql"
install -d $sub_directory_path

# Skipping the Information Schema DB from taking the backup
SKIP="information_schema
another_one_db"

# Get all databases names 
DBS="$($MYSQL -h $hostname -u $username -p$password -Bse 'show databases')"

# Block for generating archive data dumps
for db in $DBS
do
    skipdb=-1
    if [ "$SKIP" != "" ];
    then
		for i in $SKIP
		do
			[ "$db" == "$i" ] && skipdb=1 || :
		done
    fi
 
    if [ "$skipdb" == "-1" ] ; then
    	FILE="$sub_directory_path/$db.sql"
	$MYSQLDUMP -h $hostname -u $username -p$password $db > $FILE
    fi
done

# Archive the directory, send mail and cleanup
cd $target_path
tar -cf $NOW.tar $NOW
$GZIP -9 $NOW.tar

echo "Howdy!!! MySQL backup is completed! Backup name is $NOW.tar.gz" | mail -s "MySQL backup" $EMAIL
rm -rf $NOW

# Remove old files
find $target_path -mtime +$DAYS -exec rm -f {} \;