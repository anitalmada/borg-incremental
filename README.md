# Script for incremental backups using Borg

This script is based on the example for incremental backups provided in the [Borg Documentation](https://borgbackup.readthedocs.io/en/stable/quickstart.html#automating-backups).

[BorgBackup](https://www.borgbackup.org/) is a deduplicating backup program. Optionally, it supports compression and authenticated encryption. I used the example and changed it for automation of incremental backups on the same host and to keep 2 dailies and 1 weekly. To see all the features, check the [official documentation](https://borgbackup.readthedocs.io/en/stable/) and the [official GitHub repository](https://github.com/borgbackup/borg/).
