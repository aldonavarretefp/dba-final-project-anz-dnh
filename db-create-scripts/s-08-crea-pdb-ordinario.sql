--@Autor:          Jorge A. Rodriguez C
--@Fecha creación:  dd/mm/yyyy
--@Descripción: Creación de una PDB

Prompt Conectando como sys
connect sys/system2 as sysdba

Prompt creando PDB
--#TODO
create pluggable database anzproydnh
  admin user anz_admin identified by anz_admin
  path_prefix = '/opt/oracle/oradata/FREE'
  file_name_convert = ('/pdbseed/', '/anzproydnh/');
--TODO#

Prompt abrir la PDB
--#TODO
alter pluggable database anzproydnh open;
--TODO#

Prompt guardar el estado de la PDB
--#TODO
alter pluggable database anzproydnh save state;
--TODO#