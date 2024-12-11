#!/bin/bash

set -e

mejor_ruta_para_guardar_log=/unam/bda/proyecto-final/logs # TODO: Cambiar por la mejor ruta para guardar logs
path_to_daily_backup_script=/unam/bda/proyecto-final/dba-final-project-anz-dnh/1.3.12-planeacion-esquema-respaldos/e-02-rman-daily-backup-oracle.sh
path_to_weekly_backup_script=/unam/bda/proyecto-final/dba-final-project-anz-dnh/1.3.12-planeacion-esquema-respaldos/e-03-rman-weekly-backup-oracle.sh

if [ ! -d $mejor_ruta_para_guardar_log ]; then
  echo "Creando directorio para guardar logs..."
  mkdir -p $mejor_ruta_para_guardar_log
fi

touch $mejor_ruta_para_guardar_log/full_backup.log

echo "1. Creando cronjob para ejecutar el script de respaldo completo"
crontab -e

echo "Programando respaldo de script $path_to_backup_script para ejecutarse diariamente a las 02:00am horas y guardar log en $mejor_ruta_para_guardar_log/full_backup.log..."
echo "0 2 * * * $path_to_daily_backup_script > $mejor_ruta_para_guardar_log/full_backup.log" >> /var/spool/cron/crontabs/root

echo "2. Creando cronjob para ejecutar el script de respaldo completo"

echo "Programando respaldo de script $path_to_backup_script para ejecutarse semanalmente a las 03:00am horas y guardar log en $mejor_ruta_para_guardar_log/full_backup.log..."
echo "0 3 * * 0 $path_to_weekly_backup_script > $mejor_ruta_para_guardar_log/full_backup.log" >> /var/spool/cron/crontabs/root

echo "3. Verificando que los cronjobs se hayan creado correctamente..."
crontab -l

echo "Listo. Los cronjobs se han programado correctamente."

exit 0;
