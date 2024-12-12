#!/bin/bash
# @Autor: Navarrete Zamora Aldo Yael, Nuñez Hernandez Diego Ignacio TODO: Cambiar por su nombre
# @Fecha: 07/06/2024 TODO: Cambiar por su nombre
# @Descripcion: genera el directorio para guardar backups TODO: Cambiar por su nombre

set -e
export ORACLE_SID=free

backups_dir="/unam/bda/proyecto-final/backups"

echo "------------------------Validando la existencia de directorio para backups--------------------------"

if [ -d $backups_dir ]; then
  echo "Directorio de backups ya existe"
else
  #Crea el directorio backups
  echo "Creando carpeta para guardar los backups de la base boorproy..."
  echo ""
  cd /unam/bda/proyecto-final
  mkdir backups
  #Se cambia el dueño a oracle y se cambian los permisos a la carpeta MORBDA2 a 750:
  #7: todos los permisos para el usuario propietario (oracle)
  #5: permisos de lectura y ejecución para el grupo (oinstall)
  #0: ningún permiso para otros usuarios que no son oracle ni del grupo oinstall
  chown oracle:oinstall backups
  chmod 750 backups
  echo "Listo!"
  echo ""
fi;