#!/bin/bash

##Implement with crontab -

PURGEDAYS=4
DIASCOMPRESS=0

HOSTNAME=`hostname|awk '{print toupper($1)}'`
DATE=`date +%Y-%m-%d`
FICHLOG=/tmp/rotate_logs_$DATE.log

USER=user
GROUP=user_group

rm -f `find /tmp/rotate_logs_* -mtime +7`

> $FICHLOG
chmod 777 $FICHLOG

## Example for tomcat

function clean {
        echo "################################################"
        echo "#          Logs maintenance task               #"
        echo "################################################"
        cd $TOMCAT_LOGS
        cp catalina.out catalina.out.$DATE.txt
        >catalina.out
        cp probe.log probe.log.$DATE.txt
        >probe.log
        chown $USER.$GROUP *

        echo "-> Compress output files"
        find $TOMCAT_LOGS -type f -mtime +$DIASCOMPRESS ! -name "tcserver.pid" -print -exec gzip -f {} \;
        echo "-> Compress the days before"
        find $TOMCAT_LOGS -type f -mtime +$PURGEDAYS -name "*.gz" -print -exec rm -f {} \;
        echo "-> Delete the days before "
}


TOMCAT_LOGS=$(ps aux | grep $USER | grep -v grep | awk '{ print $18 }' | sed -r 's/^.{10}//' | rev | cut -c24- | rev)

for tomcat in $TOMCAT_LOGS; do clean 2>&1 >> $FICHLOG ;done

exit 0
