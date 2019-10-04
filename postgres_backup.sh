#!/bin/bash

echo "Started!!!"
export PGCLIENTENCODING="UTF8"
DBLIST="$@"

if [ -z "${DBLIST}" ]; then
  DBLIST="" #enter your database schema name
fi
#backup directory
BACKUP=/var/backup/database/pgsql/
ARCHNAME=`date +%Y%m%d-%H`

YEARMONTH=`date +%y%m`
TODAY=`date +%d`

mkdir -p ${BACKUP}/${YEARMONTH}/${TODAY}
for DBNAME in ${DBLIST} ; do
    BACKFILE=${DBNAME}.${ARCHNAME}.bz2
    if [ -f ${BACKUP}/${YEARMONTH}/${TODAY}/${BACKFILE} ]; then
        continue
    fi
    pg_dump -U postgres  ${DBNAME} \
    | bzip2 -c -9 \
    > ${BACKUP}/${YEARMONTH}/${TODAY}/${BACKFILE}
done
echo "Finished!!!"