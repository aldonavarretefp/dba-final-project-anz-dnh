#!/bin/bash
set -e
sqlplus sys/system1 as sysdba <<EOF
shutdown immediate;
exit;
EOF

echo "Respaldamos spfile"
cp $ORACLE_HOME/dbs/spfile$ORACLE_SID.ora $ORACLE_HOME/dbs/spfile$ORACLE_SID.ora.bak

echo "Creando PFILE"

sqlplus sys/system1 as sysdba <<EOF
create pfile from spfile;
startup nomount;
exit;
EOF

echo "Respaldar el valoor de control_files"

sqlplus sys/system1 as sysdba <<EOF
select name from v\$controlfile;
Pause 'Presione enter para continuar';
exit;
EOF

echo "Reset del parametro control_files a nivel de spfile"

sqlplus sys/system1 as sysdba <<EOF
alter system reset control_files scope=spfile;
exit;
EOF

echo "Reiniciar la base de datos"

sqlplus sys/system1 as sysdba <<EOF
shutdown immediate;
startup nomount;
exit;
EOF

alter system set control_files='/unam/bda/proyecto-final/fast-recovery-area/FREE/controlfile/o1_mf_mol08goz_.ctl','/unam/bda/proyecto-final/disk/d01/app/oracle/oradata/FREE/control01.ctl','/unam/bda/proyecto-final/disk/d02/app/oracle/oradata/FREE/control02.ctl' scope=spfile;




