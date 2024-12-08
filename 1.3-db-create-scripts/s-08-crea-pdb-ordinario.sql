--@Autor:          Jorge A. Rodriguez C
--@Fecha creación:  dd/mm/yyyy
--@Descripción: Creación de una PDB

Prompt Conectando como sys
connect sys/system2 as sysdba

Prompt creando PDB
--#TODO
create pluggable database naproynu
  admin user anz_admin_dnh identified by anz_admin_dnh
  path_prefix = '/opt/oracle/oradata/FREE'
  file_name_convert = ('/pdbseed/', '/naproynu/');
--TODO#

Prompt abrir la PDB
--#TODO
alter pluggable database naproynu open;
--TODO#

Prompt guardar el estado de la PDB
--#TODO
alter pluggable database naproynu save state;
--TODO#