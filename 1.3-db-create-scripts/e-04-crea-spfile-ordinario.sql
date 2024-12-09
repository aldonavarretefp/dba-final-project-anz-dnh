--@Autor:          Jorge A. Rodriguez C
--@Fecha creación:  dd/mm/yyyy
--@Descripción: Creación de un SPFILE

Prompt 0. Creando spool
spool anz-e-04-crea-spfile-ordinario.txt

Prompt 1. Conectando como sys empleando archivo de passwords 
--#TODO
connect sys/Hola1234* as sysdba;
--TODO#

Prompt  2. Creando el SPFILE a partir del PFILE
--#TODO
create spfile from pfile;
--TODO#

Prompt 3. verificando su existencia.
--#TODO
!ls -l $ORACLE_HOME/dbs/spfile${ORACLE_SID}.ora
--TODO#

Prompt Listo!

spool off;
exit