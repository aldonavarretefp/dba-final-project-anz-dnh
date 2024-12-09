#!/bin/bash

mejor_ruta_para_guardar_log=/unam/bda/proyecto-final/logs # TODO: Cambiar por la mejor ruta para guardar logs

if [ ! -d $mejor_ruta_para_guardar_log ]; then
  echo "Creando directorio para guardar logs..."
  mkdir -p $mejor_ruta_para_guardar_log
fi

rman target / 

touch $mejor_ruta_para_guardar_log/full_backup.log

echo "1. Creando cronjob para ejecutar el script de respaldo completo"
crontab -e

echo "2. 0 2 * * * /path/to/e-05-full-backup.sh >> $mejor_ruta_para_guardar_log/full_backup.log 2>&1" >> /tmp/crontab.txt
0 0 * * * /path/to/e-05-full-backup.sh >> $mejor_ruta_para_guardar_log/full_backup.log 2>&1

echo "Respaldos completos programados para ejecutarse diariamente a las 02:00am horas"
echo "3. Verificar que el cronjob se haya creado correctamente"
crontab -l

echo "4. Últimas 10 líneas del log de respaldo completo"
tail -n 10 $mejor_ruta_para_guardar_log/full_backup.log