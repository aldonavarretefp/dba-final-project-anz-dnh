--@Autor: Navarrete Zamora Aldo Yael y Diego Ignacio Nuñez Hernandez
--@Fecha creación: 07/06/2024
--@Descripción: Configuracion del modo compartido.

whenever sqlerror exit rollback;

prompt Conectando con sys
connect sys/system as sysdba;


prompt Configurando la instancia para habilitar el modo compartido.

--Configura 2 dispatchers para protocolo TCP

alter system set dispatchers='(dispatchers=4)(protocol=tcp)' scope=memory;

--Configura 5 shared servers
--1 shared process por cada 10 conexiones

alter system set shared_servers=8 scope=memory;


show parameter dispatchers
show parameter shared_servers

prompt Actualizando listener:

-- Registrar nuevamente los servicios con el listener:

alter system register;

-- Mostrando los servicios registrados

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

