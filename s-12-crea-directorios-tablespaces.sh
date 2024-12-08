#!/bin/bash
# @Autor: Borboa Castillo Carlos Alfonso, Ortiz Rivera Miguel Angel
# @Fecha: 04/06/2024
# @Descripcion: este script crea los directorios necesarios para los tablespaces del proyecto final boorproy


#----------------------------Crea directorios para los tablespaces: /unam-bda/-------------------------


echo "------------------------Validando la existencia de directorio para tablespaces--------------------------"

if [ -d "/unam-bda/d13" ]; then
  echo "Directorio d13 ya existe"
else
  #Crea el directorio
  echo "Creando carpeta d13..."
  echo ""
  cd /unam-bda/
  mkdir d13
  echo "Listo!"
  echo ""
fi;

if [ -d "/unam-bda/d14" ]; then
  echo "Directorio d14 ya existe"
else
  #Crea el directorio
  echo "Creando carpeta d14..."
  echo ""
  cd /unam-bda/
  mkdir d14
  echo "Listo!"
  echo ""
fi;

if [ -d "/unam-bda/d15" ]; then
  echo "Directorio d15 ya existe"
else
  #Crea el directorio
  echo "Creando carpeta d15..."
  echo ""
  cd /unam-bda/
  mkdir d15
  echo "Listo!"
  echo ""
fi;

if [ -d "/unam-bda/d16" ]; then
  echo "Directorio d16 ya existe"
else
  #Crea el directorio
  echo "Creando carpeta d16..."
  echo ""
  cd /unam-bda/
  mkdir d16
  echo "Listo!"
  echo ""
fi;

if [ -d "/unam-bda/d17" ]; then
  echo "Directorio d17 ya existe"
else
  #Crea el directorio
  echo "Creando carpeta d17..."
  echo ""
  cd /unam-bda/
  mkdir d17
  echo "Listo!"
  echo ""
fi;

if [ -d "/unam-bda/d18" ]; then
  echo "Directorio d18 ya existe"
else
  #Crea el directorio
  echo "Creando carpeta d18..."
  echo ""
  cd /unam-bda/
  mkdir d18
  echo "Listo!"
  echo ""
fi;

if [ -d "/unam-bda/d19" ]; then
  echo "Directorio d19 ya existe"
else
  #Crea el directorio
  echo "Creando carpeta d19..."
  echo ""
  cd /unam-bda/
  mkdir d19
  echo "Listo!"
  echo ""
fi;

if [ -d "/unam-bda/d20" ]; then
  echo "Directorio d20 ya existe"
else
  #Crea el directorio
  echo "Creando carpeta d20..."
  echo ""
  cd /unam-bda/
  mkdir d20
  echo "Listo!"
  echo ""
fi;

if [ -d "/unam-bda/d21" ]; then
  echo "Directorio d21 ya existe"
else
  #Crea el directorio
  echo "Creando carpeta d21..."
  echo ""
  cd /unam-bda/
  mkdir d21
  echo "Listo!"
  echo ""
fi;

if [ -d "/unam-bda/d22" ]; then
  echo "Directorio d22 ya existe"
else
  #Crea el directorio
  echo "Creando carpeta d22..."
  echo ""
  cd /unam-bda/
  mkdir d22
  echo "Listo!"
  echo ""
fi;

if [ -d "/unam-bda/d23" ]; then
  echo "Directorio d23 ya existe"
else
  #Crea el directorio
  echo "Creando carpeta d23..."
  echo ""
  cd /unam-bda/
  mkdir d23
  echo "Listo!"
  echo ""
fi;

if [ -d "/unam-bda/d24" ]; then
  echo "Directorio d24 ya existe"
else
  #Crea el directorio
  echo "Creando carpeta d24..."
  echo ""
  cd /unam-bda/
  mkdir d24
  echo "Listo!"
  echo ""
fi;

if [ -d "/unam-bda/d25" ]; then
  echo "Directorio d25 ya existe"
else
  #Crea el directorio
  echo "Creando carpeta d25..."
  echo ""
  cd /unam-bda/
  mkdir d25
  echo "Listo!"
  echo ""
fi;

#----------------------------Mostrando que los directorios para datafiles fueron creados------------------
#En el comando ls, el argumento -l se utiliza para mostrar una lista detallada de archivos y directorios en formato largo. 
#Esta lista incluye información como permisos, propietario, grupo, tamaño, fecha de modificación y nombre del archivo.
echo "---------------------------Mostrando directorios para tablespaces------------------"

ls -l /unam-bda/d1*
ls -l /unam-bda/d2*

