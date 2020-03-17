#!/bin/bash

#Setting this so it is not necessary to set the repo or input the password on the commandline:
export BORG_REPO=/path/to/repo
export BORG_PASSPHRASE='1234AveryLarge567andComplex890Password'

info() { printf "\n%s %s\n\n" "$( date )" "$*" >&2; }
trap 'echo $( date ) Backup interrupted >&2; exit 2' INT TERM
info "Starting backup"

#Use the variable 'hostname' or any other to identify the origin of the backups repos.
#It's extremely important to use that variable if you have your borg repo on a different host
#because you have to clearly identify the backups you are going to prune and therefore avoid 
#accidental data loss.

borg create 			\
	--verbose		\
	--stats			\
	--compression lz4	\
	--exclude-caches	\
	::'{hostname}-{now}'	\
	~/directory1tobackitup/		\
	~/directory2tobackitup/	\

backup_exit=$?

info "Pruning repository"

#You can add the --keep-monthly flag if you need to.
borg prune			\
	--list			\
	--prefix '{hostname}-'	\
	--show-rc		\
	--keep-daily  2		\
	--keep-weekly 1		\

prune_exit=$?

global_exit=$(( backup_exit > prune_exit ? backup_exit : prune_exit ))

if [ ${global_exit} -eq 0 ]; then
	info "Backup and prune finished successfully"
elif [ ${global_exit} -eq 1 ]; then
	info "Backup and/or prune finished with warnings"
else
	info "Backup and/or prune finished with errors"
fi

exit ${global_exit}
