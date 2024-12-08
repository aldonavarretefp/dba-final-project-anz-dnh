#!/bin/bash
# @Autor: Borboa Castillo Carlos Alfonso, Ortiz Rivera Miguel Angel
# @Fecha: 07/06/2024
# @Descripcion: genera el directorio para guardar backups

export ORACLE_SID=boorproy

echo "------------------------Validando la existencia de directorio para backups--------------------------"

if [ -d "/unam-bda/ejercicios-practicos/proyecto-final/backups" ]; then
  echo "Directorio de backups ya existe"
else
  #Crea el directorio backups
  echo "Creando carpeta para guardar los backups de la base boorproy..."
  echo ""
  cd /unam-bda/ejercicios-practicos/proyecto-final
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