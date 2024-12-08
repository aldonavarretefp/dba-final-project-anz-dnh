--@Autor: Borboa Castillo Carlos Alfonso y Ortiz Rivera Miguel Ángel
--@Fecha creación: 07/06/2024
--@Descripción: Configura modo pool
whenever sqlerror continue none;

Prompt Conectando como usuario sys...
connect sys/system as sysdba

--B. Iniciar un nuevo connection pool. Por default la BD cuenta con un connection pool
--llamado SYS_DEFAULT_CONNECTION_POOL. Ejecutar la siguiente instrucción para
--iniciarlo:

Prompt Iniciando un nuevo connection pool...
exec dbms_connection_pool.start_pool();

--C. Ejecutar la siguiente instrucción para configurar el número mínimo de conexiones
--que serán creadas y almacenadas en el pool mismas que serán empleadas por los
--usuarios. Seleccionar un número N entre 30 y 50.

--El primer parámetro se emplea para indicar el nombre del pool. Debido a que se
--hace uso del pool por default, no se requiere especificar valor alguno.

exec dbms_connection_pool.alter_param ('','MAXSIZE','50');
exec dbms_connection_pool.alter_param ('','MINSIZE','40');

--D. Ejecutar las siguientes instrucciones para configurar los siguientes parámetros:
--● INACTIVITY_TIMEOUT (default 300 segundos) tiempo máximo que puede
--permanecer una conexión en el pool sin ser utilizada. Posterior a este tiempo, el
--server process es terminado y la conexión se elimina del pool.
--● MAX_THINK_TIME (default 120 segundos) Tiempo máximo que puede estar la
--conexión inactiva una vez que se ha asignado a algún usuario. Si dicho usuario no
--ejecuta alguna sentencia dentro de este periodo de tiempo, la conexión se libera del
--usuario, y se regresa al pool. Si el usuario intenta ejecutar una nueva instrucción
--después de este tiempo, obtendrá el error ORA-3113 o ORA-3115.
exec dbms_connection_pool.alter_param ('','INACTIVITY_TIMEOUT','1800');
exec dbms_connection_pool.alter_param ('','MAX_THINK_TIME','1800');

Prompt Todo listo!