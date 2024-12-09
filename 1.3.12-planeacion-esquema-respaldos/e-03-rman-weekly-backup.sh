#!/bin/bash
set -e
rman target sys/system1 as sysdba <<EOF
RUN {
    BACKUP INCREMENTAL LEVEL 0 DATABASE
        TAG 'WEEKLY_BACKUP'
        FORMAT '/unam/bda/proyecto-final/backups/weekly_%U.bkp';
    BACKUP ARCHIVELOG ALL
        FORMAT '/unam/bda/proyecto-final/backups/archivelogs_%U.bkp'
        DELETE INPUT;
    DELETE NOPROMPT OBSOLETE;
}
EXIT;
EOF
