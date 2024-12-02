#!/bin/bash
#@Autor:          Jorge A. Rodriguez C
#@Fecha creación:  dd/mm/yyyy
#@Descripción:  Creación del diccionario de datos

set -e

echo "Creación del diccionario de datos"

echo "Creando archivo de bitacoras"
mkdir /tmp/dd-logs

echo "Ejecutando Perl Script para crear el DD en todos los contenedores"
#--TODO
perl -I $ORACLE_HOME/rdbms/admin \
$ORACLE_HOME/rdbms/admin/catcdb.pl \
--logDirectory /tmp/dd-logs \
--logFilename dd.log \
--logErrorsFilename dderror.log

#TODO--

echo "Listo!!  Verficar la correcta creación del DD"

# #--TODO
# sqlplus -s sys/system1 as sysdba << EOF
# set serveroutput on
# exec dbms_dictionary_check.full
# EOF
# #TODO--

echo "Listo"