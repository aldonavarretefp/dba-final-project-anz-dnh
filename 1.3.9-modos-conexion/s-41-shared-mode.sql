--@Autor: Navarrete Zamora Aldo Yael y Diego Ignacio Nuñez Hernandez
--@Fecha creación: 07/06/2024 TODO:
--@Descripción: Configuracion del modo compartido.

whenever sqlerror exit rollback;

spool s-41-shared-mode.log
prompt Conectando con sys
connect sys/system1 as sysdba;
prompt Configurando la instancia para habilitar el modo compartido.
Prompt Cambiando el número de despachadores y servidores compartidos
alter system set dispatchers='(dispatchers=4)(protocol=tcp)' scope=memory;
alter system set shared_servers=5 scope=memory;
Prompt Mostrando los parámetros de la instancia
show parameter dispatchers
show parameter shared_servers
prompt Actualizando listener:
alter system register;
!lsnrctl services

--Al finalizar, debemos modificar el alias de servicio en network/admin/tnsnames.ora
--para indicar explícitamente el modo compartido
--JRCBDA2_SH =
--(DESCRIPTION =
--(ADDRESS_LIST =
--(ADDRESS = (PROTOCOL = TCP)(HOST = jrc-ora-pc.fi.unam)(PORT = 1521))
--)
--(CONNECT_DATA =
--(SERVICE_NAME = jrcbda2.fi.unam)
--(SERVER=SHARED)
--)
--)

Pause [Enter] Se pudieron visualizar los cambios realizados en el listener y en la configuración de la instancia?...
spool off
exit;
