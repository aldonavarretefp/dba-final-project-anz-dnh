#!/bin/bash
set -e
rman target 'sys/system1 as sysdba' <<EOF
RUN {
    BACKUP INCREMENTAL LEVEL 1 DATABASE
        TAG 'DAILY_BACKUP'
        FORMAT '/unam/bda/proyecto-final/backups/daily_%U.bkp';
    BACKUP ARCHIVELOG ALL
        FORMAT '/unam/bda/proyecto-final/backups/archivelogs_%U_%T.bkp';
        DELETE INPUT;
    DELETE NOPROMPT OBSOLETE;
}
EXIT;
EOF

chmod +x rman_daily_backup.sh
