--@Autor: Borboa Castillo Carlos Alfonso, Ortiz Rivera Miguel Angel
--@Fecha: 03/06/2024
--@Descripcion: modifica el parámetro control_files con las nuevas rutas y crea 2 miembros de redo log fuera de la FRA

connect sys/system as sysdba

Prompt Iniciando en modo nomount...
startup nomount

set linesize window

show parameter control_files

Prompt Modificando el parámetro control_files...
alter system set control_files='/unam-bda/fast-recovery-area/FREE/controlfile/o1_mf_m5j124ft_.ctl','/unam-bda/d11/app/oracle/oradata/FREE/o1_mf_m5j124ft_.ctl','/unam-bda/d12/app/oracle/oradata/FREE/o1_mf_m5j124ft_.ctl' scope =spfile;
Prompt Listo!

Prompt Reiniciando la base en modo open...
shutdown immediate
startup

Prompt Mostrando el nuevo valor del parámetro control_files:
select * from v$controlfile;

Prompt Multiplexando redologs 

--miembros para el grupo 1
alter database add logfile member '/unam/bda/d11/redo01a.log' to group 1;
alter database add logfile member '/unam/bda/d12/redo01b.log' to group 1;
--miembros para el grupo 2
alter database add logfile member '/unam/bda/d11/redo02a.log' to group 2;
alter database add logfile member '/unam/bda/d12/redo02b.log' to group 2;
--miembros para el grupo 3
alter database add logfile member '/unam/bda/d11/redo03a.log' to group 3;
alter database add logfile member '/unam/bda/d12/redo03b.log' to group 3;

Prompt Mostrando cambios:
select * from v$logfile;