#!/bin/bash

source /var/lib/awx/venv/ansible/bin/activate

export SOURCE=/root/ansible/ansible-tower-setup-3.8.0-1
export INVENTORY=$SOURCE/inventory
export DESTINATION=/root/ansible/ansible-tower-setup-3.8.0-1
export YEAR=$(date +%Y)
export WEEK=$(date +%-V)
export KEEP=2
export FULL_DESTINATION=${DESTINATION}/${YEAR}/${WEEK}
export LOG=${FULL_DESTINATION}/ansible-tower-backups.log

cd $SOURCE/
mkdir -p $FULL_DESTINATION

echo "

======================================================================================
= Housekeeping Ansible Tower Backup -- $(date)
======================================================================================

$(pwd)

" >>$LOG

if [ -d $DESTINATION/$YEAR/$((WEEK - KEEP)) ]; then
   rm -rf $DESTINATION/$YEAR/$((WEEK - KEEP)) 1
fi

echo "

======================================================================================
= Starting Ansible Tower Backup -- $(date)
======================================================================================

$(pwd)

" >>$LOG

$SOURCE/setup.sh -e "backup_dest=${FULL_DESTINATION}" -i $INVENTORY -b >> $LOG

echo "

======================================================================================
= Ending Ansible Tower Backup   -- $(date)
======================================================================================

" >>$LOG


