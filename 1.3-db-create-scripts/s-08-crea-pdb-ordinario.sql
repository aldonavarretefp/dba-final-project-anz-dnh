--@Autor:          Jorge A. Rodriguez C TODO
--@Fecha creación:  dd/mm/yyyy TODO
--@Descripción: Creación de una PDB TODO

whenever sqlerror exit rollback;

Prompt Conectando como sys
connect sys/system1 as sysdba

Prompt creando PDB 1...

create pluggable database naproynu_modulo_1
  admin user anz_admin_dnh identified by anz_admin_dnh
  path_prefix = '/opt/oracle/oradata/FREE'
  file_name_convert = ('/pdbseed/', '/naproynu_modulo_1/');

Prompt abrir la PDB 1...
alter pluggable database naproynu_modulo_1 open;

Prompt guardar el estado de la PDB 1...

alter pluggable database naproynu_modulo_1 save state;

Prompt Creando PDB 2...

create pluggable database naproynu_modulo_2
  admin user anz_admin_dnh identified by anz_admin_dnh
  path_prefix = '/opt/oracle/oradata/FREE'
  file_name_convert = ('/pdbseed/', '/naproynu_modulo_2/');

Prompt abrir la PDB 2...
alter pluggable database naproynu_modulo_2 open;

Prompt guardar el estado de la PDB 2...
alter pluggable database naproynu_modulo_2 save state;

exit;

