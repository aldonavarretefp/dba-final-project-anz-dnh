#@Autor: <Nombre del autor o autores> 
#@Fecha creación: <Fecha de creación> 
#@Descripción: <Breve descripción del contenido del script>

#!/bin/bash

archivo_pwd="${ORACLE_HOME}/dbs/orapw${ORACLE_SID}"

echo "1. Creando un archivo de passwords usar como password Hola1234*"

echo "Verificando la existencia del archivo"
#--TODO
if [ -f "${archivo_pwd}" ]; then
    echo "El archivo ${archivo_pwd} ya existe"
else
    echo "El archivo ${archivo_pwd} no existe"
fi

#--TODO

#El password debe ser al menos de 8 caracteres con letras y caracteres
# especiales.  Por ejemplo: Hola1234*  (no debe contener el nombre de usuario)
echo "Creando archivo ${archivo_pwd}"
#--TODO

orapwd file="${archivo_pwd}" \
    password=Hola1234* \
    force=y \
    format=12.2

#--TODO

echo "2. Verificando la existencia del archivo"
ls -l "${archivo_pwd}"
