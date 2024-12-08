#@Autor: <Nombre del autor o autores> 
#@Fecha creación: <Fecha de creación> 
#@Descripción: <Breve descripción del contenido del script>

#!/bin/bash

set -e

echo "Creando un archivo de parametros básico"

pfile=$ORACLE_HOME/dbs/init${ORACLE_SID}.ora

echo "Validando la existencia del archivo de parámetros"
#--TODO
if [ -f "${pfile}" ]; then
    echo "El archivo ${pfile} ya existe"
    echo "Saliendo"
    exit 1
else
    echo "El archivo ${pfile} no existe"
fi
#TODO--

echo " 1. Creando el archivo de parámetros"
#--TODO
echo \
"
db_name='${ORACLE_SID}'
memory_target=768M
control_files=(
    /unam/bda/proyecto-final/disk/d01/app/oracle/oradata/${ORACLE_SID^^}/control01.ctl,
    /unam/bda/proyecto-final/disk/d02/app/oracle/oradata/${ORACLE_SID^^}/control02.ctl,
    /unam/bda/proyecto-final/disk/d03/app/oracle/oradata/${ORACLE_SID^^}/control03.ctl
)
db_domain=fi.unam
enable_pluggable_database=true
" > $pfile
#TODO--

echo "Listo"
echo "Comprobando la existencia y contenido del PFILE"
echo ""
#TODO--
cat $pfile
#TODO--