#!/bin/bash
set -e
sqlplus / as sysdba <<EOF
Prompt 0. Conectando como sysdba
connect sys/system1 as sysdba;
Prompt 1.  Verificar configuración
SHOW PARAMETER db_recovery_file_dest;
SHOW PARAMETER db_recovery_file_dest_size;
Prompt 2.  Verificar respaldos
Prompt Verificando respaldos de la semana...
SELECT SESSION_KEY, INPUT_TYPE, STATUS, START_TIME, END_TIME
FROM V\$RMAN_BACKUP_JOB_DETAILS
WHERE START_TIME >= TRUNC(SYSDATE - 7);

EOF
