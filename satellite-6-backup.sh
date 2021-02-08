#!/bin/bash

YEAR=$( date +%Y )
WEEK=$( date +%-V )
DOW=$( date +%w )
NEEDS_FULL=0
DAY_OF_WEEK=1
WEEKS_BACK=2
OWNER=root
GROUP=postgres
DESTINATION=$1
OUT_DESTINATION=$DESTINATION/$YEAR-$WEEK/
REMOVE_DESTINATION=$DESTINATION/$YEAR-(( WEEK - WEEKS_BACK ))
FORWARD_WEEK=1
WEEK_FORWARD_DESTINATION=$DESTINATION/$YEAR-(( WEEK + FORWARD_WEEK ))

if [ ${ #DESTINATION } -eq 0 ]; then
   echo "$0 backup_directory"
   exit 1
fi

if [[ $DOW == $DAY_OF_WEEK || -d $REMOVE_DESTINATION ]]; then 
   rm -rf $REMOVE_DESTINATION
fi

if [ ! -d $OUT_DESTINATION ]; then 
   mkdir $OUT_DESTINATION
   chown $OWNER:$GROUP $OUT_DESTINATION
   NEEDS_FULL=1
fi

if [[ $DOW == $DAY_OF_WEEK || $NEEDS_FULL == 1 ]]; then
   foreman-maintain backup snapshot --assumeyes --features all $WEEK_FORWARD_DESTINATION
else
   LAST=$( ls -td -- $OUT_DESTINATION/*/ | head -n 1 )
   foreman-maintain backup snapshot --incremental "$LAST" --assumeyes --features all $OUT_DESTINATION
if
