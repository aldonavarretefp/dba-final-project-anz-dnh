--@Autor: Aldo Navarrete y Diego Nuñez
--@Fecha: 2024-12-1
--@Descripción: Script para habilitar Flashback y configurar el tiempo de retención de los datos en la FRA

connect sys/system1 as sysdba;

alter database flashback on;

alter system set db_flashback_retention_target=1440 scope=both;

exit