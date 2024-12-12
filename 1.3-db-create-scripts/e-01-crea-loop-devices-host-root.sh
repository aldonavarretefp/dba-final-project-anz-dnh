#@Autor: Navarrete Zamora Aldo Yael, Nuñez Hernandez Diego Ignacio
#@Fecha creación: 11/11/2024
#@Descripción: Este script crea 3 archivos img de 50M, los monta en loop devices y les da formato ext4, además crea 3 directorios para montar los loop devices y edita el archivo /etc/fstab para que se monten automáticamente al reiniciar el sistema.

set -e

#!/bin/bash
dba_proyecto_final_dir="/unam/bda/proyecto-final"

echo "1. Creando directorio disk-images"

mkdir -p "${dba_proyecto_final_dir}/disk-images"

echo "2,3. Crear archivos img"
cd "${dba_proyecto_final_dir}/disk-images"

if [ -f disk1.img ]; then
    echo "El archivo disk1.img ya existe"
else
    dd if=/dev/zero of=disk1.img bs=50M count=10
fi

if [ -f disk2.img ]; then
    echo "El archivo disk2.img ya existe"
else
    dd if=/dev/zero of=disk2.img bs=50M count=10
fi

if [ -f disk3.img ]; then
    echo "El archivo disk3.img ya existe"
else
    dd if=/dev/zero of=disk3.img bs=50M count=10
fi

echo "4. Mostrando la creación de los archivos"
du -sh disk*.img 

echo "5. Creando Loop devices "

losetup -fP disk1.img
losetup -fP disk2.img
losetup -fP disk3.img

echo "Mostrando la creación de loop devices"
losetup -a

echo "6. Dando formato ext4 a los arhivos img"

mkfs.ext4 disk1.img 
mkfs.ext4 disk2.img
mkfs.ext4 disk3.img

echo "7. Creando directorios para usarse como puntos de montaje"

mkdir -p "${dba_proyecto_final_dir}/disk/d01"
mkdir -p "${dba_proyecto_final_dir}/disk/d02"
mkdir -p "${dba_proyecto_final_dir}/disk/d03"

echo "Editando archivo /etc/fstab"

echo "# loop devices para el el proyecto" >> /etc/fstab
echo "${dba_proyecto_final_dir}/disk-images/disk1.img ${dba_proyecto_final_dir}/disk/d01 auto loop 0 0" >> /etc/fstab
echo "${dba_proyecto_final_dir}/disk-images/disk2.img ${dba_proyecto_final_dir}/disk/d02 auto loop 0 0" >> /etc/fstab
echo "${dba_proyecto_final_dir}/disk-images/disk3.img ${dba_proyecto_final_dir}/disk/d03 auto loop 0 0" >> /etc/fstab
echo "Listo!"