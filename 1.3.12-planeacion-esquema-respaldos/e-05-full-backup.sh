#!/bin/bash

mejor_ruta_para_guardar_log=/unam/bda/proyecto-final/logs # TODO: Cambiar por la mejor ruta para guardar logs
path_to_backup_script=/unam/bda/proyecto-final/dba-final-project-anz-dnh/1.3.12-planeacion-esquema-respaldos/e-05-full-backup.sh

if [ ! -d $mejor_ruta_para_guardar_log ]; then
  echo "Creando directorio para guardar logs..."
  mkdir -p $mejor_ruta_para_guardar_log
fi

touch $mejor_ruta_para_guardar_log/full_backup.log

echo "1. Creando cronjob para ejecutar el script de respaldo completo"
crontab -e

echo "Programando respaldo de script $path_to_backup_script para ejecutarse diariamente a las 02:00am horas y guardar log en $mejor_ruta_para_guardar_log/full_backup.log"

0 2 * * * $path_to_backup_script >> $mejor_ruta_para_guardar_log/full_backup.log 2>&1 >> crontab

echo "Respaldos completos programados para ejecutarse diariamente a las 02:00am horas"
echo "3. Verificar que el cronjob se haya creado correctamente"
crontab -l

echo "4. Últimas 10 líneas del log de respaldo completo"
tail -n 10 $mejor_ruta_para_guardar_log/full_backup.log