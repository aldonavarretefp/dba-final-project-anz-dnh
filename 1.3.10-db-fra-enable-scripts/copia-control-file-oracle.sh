#!/bin/bash
# @Autor: TODO
# @Fecha: 03/06/2024 TODO
# @Descripcion: realiza multiplexado del control file TODO
#Correrse con el usuario ORACLE

set -e

echo "Multiplexando el control file..."
export ORACLE_SID=free

dba_proyecto_final_dir="/unam-bda/proyecto-final"
fra_dir="${dba_proyecto_final_dir}/fast-recovery-area"

cp /unam-bda/fast-recovery-area/FREE/controlfile/o1_mf_m5j124ft_.ctl /unam-bda/d11/app/oracle/oradata/${ORACLE_SID^^}/
cp /unam-bda/fast-recovery-area/FREE/controlfile/o1_mf_m5j124ft_.ctl /unam-bda/d12/app/oracle/oradata/${ORACLE_SID^^}/

echo "Listo!!"