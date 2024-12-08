--@Autor: Borboa Castillo Carlos Alfonso, Ortiz Rivera Miguel Angel
--@Fecha: 04/06/2024
--@Descripción:  Configurar la BD en modo Archivelog


Prompt A. Autenticando como sysdba
connect sys/system as sysdba

col member format a60
set linesize window

Prompt B. Generando PFILE de respaldo
create pfile from spfile;


Prompt C. Configurando parámetros
alter system set log_archive_max_processes=2 scope=spfile;


Prompt D. Configurando 2 copias 
alter system set log_archive_dest_1='LOCATION=/unam-bda/archivelogs/BOORPROY/disk_a MANDATORY' scope=spfile;
alter system set log_archive_dest_2='LOCATION=USE_DB_RECOVERY_FILE_DEST' scope=both;


Prompt E. Configurando formato
alter system set log_archive_format='arch_boorproy_%t_%s_%r.arc' scope=spfile;


Prompt F. Al menos una copia de debe generar 
alter system set log_archive_min_succeed_dest=1 scope=spfile;


Prompt G. Detener/iniciar en modo mount para habilitar
shutdown immediate
startup mount


Prompt Habilitando el modo archivelog 

alter database archivelog;

Prompt H. Verificando resultados
alter database open;
archive log list


Prompt I.  Creando un nuevo respaldo del SPFILE
create pfile from spfile;


Prompt J.  Provocando un archivado de redo logs
alter system switch logfile;


Prompt K.  Mostrando el contenido de los directorios
!ls -lh /unam-bda/archivelogs/BOORPROY/disk_*


Prompt L. Consultando detalle de los archive redo logs
col name format a70 
select name,dest_id, sequence#,status from v$archived_log;
/*
NAME                                                                      DEST_ID  SEQUENCE# S
---------------------------------------------------------------------- ---------- ---------- -
/unam-bda/archivelogs/BOORPROY/disk_a/arch_boorproy_1_37_1167840359.arc           1         37 A
/unam-bda/archivelogs/BOORPROY/disk_b/arch_boorproy_1_37_1167840359.arc           2         37 A


*/


Prompt Listo!
