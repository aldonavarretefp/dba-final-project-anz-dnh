--@Autor: TODO
--@Fecha: TODO
--@Descripción:  TODO

whenever sqlerror exit rollback;

Prompt A. Autenticando como sysdba
connect sys/system1 as sysdba;

col member format a60
set linesize window;

Prompt B. Generando PFILE de respaldo
create pfile from spfile;

Prompt C. Configurando parámetros
alter system set log_archive_max_processes=2 scope=spfile;

Prompt D. Configurando 2 copias, una en el disco 1 y otra en la FRA
define proyecto_final_dir='/unam/bda/proyecto-final'
archive_log_dir='&proyecto_final_dir/archivelogs/FREE/disk_a'
alter system set log_archive_dest_1='LOCATION=&archive_log_dir MANDATORY' scope=spfile;
alter system set log_archive_dest_2='LOCATION=USE_DB_RECOVERY_FILE_DEST' scope=both;

Prompt E. Configurando formato
define log_archive_format = 'arch_naproynu_%t_%s_%r.arc'
alter system set log_archive_format='&log_archive_format' scope=spfile;

Prompt F. Al menos una copia de debe generar 
alter system set log_archive_min_succeed_dest=1 scope=spfile;

Prompt G. Detener/iniciar en modo mount para habilitar el modo archivelog
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
define disk_route = '/unam-bda/archivelogs/BOORPROY/disk_*'
!ls -lh &disk_route

Prompt L. Consultando detalle de los archive redo logs
col name format a70 
select name,dest_id, sequence#,status from v$archived_log;

Prompt Listo!
