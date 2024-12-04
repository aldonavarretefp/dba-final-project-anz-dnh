#!/bin/bash
#@Autor: TODO
#@Fecha: TODO
#@Descripción: crea directorios para activar el modo archive
echo "creando directorios"

export ORACLE_SID=free

proyecto_final_dir='/unam/bda/proyecto-final'
archive_log_dir='${proyecto_final_dir}/archivelogs'

if ! [ -d "${proyecto_final_dir}" ]; then
  echo "El directorio ${proyecto_final_dir} no existe"
  exit 1;
fi;

if ! [ "${USER}" = "oracle" ]; then
  echo "El script debe ser ejecutado con el usuario oracle"
  exit 1;
fi;

echo "1. Creando directorios..."
mkdir -p "${archive_log_dir}/${ORACLE_SID^^}/disk_a"

echo "-----------Cambiando permisos-----------"
chmod -R 750 "${archive_log_dir}/${ORACLE_SID^^}"

echo "-----------Comprobando existencia de directorios-----------"
ls -l "${archive_log_dir}/${ORACLE_SID^^}"