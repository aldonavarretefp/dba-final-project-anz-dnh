--@Autor: Navarrete Zamora Aldo Yael, Nuñez Hernandez Diego Ignacio
--@Fecha creación: 07/11/2024
--@Descripción: Detiene y resetea el modo pool

whenever sqlerror exit rollback;

Prompt Conectando como usuario sys...
connect sys/system1 as sysdba

spool s-03-conexion-pool-stop.log

-- Detener el connection pool
Prompt Deteniendo el connection pool...
exec dbms_connection_pool.stop_pool();

-- Resetear los parámetros del connection pool a sus valores por defecto
Prompt Reseteando parámetros del connection pool a sus valores por defecto...
exec dbms_connection_pool.alter_param ('','MAXSIZE','40');
exec dbms_connection_pool.alter_param ('','MINSIZE','4');
exec dbms_connection_pool.alter_param ('','INACTIVITY_TIMEOUT','300');
exec dbms_connection_pool.alter_param ('','MAX_THINK_TIME','120');
exec dbms_connection_pool.restore_defaults();

Prompt Todo listo!
spool off
exit
