#!/bin/bash
#@Autor: Borboa Castillo, Carlos Alfonso, Ortiz Rivera, Miguel Angel
#@Fecha: 04/06/2024
#@Descripción: crea directorios para activar el modo archive
echo "creando directorios"
export ORACLE_SID=boorproy


if ! [ "${USER}" = "oracle" ]; then
  echo "El script debe ser ejecutado con el usuario oracle"
  exit 1;
fi;

echo "-----------Creando directorios-----------"
mkdir -p /unam-bda/archivelogs/${ORACLE_SID^^}/disk_a


cd /unam-bda

echo "-----------Cambiando permisos-----------"
chmod -R 750 archivelogs/${ORACLE_SID^^}/disk_a


echo "-----------Comprobando existencia de directorios-----------"
ls -l /unam-bda/archivelogs/${ORACLE_SID^^}