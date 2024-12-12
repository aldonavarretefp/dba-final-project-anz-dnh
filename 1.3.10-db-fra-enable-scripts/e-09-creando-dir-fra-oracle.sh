#!/bin/bash
# @Autor: Diego Ignacio Núñez Hernández, Aldo Yael Navarrete Zamora
# @Fecha: 28/11/2024
# @Descripcion: Crea la carpteta fast-recovery-area

set -e
export ORACLE_SID=free

dba_proyecto_final_dir="/unam/bda/proyecto-final"

echo "Verifica si la carpeta fast-recovery-area ya existe..."
if [ ! -d "${dba_proyecto_final_dir}/fast-recovery-area" ]; then
  #Si no existe, crea la carpeta
  echo "Creando directorio para la FRA..."
  mkdir "${dba_proyecto_final_dir}/fast-recovery-area"
  echo "Se ha creado la carpeta 'fast-recovery-area' en ${dba_proyecto_final_dir}/"
else
  echo "La carpeta 'fast-recovery-area' ya existe en ${dba_proyecto_final_dir}/"
fi 