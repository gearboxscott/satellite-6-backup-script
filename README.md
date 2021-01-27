ansible-tower-backup-script
=========

This repository contains a script that will backup Ansible Tower either as a single node or clustered node.

Why this script, the primary purpose of this script was the redirect the output of the backup tar file to a different directory and be callable from crontab.

Requirements
------------

Many of the requirements are from the Ansible Tower Administrators Guide: https://docs.ansible.com/ansible-tower/latest/html/administration/backup_restore.html#ag-clustering-backup-restore

* Disk Space: Review your disk space requirements to ensure you have enough room to backup configuration files, keys, and other relevant files, plus the database of the Tower installation.

* Credentials: Confirm you have the system credentials you need when working with a local database or a remote database. On local systems, you may need root or sudo access, depending on how credentials were setup. On remote systems, you may need different credentials to grant you access to the remote system you are trying to backup or restore.

* You should always use the most recent minor version of a release to backup and/or restore your Tower installation version. For example, if the current version of Tower that you are on is 3.7.x, use only the 3.7.3 installer.

* When using `setup.sh` to do a restore from the default restore file path, `/var/lib/awx`, `-r` is still required in order to do the restore, but it no longer accepts an argument. If a non-default restore file path is needed, the user must provide this as an extra var ( `root@localhost:~# ./setup.sh -e 'restore_backup_file=/path/to/nondefault/backup.tar.gz' -r` ).

* If the backup file is placed in the same directory as the `setup.sh` installer, the restore playbook will automatically locate the restore files. In this case, you do not need to use the `restore_backup_file` extra var to specify the location of the backup file.

ansible-tower-backup-script Variables
--------------

* `SOURCE` - This is the location or initial install directory of Ansible Tower that contains `setup.sh`. For example, `ansible-tower-setup-3.7.3-1`

* `INVENTORY` - This is location of the inventory file that was used to do the initial of Ansible Tower.

* `DESTINATION` - The location to deposit the backups

* `KEEP` - how many weeks to keep (default: 2)

Usage and Install
----------------

This backup script will keep the number of backup in a directory structure of YEAR and WEEK OF THE YEAR.  It will purge old backups when the `KEEP` criteria is met. 

* Place `ansible-tower-backup.sh` in /usr/local/bin

* `chmod 700 /usr/local/sbin/ansible-tower-backup.sh`

* Edit file to change the variables to the correct values

To run from the command-line:

`./usr/local/sbin/ansible-tower-backup.sh`

To run from cron, place the file `ansible-backup` in /etc/cron.d and anacron will run it at the prescribed time and day. Remember to change the SOURCE in the file.


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
Credit goes to the authors for the [foreman-ansible-modules](https://github.com/theforeman/foreman-ansible-modules) 