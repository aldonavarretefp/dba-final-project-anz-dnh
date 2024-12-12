#!/bin/bash
# @Autor: Diego Ignacio Núñez Hernández, Aldo Yael Navarrete Zamora
# @Fecha: 28/11/2024
# @Descripcion: Elimina los redologs de la base de datos FREE

set -e
echo "Eliminando redologs"
# Presionar enter para continuar

redolog_path=/unam/bda/proyecto-final/disk

# Grupo 1

ls -l $redolog_path/d01/app/oracle/oradata/FREE/redo01a.log
echo "Seguro que desea eliminar los redologs? (s/n)"
read respuesta
rm $redolog_path/d01/app/oracle/oradata/FREE/redo01a.log

ls -l $redolog_path/d01/app/oracle/oradata/FREE/redo02a.log
echo "Seguro que desea eliminar los redologs? (s/n)"
read respuesta
rm $redolog_path/d01/app/oracle/oradata/FREE/redo02a.log

ls -l $redolog_path/d01/app/oracle/oradata/FREE/redo03a.log
echo "Seguro que desea eliminar los redologs? (s/n)"
read respuesta
rm $redolog_path/d01/app/oracle/oradata/FREE/redo03a.log

# Grupo 2

ls -l $redolog_path/d02/app/oracle/oradata/FREE/redo01b.log
echo "Seguro que desea eliminar los redologs? (s/n)"
read respuesta
rm $redolog_path/d02/app/oracle/oradata/FREE/redo01b.log
log_arch
ls -l $redolog_path/d02/app/oracle/oradata/FREE/redo02b.log
echo "Seguro que desea eliminar los redologs? (s/n)"
read respuesta
rm $redolog_path/d02/app/oracle/oradata/FREE/redo02b.log

ls -l $redolog_path/d02/app/oracle/oradata/FREE/redo03b.log
echo "Seguro que desea eliminar los redologs? (s/n)"
read respuesta
rm $redolog_path/d02/app/oracle/oradata/FREE/redo03b.log

# Grupo 3

ls -l $redolog_path/d03/app/oracle/oradata/FREE/redo01c.log
echo "Seguro que desea eliminar los redologs? (s/n)"
read respuesta
rm $redolog_path/d03/app/oracle/oradata/FREE/redo01c.log

ls -l $redolog_path/d03/app/oracle/oradata/FREE/redo02c.log
echo "Seguro que desea eliminar los redologs? (s/n)"
read respuesta
rm $redolog_path/d03/app/oracle/oradata/FREE/redo02c.log

ls -l $redolog_path/d03/app/oracle/oradata/FREE/redo03c.log
echo "Seguro que desea eliminar los redologs? (s/n)"
read respuesta
rm $redolog_path/d03/app/oracle/oradata/FREE/redo03c.log

