#!/bin/bash
set -e

# Variables
mejor_ruta_para_guardar_log="/unam/bda/proyecto-final/logs" # TODO: Cambiar por la mejor ruta para guardar logs
path_to_daily_backup_script="/unam/bda/proyecto-final/dba-final-project-anz-dnh/1.3.12-planeacion-esquema-respaldos/e-02-rman-daily-backup-oracle.sh"
path_to_weekly_backup_script="/unam/bda/proyecto-final/dba-final-project-anz-dnh/1.3.12-planeacion-esquema-respaldos/e-03-rman-weekly-backup-oracle.sh"

# Crear directorio de logs si no existe
if [ ! -d "$mejor_ruta_para_guardar_log" ]; then
  echo "Creando directorio para guardar logs..."
  mkdir -p "$mejor_ruta_para_guardar_log"
fi

# Crear archivos de log si no existen
touch "$mejor_ruta_para_guardar_log/daily_backup.log"
touch "$mejor_ruta_para_guardar_log/weekly_backup.log"

# Agregar cron jobs
echo "1. Creando cronjob para respaldo diario..."
(crontab -l 2>/dev/null; echo "0 2 * * * $path_to_daily_backup_script > $mejor_ruta_para_guardar_log/daily_backup.log 2>&1") | crontab -

echo "2. Creando cronjob para respaldo semanal..."
(crontab -l 2>/dev/null; echo "0 2 * * 0 $path_to_weekly_backup_script > $mejor_ruta_para_guardar_log/weekly_backup.log 2>&1") | crontab -

# Verificar los cron jobs
echo "3. Verificando que los cronjobs se hayan creado correctamente..."
crontab -l

echo "4. Listo!"

exit 0

