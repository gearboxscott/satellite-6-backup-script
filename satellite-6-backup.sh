#!/bin/bash

DESTINATION=/backup
YEAR=$(date +%Y)
WEEK=$(date +%-V)
NEEDS_FULL=0

if [ -d $DESTINATION/$YEAR-$((WEEK - 2)) ]; then 
   rm -rf $DESTINATION/$YEAR-$((WEEK - 2))
fi
if [ ! -d $DESTINATION/$YEAR-$WEEK/ ]; then 
   mkdir $DESTINATION/$YEAR-$WEEK 2 NEEDS_FULL=1
fi
if [[ $(date +%w) == 0 || $NEEDS_FULL == 1 ]]; then
   foreman-maintain backup snapshot --assumeyes --features all $DESTINATION/$YEAR-$((WEEK + 1))
else
   LAST=$(ls -td -- $DESTINATION/$YEAR-$WEEK/*/ | head -n 1)
   foreman-maintain backup snapshot --incremental "$LAST" --assumeyes --features all $DESTINATION/$YEAR-$WEEK
if