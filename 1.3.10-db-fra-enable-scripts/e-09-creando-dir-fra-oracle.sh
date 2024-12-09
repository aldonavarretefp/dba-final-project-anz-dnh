#!/bin/bash
# @Autor: TODO
# @Fecha: 28/11/2024
# @Descripcion: crea un archivo pfile (archivo de parámetros) para la base de datos del proyecto final HOUSE SERVICES boorproy
#Se debe ejecutar con el usuario oracle
# ^^ Permite transformar la variable ORACLE_SID a mayúsculas
#cat permite mostrar el contenido de un archivo

set -e
export ORACLE_SID=free

echo "1. Creando un archivo de parámetros básico"
pfile=$ORACLE_HOME/dbs/init${ORACLE_SID}.ora
dba_proyecto_final_dir="/unam/bda/proyecto-final"

echo "2. Verificando la existencia de la carpeta del proyecto final..."
echo "Verifica si la carpeta fast-recovery-area ya existe..."
if [ ! -d "${dba_proyecto_final_dir}/fast-recovery-area" ]; then
  #Si no existe, crea la carpeta
  echo "Creando directorio para la FRA..."
  mkdir "${dba_proyecto_final_dir}/fast-recovery-area"
  echo "Se ha creado la carpeta 'fast-recovery-area' en ${dba_proyecto_final_dir}/"
else
  echo "La carpeta 'fast-recovery-area' ya existe en ${dba_proyecto_final_dir}/"
fi 

# if [ -f "${pfile}" ]; then
#   read -p "El archivo ${pfile} ya existe, [enter] para sobrescribir"
# fi;

# echo \
# "
# db_recovery_file_dest_size=1G
# db_recovery_file_dest='${dba_proyecto_final_dir}/fast-recovery-area'
# db_flashback_retention_target=10080
# " >> $pfile

# echo "Listo!"
# echo "Comprobando la existencia del archivo PFILE..."
# echo ""

# ls -l $ORACLE_HOME/dbs/init${ORACLE_SID}.ora

# echo ""
# echo "Mostrando el contenido del archivo PFILE..."
# echo ""

# cat ${pfile}