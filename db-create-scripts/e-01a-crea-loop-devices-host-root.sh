#@Autor: <Nombre del autor o autores> 
#@Fecha creación: <Fecha de creación> 
#@Descripción: Crear las 10 carpetas que se van a utilizar para la simulación de los 10 discos duros

# Whenever this scripts fail it will stop
set -e

#!/bin/bash
dba_proyecto_final_dir="/unam/bda/proyecto-final"

echo "1. Creando los directorios de los discos duros..."  

for i in {1..9}
do
    mkdir -p "${dba_proyecto_final_dir}/d1$i"
done

mkdir -p "${dba_proyecto_final_dir}/d20"

echo '1.1. Cambiando los permisos para que se pueda acceder a los directorios'
chmod 777 "${dba_proyecto_final_dir}/d1*"
chmod 777 "${dba_proyecto_final_dir}/d20"


echo "2. Mostrando la creación de los directorios"

ls -l "${dba_proyecto_final_dir}"

