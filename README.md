satellite-6-backup-script
=========

This repository contains a script that will backup the Satellite 6 Server using a full backup or incremental backup

Requirements
------------
---

* Disk Space: Review your disk space requirements to ensure you have enough room to backup Satellite 6 Server.


Variables
--------------
---


* `DESTINATION` - This is location where the backups will be placed


Usage and Install
----------------
---

This backup script will keep the number of backup in a directory structure of YEAR and WEEK OF THE YEAR.  It will purge old backups when the `KEEP` criteria is met. 

* Place `satellite-6-backup.sh` in /usr/local/sbin

* `chmod 700 /usr/local/sbin/satellite-6-backup.sh`

* Edit file to change the variables to the correct values

To run from the command-line:

`./usr/local/sbin/satellite-6-backup.sh`

To run from cron, place the file `satellite-backup` in /etc/cron.d and anacron will run it at the prescribed time and day. Remember to change the DESTINATION in the file.


License
-------
---

GPL

Author Information
------------------
---

Scott Parker - Red Hat North American Consulting

Credits
-------------------
---
None
