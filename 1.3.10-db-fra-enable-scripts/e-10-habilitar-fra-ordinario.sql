--@AUtor: Aldo Navarrete y Diego Nuñez
--@Fecha: 2024-12-1
--@Descripción: Script para habilitar la FRA en una base de datos Oracle 19c

whenever sqlerror exit rollback;

Prompt 0. Creando spool
spool anz-e-01-habilitar-fra-ordinario.txt

Prompt 1. Conectando como sys empleando archivo de passwords

connect sys/system1 as sysdba;

Prompt 2. Habilitando la FRA...
alter system set db_recovery_file_dest_size = 10G scope=both;
alter system set db_recovery_file_dest = '/unam/bda/proyecto-final/fast-recovery-area' scope=both;
alter system set db_flashback_retention_target = 1440 scope=both; --Este valor es en minutos

Prompt 3. Reiniciando la instancia para que los cambios tengan efecto...
shutdown immediate;
startup;

Prompt Listo!

Prompt 4. Analizando los valores 

show parameter db_recovery_file_dest_size;
show parameter db_recovery_file_dest;
show parameter db_flashback_retention_target;

Pause Presiona enter para continuar...

Prompt Script finalizado. Revisa el archivo anz-e-01-habilitar-fra-ordinario.txt para ver los resultados.
spool off;
exit;