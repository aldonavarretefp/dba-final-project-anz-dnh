
connect sys/Hola1234* as sysdba;

startup nomount;

whenever sqlerror exit rollback;

create database free
  user sys identified by system1
  user system identified by system1
  logfile group 1 (
    '/unam/bda/proyecto-final/disk/d01/app/oracle/oradata/FREE/redo01a.log',
    '/unam/bda/proyecto-final/disk/d02/app/oracle/oradata/FREE/redo01b.log',
    '/unam/bda/proyecto-final/disk/d03/app/oracle/oradata/FREE/redo01c.log') size 50m blocksize 512,
  group 2 (
    '/unam/bda/proyecto-final/disk/d01/app/oracle/oradata/FREE/redo02a.log',
    '/unam/bda/proyecto-final/disk/d02/app/oracle/oradata/FREE/redo02b.log',
    '/unam/bda/proyecto-final/disk/d03/app/oracle/oradata/FREE/redo02c.log') size 50m blocksize 512,
  group 3 (
    '/unam/bda/proyecto-final/disk/d01/app/oracle/oradata/FREE/redo03a.log',
    '/unam/bda/proyecto-final/disk/d02/app/oracle/oradata/FREE/redo03b.log',
    '/unam/bda/proyecto-final/disk/d03/app/oracle/oradata/FREE/redo03c.log') size 50m blocksize 512
  maxloghistory 1
  maxlogfiles 16
  maxlogmembers 3
  maxdatafiles 1024
  character set AL32UTF8
  national character set AL16UTF16
  extent management local
    datafile '/opt/oracle/oradata/FREE/system01.dbf'
      size 500m autoextend on next 10m maxsize 9G
  sysaux datafile '/opt/oracle/oradata/FREE/sysaux01.dbf'
    size 300m autoextend on next 10m maxsize 9G
      default tablespace users
  datafile '/opt/oracle/oradata/FREE/users01.dbf'
    size 50m autoextend on next 10m maxsize 9G
      default temporary tablespace tempts1
  tempfile '/opt/oracle/oradata/FREE/temp01.dbf'
    size 20m autoextend on next 1m maxsize 9G
  undo tablespace undotbs1
    datafile '/opt/oracle/oradata/FREE/undotbs01.dbf'
      size 100m autoextend on next 5m maxsize 9G
  enable pluggable database
    seed
    file_name_convert = ('/opt/oracle/oradata/FREE',
                          '/opt/oracle/oradata/FREE/pdbseed')
    system datafiles size 250m autoextend on next 10m maxsize 9G
    sysaux datafiles size 200m autoextend on next 10m maxsize 9G
  local undo on
;

Prompt homologando passwords

alter user sys identified by system1;
alter user system identified by system1;
    
