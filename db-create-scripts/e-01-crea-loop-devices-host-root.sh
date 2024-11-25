#@Autor: <Nombre del autor o autores> 
#@Fecha creación: <Fecha de creación> 
#@Descripción: <Breve descripción del contenido del script>

# Whenever this scripts fail it will stop
set -e

#!/bin/bash
diplo_dir="/unam/bda/proyecto-final"

echo "1. Creando directorio disk-images"

#--TODO
mkdir -p "${diplo_dir}/disk-images"
#TODO--

echo "2,3. Crear archivos img"
cd "${diplo_dir}/disk-images"

#--TODO
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
#TODO---

echo "4. Mostrando la creación de los archivos"
du -sh disk*.img 

echo "5. Creando Loop devices "
#--TODO
losetup -fP disk1.img
losetup -fP disk2.img
losetup -fP disk3.img
#TODO--

echo "Mostrando la creación de loop devices"
losetup -a

echo "6. Dando formato ext4 a los arhivos img"

#--TODO
mkfs.ext4 disk1.img 
mkfs.ext4 disk2.img
mkfs.ext4 disk3.img
#TODO--

echo "7. Creando directorios para usarse como puntos de montaje"
#TODO--
mkdir -p "${diplo_dir}/disk/d01"
mkdir -p "${diplo_dir}/disk/d02"
mkdir -p "${diplo_dir}/disk/d03"
#TODO--

echo "Editando archivo /etc/fstab"

#--TODO
echo "# loop devices para el diplomado" >> /etc/fstab
echo "/unam/diplo-bd/disk-images/disk1.img /unam/diplo-bd/disk/d01 auto loop 0 0" >> /etc/fstab
echo "/unam/diplo-bd/disk-images/disk2.img /unam/diplo-bd/disk/d02 auto loop 0 0" >> /etc/fstab
echo "/unam/diplo-bd/disk-images/disk3.img /unam/diplo-bd/disk/d03 auto loop 0 0" >> /etc/fstab
echo "Listo!"


